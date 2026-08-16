-- [[
--
-- This is the start of my NVIM journey.
--
-- From my understanding, this is the start point of what nvim will configure when invoking the nvim command on a file or a directory.
--
-- Table Of Contents:
-- 1. initial setup (leader key)
-- 	a. nerd-font toggle
-- 2. core personalization include
-- 3. bootstrap lazy package manager
--
-- ]]

-- 1. leader key setup
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- 1a. [optional] nerd font enablement
vim.g.have_nerd_font = true

-- 2. include core (personal) configuration
require 'core'

-- 3. bootstrap lazy package manager and all the specified plugins
require 'package-manager'


