local alpha_status_ok, alpha = pcall(require, "alpha")
if not alpha_status_ok then
    return
end

local dashboard = require "alpha.themes.dashboard"
local icons = require "user.icons"

local function button(sc, txt, keybind, keybind_opts)
    local b = dashboard.button(sc, txt, keybind, keybind_opts)
    b.opts.hl_shortcut = "Macro"
    return b
end

dashboard.section.header.val = {
    [[    _   __            _    __            ]],
    [[   / | / /___   ____ | |  / /_  ____ ___ ]],
    [[  /  |/ // _ \ / __ \| | / /(_)/ __ `__ \]],
    [[ / /|  //  __// /_/ /| |/ // // / / / / /]],
    [[/_/ |_/ \___/ \____/ |___//_//_/ /_/ /_/ ]],
}

dashboard.section.buttons.val = {
    button("f", icons.ui.Files .. " Find file", ":Telescope find_files find_command=find,-xdev,-maxdepth,6<LF>"),
    button("n", icons.ui.NewFile .. " New file", ":ene<LF>"),
    -- button("s", icons.ui.SignIn .. " Load session", ":lua require('persistence').load()<CR>"),
    button("r", icons.ui.History .. " Recent files", ":Telescope oldfiles<LF>"),
    button("t", icons.ui.Text .. " Find text", ":Telescope live_grep<LF>"),
    button("c", icons.ui.Gear .. " Config", ":e ~/.config/nvim/init.lua<LF>"),
    button("m", icons.ui.Package .. " Manage Packages", ":Lazy<LF>"),
    button("s", icons.kind.Key .. " Manage Language Servers", ":Mason<LF>"),
    button("q", icons.ui.SignOut .. " Quit", ":qa<CR>"),
}

local function footer()
    return "neovim"
end

dashboard.section.footer.val = footer()

dashboard.section.header.opts.hl = "String"
dashboard.section.buttons.opts.hl = "Macro"
dashboard.section.footer.opts.hl = "Type"

dashboard.opts.opts.noautocmd = true

alpha.setup(dashboard.opts)

vim.api.nvim_create_autocmd("User", {
    pattern = "LazyVimStarted",
    callback = function()
        local stats = require("lazy").stats()
        local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
        dashboard.section.footer.val = "Loaded " .. stats.count .. " plugins in " .. ms .. "ms"
        pcall(vim.cmd.AlphaRedraw)
    end,
})
