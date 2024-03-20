local install_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- install lazy.nvim if we don't have it
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    print("Installing folke/lazy.nvim (plugin manager)... ")
    Bootstrapped = vim.fn.system({
        "git",
        "clone",
        "--depth",
        "1",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim",
        install_path,
    })
end

-- add lazy.nvim to the runtime path
vim.opt.rtp:prepend(install_path)

local plugins = {
    -- lsp stuff
    --require("user.plugins.lsp"),

    -- tab / buffer line
    --{ "romgrk/barbar.nvim",
    --    event = {
    --        "BufReadPost",
    --        "BufNewFile",
    --        "BufWrite",
    --    },
    --    dependencies = {
    --        "nvim-tree/nvim-web-devicons",
    --    },
    --    config = function()
    --        require "user.plugins.barbar"
    --    end,
    --},

    -- splash screen
    { "goolord/alpha-nvim",
        event = "VimEnter",
        config = function()
            require "user.plugins.alpha"
        end,
    },

    -- preview hex color codes
    { "NvChad/nvim-colorizer.lua",
        event = {
            "BufReadPost",
            "BufNewFile",
            "BufWrite",
        },
        opts = {
            user_default_options = {
                RGB      = true,
                RRGGBB   = true,
                names    = false,
                RRGGBBAA = true,
                rgb_fn   = true,
                hsl_fn   = true,
                css      = false,
                css_fn   = false,
                mode     = 'background',
            }
        },
    },

    -- tabs can be used as workspaces
    { "tiagovla/scope.nvim",
        lazy = false,
        config = function()
            require("scope").setup(nil)
        end,
    },

    -- completion/snippets
    { "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-calc",
            "hrsh7th/cmp-emoji",
            "hrsh7th/cmp-nvim-lsp",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            "rafamadriz/friendly-snippets",
        },
        event = "InsertEnter",
        config = function()
            require "user.plugins.cmp"
        end,
    },

    -- language icons
    "nvim-tree/nvim-web-devicons",

    -- highlight current word
    { "RRethy/vim-illuminate",
        event = {
            "BufReadPost",
            "BufNewFile",
            "BufWrite",
        },
        config = function()
            require "user.plugins.illuminate"
        end,
    },

    -- file manager pane
    { "nvim-tree/nvim-tree.lua",
        cmd = {
            "NvimTreeToggle",
            "NvimTreeOpen",
            "NvimTreeClose",
            "NvimTreeRefresh",
            "NvimTreeFindFile",
            "NvimTreeFindFileToggle",
        },
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require "user.plugins.nvimtree"
        end,
    },

    -- file/fuzzy finder
    { "nvim-telescope/telescope.nvim",
        dependencies = {
            { "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
                lazy = true,
            },
            "nvim-lua/plenary.nvim",
            "nvim-lua/popup.nvim",
        },
        cmd = "Telescope",
        config = function()
            require "user.plugins.telescope"
        end,
    },

    -- terminal popup window
    { "akinsho/toggleterm.nvim",
        cmd = "ToggleTerm",
        config = function()
            require "user.plugins.toggleterm"
        end,
    },

    -- status line
    --{ "nvim-lualine/lualine.nvim",
    --    event = {
    --        "BufRead",
    --        "BufNewFile",
    --    },
    --    config = function()
    --        require "user.plugins.lualine"
    --    end,
    --},

    { "ojroques/nvim-hardline",
        event = {
            "VimEnter",
        },
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require "user.plugins.hardline"
        end,
    },

    -- self explanatory
    --{ "windwp/nvim-autopairs",
    --    event = {
    --        "BufReadPost",
    --        "BufNewFile",
    --        "BufWrite",
    --    },
    --    config = function()
    --        require "user.plugins.autopairs"
    --    end,
    --},

    -- vscode-like indent indicator
    { "lukas-reineke/indent-blankline.nvim",
        event = {
            "BufReadPost",
            "BufNewFile",
            "BufWrite",
        },
        main = "ibl",
        config = function()
            require "user.plugins.indentline"
        end,
    },

    -- treesitter syntax highlighting
    { "nvim-treesitter/nvim-treesitter",
        cmd = {
            "TSUpdate",
            "TSUpdateSync",
            "TSToggle",
            "TSInstall",
        },
        event = {
            "BufReadPost",
            "BufNewFile",
            "BufWrite",
        },
        build = ":TSUpdate",
        config = function()
            require "user.plugins.treesitter"
        end,
    },
}

