vim.api.nvim_create_autocmd({ 'VimEnter' }, {
  group = vim.api.nvim_create_augroup('LazyblockInfoLoader', { clear = true }),
  callback = function()
    local root = vim.fs.root(vim.fn.getcwd(), { 'wp-config.php' })
    if not root then
      return
    end

    -- Variables to store current block info for reload
    local current_block_name = nil
    local current_post_id = nil

    local function get_lazyblocks()
      -- Get current directory
      local cwd = vim.fn.getcwd()

      -- Find all lazyblocks using wp cli with JSON output format
      local cmd_get_blocks =
        string.format('cd %s && wp post list --post_type=lazyblocks --fields=post_name,ID --format=json 2>/dev/null', vim.fn.shellescape(cwd))

      local blocks_handle = io.popen(cmd_get_blocks)
      if not blocks_handle then
        vim.notify('Failed to execute WordPress CLI command', vim.log.levels.ERROR)
        return {}
      end

      local blocks_json = blocks_handle:read('*a'):gsub('%s+$', '')
      blocks_handle:close()

      if blocks_json == '' then
        vim.notify('Failed to retrieve lazyblocks list', vim.log.levels.ERROR)
        return {}
      end

      -- Parse the JSON
      local json_status, blocks = pcall(vim.fn.json_decode, blocks_json)
      if not json_status then
        vim.notify('Failed to parse blocks JSON', vim.log.levels.ERROR)
        return {}
      end

      return blocks
    end

    local function get_block_from_file()
      -- Get current file path
      local current_file = vim.fn.expand '%:p'

      -- Check if the file is in a lazyblock-* directory
      local pattern = '/blocks/lazyblock%-([^/]+)/'
      local block_name = string.match(current_file, pattern)

      return block_name
    end

    local function lazyblock_info(args)
      -- Get block name from argument or current file
      local block_name = args.args

      if block_name == '' then
        block_name = get_block_from_file()
        if not block_name then
          vim.notify('Current file is not in a lazyblock directory and no block name provided', vim.log.levels.WARN)
          return
        end
      end

      -- Get all lazyblocks
      local blocks = get_lazyblocks()
      if not blocks or #blocks == 0 then
        vim.notify('No lazyblocks found', vim.log.levels.ERROR)
        return
      end

      -- Find the block with matching name
      local post_id = nil
      for _, block in ipairs(blocks) do
        if block.post_name == block_name then
          post_id = block.ID
          break
        end
      end

      if not post_id then
        vim.notify('Could not find a lazyblock with name: ' .. block_name, vim.log.levels.ERROR)
        return
      end

      -- Get the controls meta using wp cli
      local cwd = vim.fn.getcwd()
      local cmd_get_meta = string.format('cd %s && wp post meta get %s lazyblocks_controls --format=json 2>/dev/null', vim.fn.shellescape(cwd), post_id)

      local meta_handle = io.popen(cmd_get_meta)
      if not meta_handle then
        vim.notify('Failed to execute WordPress CLI meta command', vim.log.levels.ERROR)
        return
      end

      local meta_json = meta_handle:read '*a'
      meta_handle:close()

      if meta_json == '' then
        vim.notify('No lazyblocks_controls meta found for ID: ' .. post_id, vim.log.levels.ERROR)
        return
      end

      -- Parse the JSON
      local status, controls = pcall(vim.fn.json_decode, meta_json)
      if not status then
        vim.notify('Failed to parse controls JSON: ' .. controls, vim.log.levels.ERROR)
        return
      end

      -- Build a hierarchy map of controls
      local top_level_controls = {}
      local child_controls = {}

      -- First pass - separate top level and child controls
      for id, control in pairs(controls) do
        control.id = id -- Store the control ID for later reference

        if control.child_of and control.child_of ~= '' then
          if not child_controls[control.child_of] then
            child_controls[control.child_of] = {}
          end
          table.insert(child_controls[control.child_of], control)
        else
          table.insert(top_level_controls, control)
        end
      end

      -- Sort controls by label for consistent display
      local function sort_by_label(a, b)
        return (a.label or '') < (b.label or '')
      end

      table.sort(top_level_controls, sort_by_label)
      for _, children in pairs(child_controls) do
        table.sort(children, sort_by_label)
      end

      -- Format and display the controls information
      local lines = {
        'Lazyblock: ' .. block_name,
        'Post ID: ' .. post_id,
        '-------------------------------------------',
        'Fields Summary:',
        '-------------------------------------------',
        '',
      }

      -- Function to display a control and its properties
      local function add_control_info(control, indent_level)
        local indent = string.rep('  ', indent_level)
        local prefix = indent_level == 0 and '🔹 ' or '◦ '

        table.insert(lines, string.format('%s%s%s', indent, prefix, control.label or 'Unnamed'))
        table.insert(lines, string.format('%s  • Name: %s', indent, control.name or ''))
        table.insert(lines, string.format('%s  • Type: %s', indent, control.type or ''))

        if control.required == 'true' then
          table.insert(lines, string.format('%s  • Required: Yes', indent))
        end

        if control.default and control.default ~= '' then
          table.insert(lines, string.format('%s  • Default: %s', indent, control.default))
        end

        if control.help and control.help ~= '' then
          table.insert(lines, string.format('%s  • Help: %s', indent, control.help))
        end

        if control.save_in_meta == 'true' then
          table.insert(lines, string.format('%s  • Saves to Meta: %s', indent, control.save_in_meta_name or ''))
        end

        -- Add additional repeater information
        if control.type == 'repeater' then
          if control.rows_max and control.rows_max ~= '' then
            table.insert(lines, string.format('%s  • Max Rows: %s', indent, control.rows_max))
          end

          -- Add child controls if this is a repeater
          if child_controls[control.id] then
            table.insert(lines, string.format('%s  • Sub Fields:', indent))
            for _, child_control in ipairs(child_controls[control.id]) do
              add_control_info(child_control, indent_level + 1)
            end
          end
        end

        table.insert(lines, '')
      end

      -- Display top level controls and their children
      for _, control in ipairs(top_level_controls) do
        add_control_info(control, 0)
      end

      -- Calculate optimal width based on content
      local max_width = 0
      for _, line in ipairs(lines) do
        max_width = math.max(max_width, vim.fn.strdisplaywidth(line))
      end

      -- Add some padding
      max_width = max_width + 2

      -- Store the current window ID before creating the new window
      local current_win = vim.api.nvim_get_current_win()

      -- Create a new buffer for the sidebar with calculated width
      vim.cmd('vertical rightbelow ' .. max_width .. 'split')
      vim.cmd 'enew'
      local buf = vim.api.nvim_get_current_buf()

      -- Set buffer options
      vim.api.nvim_buf_set_option(buf, 'buftype', 'nofile')
      vim.api.nvim_buf_set_option(buf, 'swapfile', false)
      vim.api.nvim_buf_set_option(buf, 'bufhidden', 'wipe')
      vim.api.nvim_buf_set_option(buf, 'wrap', false) -- Prevent line wrapping
      vim.api.nvim_buf_set_name(buf, 'LazyblockInfo: ' .. block_name)

      -- Disable UI elements in this buffer
      vim.opt_local.number = false -- Disable line numbers
      vim.opt_local.relativenumber = false -- Disable relative line numbers
      vim.opt_local.signcolumn = 'no' -- Disable sign column
      vim.opt_local.cursorline = false -- Disable cursor line highlight
      vim.opt_local.colorcolumn = '' -- Disable color column
      vim.opt_local.foldcolumn = '0' -- Disable fold column
      vim.opt_local.list = false -- Disable listchars

      -- Set the buffer content
      vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

      -- Set it as read-only
      vim.api.nvim_buf_set_option(buf, 'modifiable', false)
      vim.api.nvim_buf_set_option(buf, 'readonly', true)

      -- Set some basic syntax highlighting
      vim.cmd [[
    syntax clear
    syntax match LazyblockTitle /^Lazyblock:.*$/
    syntax match LazyblockID /^Post ID:.*$/
    syntax match LazyblockHeader /^---*$/
    syntax match LazyblockSection /^Fields Summary:$/
    syntax match LazyblockFieldName /^🔹.*$/
    syntax match LazyblockProperty /^\s\+•.*$/
    syntax match LazyblockControlName /^\s\+• Name: \zs.*$/
    
    highlight LazyblockTitle guifg=#88c0d0 gui=bold
    highlight LazyblockID guifg=#81a1c1
    highlight LazyblockHeader guifg=#616e88
    highlight LazyblockSection guifg=#8fbcbb gui=bold
    highlight LazyblockFieldName guifg=#a3be8c gui=bold
    highlight LazyblockProperty guifg=#d8dee9
    highlight LazyblockControlName guifg=#ebcb8b gui=bold
  ]]

      -- Return focus to the original window
      vim.api.nvim_set_current_win(current_win)
    end

    -- Function to provide block name completion
    local function complete_block_names(arg_lead)
      -- Get all lazyblocks
      local blocks = get_lazyblocks()

      -- Filter block names based on the current input
      local matches = {}
      for _, block in ipairs(blocks) do
        -- If arg_lead is empty or the block name starts with arg_lead
        if arg_lead == '' or string.find(block.post_name, '^' .. arg_lead) then
          table.insert(matches, block.post_name)
        end
      end

      return matches
    end

    -- Register the user command with completion
    vim.api.nvim_create_user_command('LazyblockInfo', lazyblock_info, {
      nargs = '?', -- Make arguments optional
      complete = function(arg_lead, _, _)
        return complete_block_names(arg_lead)
      end,
      desc = 'Display information about a LazyBlock (current file or specified)',
    })
  end,
})
