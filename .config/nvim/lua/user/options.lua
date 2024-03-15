local globals = {
    nord_borders = true,
    nord_contrast = true,
    nord_disable_background = false,
    nord_italic = true,
    nord_uniform_diff_background = true,
    nord_bold = true,
    mapleader = " ",
    maplocalleader = " ",
    transparency = false,
    termmodern = true,
    barbar_auto_setup = false,
}

local settings = {
    autoread = true,
    autoindent = true,
    autowrite = true,
    background = "dark",
    backspace = {
        "indent",
        "eol",
        "start",
    },
    backup = false,
    clipboard = "unnamedplus",
    compatible = false,
    completeopt = {
        "menuone",
        "noselect",
    },
    cmdheight = 1,
    cursorline = true,
    conceallevel = 0,
    encoding = "UTF-8",
    errorbells = false,
    expandtab = true,
    exrc = true,
    fileencoding = "UTF-8",
    fileformat = "unix",
    foldenable = false,
    foldlevel = 0,
    foldmethod = "indent",
    foldnestmax = 16,
    go = "a",
    guifont = "monospace:h9",
    hidden = true,
    history = 1024,
    hlsearch = true,
    incsearch = true,
    laststatus = 2,
    lazyredraw = true,
    listchars = "tab:>-,trail:.,extends:>,precedes:<,nbsp:+",
    list = true,
    magic = true,
    mouse = "a",
    number = true,
    numberwidth = 4,
    relativenumber = true,
    pumheight = 10,
    ruler = true,
    scrolloff = 24,
    sessionoptions = {
        "curdir",
        "folds",
        "globals",
        "help",
        "buffers",
        "tabpages",
        "terminal",
        "winsize",
    },
    shell = "/bin/sh",
    shiftround = true,
    shiftwidth = 4,
    showmode = false,
    showtabline = 2,
    sidescrolloff = 12,
    signcolumn = "yes",
    shortmess = "atI",
    smartcase = true,
    smarttab = true,
    softtabstop = 4,
    spelllang = "en_us",
    splitbelow = true,
    splitright = true,
    swapfile = false,
    tabstop = 4,
    termguicolors = true,
    timeoutlen = 300,
    ttimeoutlen = 300,
    undofile = true,
    undolevels = 1024,
    updatetime = 256,
    viminfo = "",
    visualbell = true,
    wildmenu = true,
    wildmode = {
        "longest",
        "list",
        "full",
    },
    wrap = false,
    writebackup = true,
}

-- parse the 'settings' variable as vim options
for k, v in pairs(settings) do
    vim.opt[k] = v
end

-- parse the 'globals' variable as vim options
for k, v in pairs(globals) do
    vim.g[k] = v
end

-- disable termguicolors on framebuffers
if os.getenv('TERM') == "linux" then
    vim.opt.termguicolors = false
    vim.g.termmodern = false
end
