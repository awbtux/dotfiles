local navic_status_ok, navic = pcall(require, "nvim-navic")
if not navic_status_ok then
    return
end

local icons = require "user.icons"

local opts = {
    icons = icons.kind,
    highlight = true,
    lsp = {
        auto_attach = true,
    },
    click = true,
    separator = " " .. icons.ui.ChevronRight .. " ",
    depth_limit = 0,
    depth_limit_indicator = "..",
}

navic.setup(opts)
