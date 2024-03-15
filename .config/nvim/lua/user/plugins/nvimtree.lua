local nvimtree_status_ok, nvimtree = pcall(require, "nvim-tree")
if not nvimtree_status_ok then
    return
end

local function my_on_attach(bufnr)
    local api = require "nvim-tree.api"

    local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    api.config.mappings.default_on_attach(bufnr)

    vim.keymap.set("n", "l", api.node.open.edit, opts "Open")
    vim.keymap.set("n", "h", api.node.navigate.parent_close, opts "Close Directory")
    vim.keymap.set("n", "v", api.node.open.vertical, opts "Open: Vertical Split")
    vim.keymap.del("n", "<C-k>", { buffer = bufnr })
    vim.keymap.set("n", "<S-k>", api.node.open.preview, opts "Open Preview")
end

local user_icons = require "user.icons"

local opts = {
    on_attach = my_on_attach,
    sync_root_with_cwd = true,
    hijack_cursor = true,
    disable_netrw = true,
    hijack_netrw = true,
    hijack_unnamed_buffer_when_opening = false,

    renderer = {
        add_trailing = false,
        group_empty = false,
        highlight_git = false,
        full_name = false,
        highlight_opened_files = "none",
        root_folder_label = ":t",
        indent_width = 4,

        indent_markers = {
            enable = false,
            inline_arrows = true,

            icons = {
                corner = "└",
                edge = "│",
                item = "│",
                none = " ",
            },
        },

        icons = {
            show = {
                file = true,
                folder = true,
                folder_arrow = true,
                git = false,
            },

            git_placement = "before",
            padding = " ",

            glyphs = {
                default = user_icons.ui.Text,
                symlink = user_icons.ui.FileSymlink,
                bookmark = user_icons.ui.BookMark,

                folder = {
                    arrow_closed = user_icons.ui.ChevronRight,
                    arrow_open = user_icons.ui.ChevronShortDown,
                    default = user_icons.ui.Folder,
                    open = user_icons.ui.FolderOpen,
                    empty = user_icons.ui.EmptyFolder,
                    empty_open = user_icons.ui.EmptyFolderOpen,
                    symlink = user_icons.ui.FolderSymlink,
                    symlink_open = user_icons.ui.FolderOpen,
                },

                git = {
                    unstaged = user_icons.git.FileUnstaged,
                    staged = user_icons.git.FileStaged,
                    unmerged = user_icons.git.FileUnmerged,
                    renamed = user_icons.git.FileRenamed,
                    untracked = user_icons.git.FileUntracked,
                    deleted = user_icons.git.FileDeleted,
                    ignored = user_icons.git.FileIgnored,
                },
            },
        },

        special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
        symlink_destination = false,
    },

    git = {
        enable = false,
        ignore = true,
    },

    filesystem_watchers = {
        enable = true,
    },

    update_focused_file = {
        enable = true,
        debounce_delay = 15,
        update_root = true,
        ignore_list = {},
    },

    diagnostics = {
        enable = true,
        show_on_dirs = false,
        show_on_open_dirs = true,
        debounce_delay = 50,

        severity = {
            min = vim.diagnostic.severity.HINT,
            max = vim.diagnostic.severity.ERROR,
        },

        icons = {
            hint = user_icons.diagnostics.Hint,
            info = user_icons.diagnostics.Information,
            warning = user_icons.diagnostics.Warning,
            error = user_icons.diagnostics.Error,
        },
    },

    view = {
        adaptive_size = true,
        side = "left",
        --width = 40,
        preserve_window_proportions = true,
    },
}

nvimtree.setup(opts)
