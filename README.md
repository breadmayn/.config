# Neovim Configuration

A modular Neovim configuration built with the goal of keeping editor
behavior, plugin configuration, languauge specific configuration, and
external tooling separate and easy to reason about.

# Philosophy

The configuration follows general rules:

-   `<nvim>/init.lua` should remain small and only bootstrop the rest of the configuration
-   Core Neovim behavior should not depend on plugins (which is why theres `core/`)
-   Each plugin owns its own configuration
-   Language-server-specific configuration should use Neovim's `ftplugin` system
-   External development tools are installed through Mason when appropriate
-   Plugins should be lazy-loaded when there is a meaningful trigger for doing so

## Structure

```text
~/.config/nvim/
├── init.lua                    -- boot straps the rest of the configuration
│
├── after/
│   └── ftplugin/               -- manages filetype specific settings (vim local options)
│
└── lua/                        -- any other configuration required in lua
    │
    ├── core/
    │   ├── init.lua            -- aggregator pattern for all the files in core/
    │   ├── options.lua         -- my preference of nvim settings
    │   ├── keymaps.lua         -- my preference of keymaps related to default nvim functionality
    │   └── autocmds/           -- autocmds related to default nvim functionality
    │
    ├── plugins/                -- contains all plugin specifications
    │   └── lsp/                -- contains plugin specifications related to lspconfig.nvim
    │       ├── init.lua
    │       ├── keymaps.lua
    │       └── servers/        -- specific language servers enabled in this configuration
    │
    │
    └── package_manager.lua
```

