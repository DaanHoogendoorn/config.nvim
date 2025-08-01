return {
  'yetone/avante.nvim',
  event = 'VeryLazy',
  version = false, -- Never set this value to "*"! Never!
  opts = {
    provider = 'copilot',
    providers = {
      copilot = {
        model = 'gpt-4.1',
      },
    },
    selector = {
      provider = 'snacks',
    },
    input = {
      provider = 'snacks',
      provider_opts = {
        -- Additional snacks.input options
        title = 'Avante Input',
        icon = ' ',
      },
    },
    system_prompt = function()
      local hub = require('mcphub').get_hub_instance()
      return hub and hub:get_active_servers_prompt() or ''
    end,
    custom_tools = function()
      return {
        require('mcphub.extensions.avante').mcp_tool(),
      }
    end,
    mappings = {
      diff = {
        ours = 'gr',
        theirs = 'ga',
      },
    },
  },
  init = function()
    vim.keymap.set({ 'n', 'v' }, '<leader>ad', function()
      if vim.api.nvim_get_mode().mode == 'n' then
        vim.cmd 'normal! ggVG'
      end
      vim.cmd 'AvanteEdit Please add documentation (docblocks) to the selected code'
    end, { desc = 'Add documentation' })
  end,
  -- build = 'make BUILD_FROM_SOURCE=true',
  build = 'make',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'stevearc/dressing.nvim',
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
    'nvim-tree/nvim-web-devicons', -- or echasnovski/mini.icons
    'zbirenbaum/copilot.lua', -- for providers='copilot'
    {
      -- support for image pasting
      'HakonHarnes/img-clip.nvim',
      event = 'VeryLazy',
      opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          -- required for Windows users
          use_absolute_path = true,
        },
      },
    },
  },
}
