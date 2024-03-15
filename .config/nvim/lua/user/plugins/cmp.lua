local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
    return
end

local luasnip_status_ok, luasnip = pcall(require, "luasnip")
if not luasnip_status_ok then
    return
end

local icons = require("user.icons")

require("luasnip/loaders/from_vscode").lazy_load()
luasnip.filetype_extend("typescriptreact", { "html" })

local check_backspace = function()
    local col = vim.fn.col "." - 1
    return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
end

local opts = {
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body) -- For `luasnip` users.
        end,
    },

    mapping = {
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
        ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
        ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
        ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
        ["<C-e>"] = cmp.mapping {
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        },
        -- Accept currently selected item. If none selected, `select` first item.
        -- Set `select` to `false` to only confirm explicitly selected items.
        ["<CR>"] = cmp.mapping.confirm { select = false },
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expandable() then
                luasnip.expand()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif check_backspace() then
                fallback()
            else
                fallback()
            end
        end, {
            "i",
            "s",
        }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, {
            "i",
            "s",
        }),
    },

    formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
            vim_item.kind = icons.kind[vim_item.kind]
            vim_item.menu = ({
                nvim_lsp = "",
                nvim_lua = "",
                luasnip = "",
                buffer = "",
                path = "",
                emoji = "",
            })[entry.source.name]
            if entry.source.name == "copilot" then
                vim_item.kind = icons.git.Octoface
                vim_item.kind_hl_group = "CmpItemKindCopilot"
            end

            if entry.source.name == "cmp_tabnine" then
                vim_item.kind = icons.misc.Robot
                vim_item.kind_hl_group = "CmpItemKindTabnine"
            end

            if entry.source.name == "crates" then
                vim_item.kind = icons.misc.Package
                vim_item.kind_hl_group = "CmpItemKindCrate"
            end

            if entry.source.name == "lab.quick_data" then
                vim_item.kind = icons.misc.CircuitBoard
                vim_item.kind_hl_group = "CmpItemKindConstant"
            end

            if entry.source.name == "emoji" then
                vim_item.kind = icons.misc.Smiley
                vim_item.kind_hl_group = "CmpItemKindEmoji"
            end

            return vim_item
        end,
    },

    sources = {
        {
            name = "nvim-lsp",
            entry_filter = function(entry, ctx)
                local kind = require("cmp.types.lsp").CompletionItemKind[entry:get_kind()]
                if kind == "Snippet" and ctx.prev_context.filetype == "java" then
                    return false
                end

                if ctx.prev_context.filetype == "markdown" then
                    return true
                end

                if kind == "Text" then
                    return false
                end

                return true
            end,
        },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
        { name = "calc" },
        { name = "emoji" },
        --{ name = "cmdline" },
        { name = "treesitter" },
        --{ name = "crates" },
        --{ name = "tmux" },
    },

    confirm_opts = {
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
    },

    window = {
        completion = {
            --winhighlight = "Normal:Pmenu,CursorLine:PmenuSel,FloatBorder:FloatBorder,Search:None",
            --col_offset = -3,
            --side_padding = 1,
            scrollbar = false,
            scrolloff = 8,
        },
        documentation = {
            --winhighlight = "Normal:Pmenu,FloatBorder:FloatBorder,Search:None",
        },
    },

    experimental = {
        ghost_text = false,
        native_menu = false,
    },
}

cmp.setup(opts)

vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })
vim.api.nvim_set_hl(0, "CmpItemKindTabnine", { fg = "#CA42F0" })
vim.api.nvim_set_hl(0, "CmpItemKindCrate", { fg = "#F64D00" })
vim.api.nvim_set_hl(0, "CmpItemKindEmoji", { fg = "#FDE030" })
