require 'config.options'
require 'config.keymaps'
require 'config.autocommands'
require 'config.usercommands'

require 'core.lazy'

require('custom.config.selectquotes').setup {
  key = 'q',
}

require 'custom.config.lazyblock_info'
