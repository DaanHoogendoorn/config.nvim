require 'config.options'
require 'config.keymaps'
require 'config.autocommands'
require 'config.usercommands'

require 'core.lazy'

require('custom.config.selectquotes').setup {
  key = 'q',
}
require 'config.lazyblock_info'
