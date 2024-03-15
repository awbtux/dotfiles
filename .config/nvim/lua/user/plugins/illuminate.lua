local illuminate_status_ok, illuminate = pcall(require, "illuminate")
if not illuminate_status_ok then
    return
end

local opts = {
    providers = {
        'regex',
--        'lsp',
--        'treesitter',
    },

    delay = 100,

    under_cursor = true,
    min_count_to_highlight = 1,
    should_enable = function(bufnr)
        return true
    end,
    case_insensitive_regex = false,

    filetypes_denylist = {
        "mason",
        "harpoon",
        "DressingInput",
        "NeogitCommitMessage",
        "qf",
        "dirbuf",
        "dirvish",
        "minifiles",
        "fugitive",
        "alpha",
        "NvimTree",
        "lazy",
        "NeogitStatus",
        "Trouble",
        "netrw",
        "lir",
        "DiffviewFiles",
        "Outline",
        "Jaq",
        "spectre_panel",
        "toggleterm",
        "DressingSelect",
        "TelescopePrompt",
    },
}

illuminate.configure(opts)
