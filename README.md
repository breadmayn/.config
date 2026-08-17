# Neovim Configuration

A modular Neovim configuration built with the goal of keeping editor
behavior, plugin configuration, language-specific configuration, and
external tooling separate and easy to reason about.

## Philosophy

The configuration follows a few general rules:

-   `init.lua` should remain small and only bootstrap the rest of the
    configuration.
-   Core Neovim behavior should not depend on plugins.
-   Each plugin owns its own configuration.
-   Language-server-specific configuration should be separate from
    shared LSP behavior.
-   Language-specific editor behavior should use Neovim's `ftplugin`
    system.
-   External development tools are installed through Mason when
    appropriate.
-   Plugins should be lazy-loaded when there is a meaningful trigger for
    doing so.

The goal is to make it possible to answer:

> "Where would I change this behavior?"

without having to search through the entire configuration.

## Structure

``` text
~/.config/nvim/
├── init.lua
│
├── after/
│   └── ftplugin/
│       └── lua.lua
│
└── lua/
    ├── autocmds/
    │   ├── init.lua
    │   └── yank_highlight.lua
    │
    ├── core/
    │   ├── init.lua
    │   ├── options.lua
    │   └── keymaps.lua
    │
    ├── lsp/
    │   └── lua_ls.lua
    │
    ├── plugins/
    │   ├── conform.lua
    │   ├── lazydev.lua
    │   ├── lsp.lua
    │   ├── mason.lua
    │   ├── telescope.lua
    │   └── treesitter.lua
    │
    └── package_manager.lua
```

## Startup

The root `init.lua` is intentionally kept small.

Its responsibility is to establish configuration that must exist early
during startup and then delegate to the rest of the configuration.

Conceptually:

``` text
init.lua
   │
   ├── global startup settings
   │     └── leader keys
   │
   ├── core
   │     └── Neovim behavior
   │
   ├── autocmds
   │     └── event-driven Neovim behavior
   │
   └── package_manager
         └── plugins
```

Keeping the entry point small makes the startup path easier to
understand.

------------------------------------------------------------------------

## `lua/core/`

Contains behavior belonging to **Neovim itself**, rather than to a
particular plugin.

``` text
core/
├── init.lua
├── options.lua
└── keymaps.lua
```

### `core/init.lua`

Loads the individual core configuration modules.

### `core/options.lua`

Contains global editor defaults such as indentation behavior and other
`vim.opt` settings.

These are defaults and may later be overridden for individual filetypes
or by project configuration.

### `core/keymaps.lua`

Contains global mappings that do not depend on a plugin.

Plugin-specific mappings should generally live with the plugin that
provides the functionality.

For example:

``` text
normal Vim mapping
    → core/keymaps.lua

Telescope mapping
    → plugins/telescope.lua

LSP mapping
    → plugins/lsp.lua
```

This prevents `core/keymaps.lua` from becoming coupled to installed
plugins.

------------------------------------------------------------------------

## `after/ftplugin/`

Contains filetype-specific editor behavior.

For example:

``` text
after/ftplugin/lua.lua
```

is loaded for Lua buffers and can override the global defaults from
`core/options.lua`.

This provides the hierarchy:

``` text
global editor defaults
        ↓
core/options.lua
        ↓
filetype defaults
        ↓
after/ftplugin/<filetype>.lua
        ↓
project configuration
```

This is useful for settings such as:

``` text
tabstop
shiftwidth
softtabstop
expandtab
```

which often vary between languages.

Project `.editorconfig` files can provide additional project-specific
editor settings.

------------------------------------------------------------------------

## `lua/plugins/`

Contains Lazy plugin specifications.

Each plugin should generally have its own file:

``` text
plugins/
├── conform.lua
├── lazydev.lua
├── lsp.lua
├── mason.lua
├── telescope.lua
└── treesitter.lua
```

These files answer:

> "How is this plugin installed, loaded, and configured?"

Plugin-specific keymaps should generally live here as well.

------------------------------------------------------------------------

## Plugin Management --- lazy.nvim

