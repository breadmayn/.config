-- [[
-- init.lua
--
-- This is the starting point of nvim loading
--
-- This file will orchestrate the different parts of the NVIM setup specified in this repo
--
-- ]]

-- 1. leader key setup
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- 1a. [optional] nerd font enablement
vim.g.have_nerd_font = true

-- 2. include core (personal) configuration
require("core")

-- 3. bootstrap lazy package manager and all the specified plugins
require("package_manager")

