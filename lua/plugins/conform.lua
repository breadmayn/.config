-- [[
-- 
-- This file will import conform.nvim and include our configurations of the plugin
--
-- Conform is a plugin used to hook in formatters for ease of use during development
--
-- ]]

return {
    'stevearc/conform.nvim',
    opts = {
        formatters_by_ft = {
            lua = { 'stylua' },
        },
    },

    -- keymaps for conform.nvim
    keys = {
        {
            '<leader>f',
            function()
                require('conform').format()
            end,
            desc = '[F]ormat current buffer',
        },
    },
}