`lazy.nvim` manages Neovim plugins.

The Lazy bootstrap and plugin discovery live behind:

``` text
lua/package_manager.lua
```

Plugins may declare explicit loading triggers such as:

``` lua
cmd = "SomeCommand"
```

or:

``` lua
keys = {
    { "<leader>x", ... },
}
```

These allow Lazy to know about a command or mapping without loading the
plugin immediately.

For example:

``` text
Neovim starts
      ↓
Telescope unloaded
      ↓
<leader>ff registered by Lazy
      ↓
user presses <leader>ff
      ↓
Telescope loads
      ↓
picker executes
```

Not every plugin should necessarily be lazy-loaded. Loading behavior
should follow the requirements of the plugin rather than being an
objective by itself.

------------------------------------------------------------------------

## Tool Management --- Mason

Mason manages external development tools used by Neovim.

This is different from Lazy:

``` text
Lazy
  ↓
Neovim plugins

Mason
  ↓
external executables
```

Examples include:

``` text
lua-language-server
stylua
clangd
clang-format
```

Mason allows these tools to be installed in Neovim's data directory
instead of requiring every development tool to be installed globally on
the machine.

------------------------------------------------------------------------

# Formatting

Formatting is handled by:

``` text
Conform
   ↓
external formatter
```

For Lua:

``` text
Conform
   ↓
StyLua
```

Conform does not format Lua itself. It determines which formatter should
handle the current buffer and invokes that formatter.

This keeps formatting orchestration separate from formatter
implementation.

For example:

``` text
Lua       → StyLua
C/C++     → clang-format
Python    → formatter chosen later
```

StyLua is installed through Mason.

Formatting is currently invoked explicitly rather than automatically on
save.

------------------------------------------------------------------------

# Treesitter

Treesitter provides **syntactic understanding** of source files.

``` text
source code
    ↓
Treesitter parser
    ↓
syntax tree
```

For example, Treesitter understands that source code contains constructs
such as:

``` text
function declarations
identifiers
expressions
parameters
return statements
```

This structural information can be used for syntax highlighting and
other syntax-aware editor functionality.

Treesitter should not be confused with LSP.

``` text
Treesitter
    → syntax / structure

LSP
    → semantic meaning
```

------------------------------------------------------------------------

# LSP

Neovim contains a built-in Language Server Protocol client.

Language servers provide semantic understanding of source code.

For Lua:

``` text
Lua source
    ↓
lua-language-server
    ↓
Neovim LSP client
```

This enables functionality such as:

``` text
go to definition
find references
hover documentation
rename
code actions
diagnostics
completion information
```

`nvim-lspconfig` provides standard server configurations used by
Neovim's built-in LSP client.

`mason-lspconfig.nvim` connects Mason-installed language servers with
these Neovim LSP configurations.

------------------------------------------------------------------------

## Shared LSP behavior

Shared LSP behavior lives in:

``` text
plugins/lsp.lua
```

An `LspAttach` autocommand creates buffer-local mappings whenever a
language server attaches:

``` text
LSP attaches
     ↓
LspAttach event
     ↓
configure that buffer
     ↓
LSP mappings become available
```

Because the mappings are buffer-local, LSP-specific mappings only exist
where LSP functionality is actually available.

The same behavior can therefore work for multiple language servers:

``` text
Lua      → lua_ls
C/C++    → clangd
Python   → future server
              │
              ↓
       shared LspAttach
```

------------------------------------------------------------------------

## Server-specific LSP configuration

Language-server-specific configuration is separated from the shared LSP
infrastructure:

``` text
lua/lsp/
└── lua_ls.lua
```

For example:

``` text
plugins/lsp.lua
      ↓
vim.lsp.config("lua_ls", ...)
      ↓
lsp/lua_ls.lua
```

`plugins/lsp.lua` therefore answers:

> How does LSP work in this editor?

while:

``` text
lsp/lua_ls.lua
```

answers:

> How should LuaLS specifically behave?

Additional servers that require custom configuration can follow the same
pattern:

