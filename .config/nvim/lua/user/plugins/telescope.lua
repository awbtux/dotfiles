local telescope_status_ok, telescope = pcall(require, "telescope")
if not telescope_status_ok then
    return
end

local actions = require("telescope.actions")
local builtin = require("telescope.builtin")
local config = require("telescope.config")

local opts = {
    defaults = {
        vimgrep_arguments = {
            "rg",
            "-L",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
        },

        color_devicons = true,
        border = true,
        borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
        entry_prefix = "  ",
        prompt_prefix = "  ",
        selection_caret = "  ",
        initial_mode = "insert",
        scroll_strategy = "cycle",
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",

        mappings = {
            i = {
                ["<C-h>"] = "which_key",
                ["<C-u>"] = false,
            },
            n = {
                [ "q" ] = actions.close,
            }
        },

        layout_config = {
            horizontal = {
                prompt_position = "top",
                preview_width = 0.6,
                results_width = 0.8,
            },
            vertical = {
                mirror = false,
            },
            width = 0.75,
            height = 0.8,
            preview_cutoff = 120,
        },
    },

    pickers = {
        -- Default configuration for builtin pickers goes here:
        -- picker_name = {
        --   picker_config_key = value,
        --   ...
        -- }
        -- Now the picker_config_key will be applied every time you call this
        -- builtin picker
    },

    extensions = {
        fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
        }
    }
}

-- misc config
telescope.setup(opts)

-- extensions
telescope.load_extension("fzf")
telescope.load_extension("scope")
