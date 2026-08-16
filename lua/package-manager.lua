-- [[
--
-- This is the aggregator of all of the plugin/plugin configuration we have in this parent directory
--
-- In order for all the plugins to work, there is a dependency with lazy.nvim which is our lazy package manager.
-- We will bootstrap this here first
-- 
-- ]]

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim' -- ~/.local/share/nvim/lazy/lazy.nvim

-- install lazy.nvim if not already present on disk
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = 'https://github.com.folke/lazy.nvim.git'

    -- run external command:
    -- [[
    -- git clone \
    --      --filter=blob:none \
    --      --branch=stable \
    --      https://github.com.folke/lazy.nvim.git
    --      ~/.local/share/nvim/lazy/lazy.nvim
    -- ]]
    local output = vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        '--branch=stable',
        lazyrepo,
        lazypath,
    })

    -- error handle failed git clone
    if vim.v.shell_error ~= 0 then
        error('Failed to clone lazy.nvim:\n' .. output)
    end
end

-- NVIM needs to know that this dir contains runtime files that it can load
-- note: rtp = runtimepath
vim.opt.rtp:prepend(lazypath)

-- now require lazy plugin during nvim boot
require('lazy').setup({
    spec = {
        { import = 'plugins' },
    },
})
