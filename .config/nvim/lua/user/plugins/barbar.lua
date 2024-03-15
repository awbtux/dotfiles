local barbar_status_ok, barbar = pcall(require, "barbar")
if not barbar_status_ok then
    return
end

local icons = require "user.icons"

local opts = {
    -- enable/disable animations
    animation = false,

    -- automatically hide the tabline when there are this many buffers left.
    -- set to any value >=0 to enable.
    auto_hide = false,

    -- enable/disable current/total tabpages indicator (top right corner)
    tabpages = true,

    -- enables/disable clickable tabs
    clickable = true,

    -- a buffer to this direction will be focused (if it exists) when closing the current buffer.
    -- valid options are "left" (the default), "previous", and "right"
    focus_on_close = "left",

    -- disable highlighting alternate buffers
    highlight_alternate = false,

    -- disable highlighting file icons in inactive buffers
    highlight_inactive_file_icons = false,

    -- enable highlighting visible buffers
    highlight_visible = true,

    -- icons
    icons = {
        -- configure the base icons on the bufferline.
        -- valid options to display the buffer index and -number are `true`, "superscript" and "subscript"
        buffer_index = false,
        buffer_number = false,

        -- close button
        button = icons.ui.Close,

        -- enables / disables diagnostic symbols
        diagnostics = {
            [vim.diagnostic.severity.ERROR] = {enabled = false, icon = icons.diagnostics.Error},
            [vim.diagnostic.severity.WARN] = {enabled = false, icon = icons.diagnostics.Warning},
            [vim.diagnostic.severity.INFO] = {enabled = false, icon = icons.diagnostics.Information},
            [vim.diagnostic.severity.HINT] = {enabled = false, icon = icons.diagnostics.Question},
        },

        -- use devicons
        filetype = {
            custom_colors = false,
            enabled = true,
        },

        -- tab separator
        separator = {left = "▎", right = ""},

        -- if true, add an additional separator at the end of the buffer list
        separator_at_end = true,

        -- configure the icons on the bufferline when modified or pinned.
        -- supports all the base icon options.
        modified = {button = icons.ui.Circle},
        pinned = {button = "", filename = true},

        -- use a preconfigured buffer appearance— can be "default", "powerline", or "slanted"
        preset = "default",

        -- configure the icons on the bufferline based on the visibility of a buffer.
        -- supports all the base icon options, plus `modified` and `pinned`.
        alternate = {filetype = {enabled = false}},
        current = {buffer_index = true},
    },

    -- if true, new buffers will be inserted at the start/end of the list.
    -- default is to insert after current buffer.
    insert_at_end = true,
    insert_at_start = false,

    -- sets the maximum padding width with which to surround each tab
    maximum_padding = 1,

    -- sets the minimum padding width with which to surround each tab
    minimum_padding = 1,

    -- sets the maximum buffer name length.
    maximum_length = 36,

    -- sets the minimum buffer name length.
    minimum_length = 0,

    -- if set, the letters for each buffer in buffer-pick mode will be
    -- assigned based on their name. otherwise or in case all letters are
    -- already assigned, the behavior is to assign letters in order of
    -- usability (see order below)
    semantic_letters = false,

    -- set the filetypes which barbar will offset itself for
    sidebar_filetypes = {
        NvimTree = {text = "File Explorer" },
        undotree = {text = "Undo Tree"},
    },

    -- New buffer letters are assigned in this order. This order is
    -- optimal for the qwerty keyboard layout but might need adjustment
    -- for other layouts.
    letters = "asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP",

    -- Sets the name of unnamed buffers. By default format is "[Buffer X]"
    -- where X is the buffer number. But only a static string is accepted here.
    no_name_title = nil,
}

-- unregister bbye buffer close
vim.api.nvim_del_user_command("BufferClose")

barbar.setup(opts)