``` text
lsp/
├── lua_ls.lua
├── clangd.lua
└── ...
```

A separate file is not necessary when the default LSP configuration is
sufficient.

------------------------------------------------------------------------

# LazyDev

LazyDev improves the Lua development environment used for editing the
Neovim configuration itself.

It works alongside `lua_ls` to provide additional workspace/library
knowledge for Neovim plugins and Lua modules.

Conceptually:

``` text
Lua config
    ↓
lua_ls
    ↑
LazyDev provides additional library knowledge
```

LuaLS-specific settings still belong in:

``` text
lsp/lua_ls.lua
```

LazyDev does not replace LuaLS.

------------------------------------------------------------------------

# Telescope

Telescope provides interactive fuzzy-finding and selection interfaces.

Current uses include:

``` text
find files
search project text
find buffers
search help
```

Telescope can also act as a UI for LSP results.

For example:

``` text
gd
 ↓
Telescope
 ↓
Neovim LSP client
 ↓
language server
 ↓
definition results
 ↓
Telescope picker
```

The important distinction is:

``` text
LSP
    → determines where definitions/references are

Telescope
    → presents those results interactively
```

Telescope does not provide language intelligence itself.

------------------------------------------------------------------------

# Completion

Completion is provided by `blink.cmp`.

The completion pipeline is:

``` text
language server
      ↓
Neovim LSP client
      ↓
blink.cmp
      ↓
completion menu
```

Blink can gather completion candidates from several sources:

``` text
LSP
buffer
filesystem paths
snippets
```

For example, while editing Lua:

``` lua
vim.api.nvim_
```

LuaLS understands the available Neovim API members and Blink presents
those completion candidates.

Again, responsibilities remain separate:

``` text
lua_ls
    → knows what completions are valid

blink.cmp
    → presents and manages completion
```

------------------------------------------------------------------------

# Current Architecture

The major pieces currently fit together like this:

``` text
                         Neovim
                            │
        ┌───────────────────┼────────────────────┐
        │                   │                    │
        ↓                   ↓                    ↓
     Editing             Parsing              Search/UI
        │                   │                    │
core/options.lua       Treesitter            Telescope
core/keymaps.lua
autocmds/*
after/ftplugin/*

                            │
                            │
                    Language Intelligence
                            │
                         lua_ls
                            │
              ┌─────────────┼─────────────┐
              ↓             ↓             ↓
          diagnostics    navigation   completion data
                            │             │
                            ↓             ↓
                       Telescope      blink.cmp


                      Formatting
                           │
                        Conform
                           │
                         StyLua
```

Supporting infrastructure:

``` text
Lazy
    → installs/manages Neovim plugins

Mason
    → installs/manages external development tools
```

------------------------------------------------------------------------

# Configuration Ownership

When adding functionality, first determine who should own it.

  Behavior                              Location
  ------------------------------------- ---------------------------------
  Global Neovim option                  `core/options.lua`
  Global Neovim keymap                  `core/keymaps.lua`
  Global event-driven Neovim behavior   `autocmds/<behavior>.lua`
  Filetype-specific editor behavior     `after/ftplugin/<filetype>.lua`
  Plugin installation/configuration     `plugins/<plugin>.lua`
  Plugin-specific keymap                `plugins/<plugin>.lua`
  Shared LSP behavior                   `plugins/lsp.lua`
  Server-specific LSP settings          `lsp/<server>.lua`
  Project editor conventions            `.editorconfig`
  Formatter-specific project rules      formatter configuration

The goal is not to create a file for every possible concern. New modules
should be introduced when they create a meaningful ownership boundary.

------------------------------------------------------------------------

# Guiding Principle

Prefer understanding and explicit ownership over adding abstractions.

A configuration should be easy to trace:

``` text
"What happens when I press this?"
"What loaded this plugin?"
"Who installed this executable?"
"Why does this language behave differently?"
"Where is this language server configured?"
```

If answering one of those questions requires searching through many
unrelated files, the configuration likely needs a clearer ownership
boundary.
