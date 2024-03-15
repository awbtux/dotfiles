local mason_status_ok, mason = pcall(require, "mason")
if not mason_status_ok then
    return
end

local servers = {
    --"als",
    --"arduino_language_server",
    "lua_ls",
    --"awk_ls",
    --"bashls",
    "clangd",
    "nim_langserver",
    --"cssls",
    --"html",
    --"jsonls",
    --"ltex",
    --"luau_lsp",
    --"perlnavigator",
    "pylsp",
    --"rust_analyzer",
    --"sqlls",
    --"taplo",
    "tsserver",
    --"v_analyzer",
    --"vls",
    --"vimls",
    --"yamlls",
}

local opts = {
    ui = {
        border = "none",
        icons = {
            package_installed = "◍",
            package_pending = "◍",
            package_uninstalled = "◍",
        },
    },
    log_level = vim.log.levels.INFO,
    max_concurrent_installers = 4,
}

mason.setup(opts)

local mason_lspconfig_status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_status_ok then
    return
end

mason_lspconfig.setup({
    ensure_installed = servers,
    automatic_installation = true,
})

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
    return
end

for _, server in pairs(servers) do
    server = vim.split(server, "@")[1]

    local opts = {
        on_attach = require("user.plugins.lsp.handlers").on_attach,
        capabilities = require("user.plugins.lsp.handlers").capabilities,
    }

    local require_ok, conf_opts = pcall(require, "user.plugins.lsp.settings." .. server)
    if require_ok then
        opts = vim.tbl_deep_extend("force", conf_opts, opts)
    end

    lspconfig[server].setup(opts)
end

return M
