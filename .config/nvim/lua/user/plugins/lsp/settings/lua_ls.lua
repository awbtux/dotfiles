return {
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim", "jit", "socket" },
            },
            workspace = {
                library = {
                    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                    [vim.fn.stdpath("config") .. "/lua"] = true,
                },
            },
        },
    },
}