local opts = {
    -- plugin install dir
    root = vim.fn.stdpath("data") .. "/lazy",
    lockfile = vim.fn.stdpath("data") .. "/lazy-lock.json", -- lockfile generated after running update.

    defaults = {
        lazy = true,
        version = "*",
        cond = nil,
    },

    -- leave nil when passing the spec as the first argument to setup()
    --spec = LAZY_PLUGIN_SPEC, ---@type LazySpec

    git = {
        log = { "-8" },
        timeout = 120,
        url_format = "https://github.com/%s.git",
        filter = true, -- set to false to ease  git >=2.19.0 dependency
    },

    install = {
        missing = true,
        colorscheme = { "default" },
    },

    ui = {
        size = { width = 0.8, height = 0.8 },
        wrap = true,
        border = "single",
        title_pos = "center", ---@type "center" | "left" | "right"
        pills = true, ---@type boolean
        throttle = 20, -- how frequently should the ui process render events
    },

    diff = {
        -- diff command <d> can be one of:
        -- * browser: opens the github compare view. Note that this is always mapped to <K> as well,
        --   so you can have a different command for diff <d>
        -- * git: will run git diff and open a buffer with filetype git
        -- * terminal_git: will open a pseudo terminal with git diff
        -- * diffview.nvim: will open Diffview to show the diff
        cmd = "git",
    },

    checker = {
        -- automatically check for plugin updates
        enabled = false,
        concurrency = nil, ---@type number? set to 1 to check for updates very slowly
        notify = true, -- get a notification when new updates are found
        frequency = 3600, -- check for updates every hour
        check_pinned = false, -- check for pinned packages that can't be updated
    },

    change_detection = {
        -- automatically check for config file changes and reload the ui
        enabled = false,
        notify = false, -- get a notification when changes are found
    },

    performance = {
        cache = {
            enabled = true,
        },
        reset_packpath = true, -- reset the package path to improve startup time
        rtp = {
            reset = true, -- reset the runtime path to $VIMRUNTIME and your config directory
            paths = {},
            disabled_plugins = {
                "2html_plugin",
                "tohtml",
                "getscript",
                "getscriptPlugin",
                "logipat",
                "matchit",
                "tar",
                "tarPlugin",
                "man",
                "rrhelper",
                "spellfile_plugin",
                "netrw",
                "netrwPlugin",
                "vimball",
                "vimballPlugin",
                "zip",
                "zipPlugin",
                "tutor",
                "rplugin",
                "syntax",
                "synmenu",
                "optwin",
                "compiler",
                "bugreport",
                "ftplugin",
            },
        },
    },

    -- lazy can generate helptags from the headings in markdown readme files,
    -- so :help works even for plugins that don't have vim docs.
    -- when the readme opens with :help it will be correctly displayed as markdown
    readme = {
        enabled = false,
        root = vim.fn.stdpath("state") .. "/lazy/readme",
        files = { "README.md", "lua/**/README.md" },
        skip_if_doc_exists = true,
    },

    state = vim.fn.stdpath("state") .. "/lazy/state.json", -- state info for checker and other things

    build = {
        warn_on_override = true,
    },

    profiling = {
        -- Enables extra stats on the debug tab related to the loader cache.
        -- Additionally gathers stats about all package.loaders
        loader = false,
        -- Track each new require in the Lazy profiling tab
        require = true,
    },
}

-- try to require lazy.nvim
local lazy_status_ok, lazy = pcall(require, "lazy")
if not lazy_status_ok then
    return
end

lazy.setup(plugins, opts)
