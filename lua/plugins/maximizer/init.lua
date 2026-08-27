-- [[
--
-- lua/plugins/maximizer/init.lua
--
-- Maximize is a plugin that focuses the current Neovim window and restore its previous layout
--
-- ]]

return {
  'szw/vim-maximizer',

  keys = require('plugins.maximizer.keymaps'),
}

