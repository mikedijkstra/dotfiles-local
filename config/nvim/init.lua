vim.o.runtimepath = vim.o.runtimepath .. ',~/.vim,~/.vim/after'
vim.o.packpath = vim.o.runtimepath
vim.cmd('source ~/.vimrc')

local status, cmp = pcall(require, "cmp")
if (not status) then return end
local lspkind = require 'lspkind'

vim.cmd.colorscheme("night-owl")

-- Tree Sitter
cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true
    }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'buffer' },
  }),
  formatting = {
    format = lspkind.cmp_format({ with_text = false, maxwidth = 50 })
  }
})

vim.cmd [[
  set completeopt=menuone,noinsert,noselect
  highlight! default link CmpItemKind CmpItemMenuDefault
]]

-- Tree Sitter
local status, ts = pcall(require, "nvim-treesitter.configs")
if (not status) then return end

ts.setup {
  highlight = {
    enable = true,
    disable = {},
  },
  indent = {
    enable = true,
    disable = {},
  },
  ensure_installed = {
    --"tsx",
    "toml",
    "fish",
    "php",
    "json",
    "yaml",
    "swift",
    "css",
    "html",
    "lua",
    "typescript",
    "javascript",
    "markdown",
    "markdown_inline"
  },
  autotag = {
    enable = true,
  },
}

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }


-- Autopairs
local status, autopairs = pcall(require, "nvim-autopairs")
if (not status) then return end

autopairs.setup({
  disable_filetype = { "TelescopePrompt" , "vim" },
})

-- Telescope
local status, telescope = pcall(require, "telescope")
if (not status) then return end
local actions = require('telescope.actions')
local builtin = require("telescope.builtin")

local function telescope_buffer_dir()
  return vim.fn.expand('%:p:h')
end

local fb_actions = require "telescope".extensions.file_browser.actions

telescope.setup {
  defaults = {
    mappings = {
      n = {
        ["q"] = actions.close
      },
    },
  },
}

-- keymaps
vim.keymap.set('n', ';f',
  function()
    builtin.find_files({
      no_ignore = false,
      hidden = true
    })
  end)
vim.keymap.set('n', ';r', function()
  builtin.live_grep()
end)
vim.keymap.set('n', '\\\\', function()
  builtin.buffers()
end)
vim.keymap.set('n', ';t', function()
  builtin.help_tags()
end)
vim.keymap.set('n', ';;', function()
  builtin.resume()
end)
vim.keymap.set('n', ';e', function()
  builtin.diagnostics()
end)

telescope.setup {
  defaults = {
    mappings = {
      n = {
        ["q"] = actions.close
      },
    },
  },
  extensions = {
    file_browser = {
      theme = "dropdown",
      -- disables netrw and use telescope-file-browser in its place
      hijack_netrw = true,
      mappings = {
        -- your custom insert mode mappings
        ["i"] = {
          ["<C-w>"] = function() vim.cmd('normal vbd') end,
        },
        ["n"] = {
          -- your custom normal mode mappings
          ["N"] = fb_actions.create,
          ["h"] = fb_actions.goto_parent_dir,
          ["/"] = function()
            vim.cmd('startinsert')
          end
        },
      },
    },
  },
}
telescope.load_extension("file_browser")

vim.keymap.set("n", "sf", function()
  telescope.extensions.file_browser.file_browser({
    path = "%:p:h",
    cwd = telescope_buffer_dir(),
    respect_gitignore = false,
    hidden = true,
    grouped = true,
    previewer = false,
    initial_mode = "normal",
    layout_config = { height = 40 }
  })
end)

-- lspsaga
local status, saga = pcall(require, "lspsaga")
if (not status) then return end

saga.setup {
  server_filetype_map = {
    typescript = 'typescript'
  }
}

local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<C-j>', '<Cmd>Lspsaga diagnostic_jump_next<CR>', opts)
vim.keymap.set('n', 'K', '<Cmd>Lspsaga hover_doc<CR>', opts)
vim.keymap.set('n', 'gd', '<Cmd>Lspsaga lsp_finder<CR>', opts)
vim.keymap.set('n', '<C-k>', '<Cmd>Lspsaga show_line_diagnostics<CR>', opts)
vim.keymap.set('i', '<C-k>', '<Cmd>Lspsaga signature_help<CR>', opts)
vim.keymap.set('n', 'gp', '<Cmd>Lspsaga preview_definition<CR>', opts)
vim.keymap.set('n', 'gr', '<Cmd>Lspsaga rename<CR>', opts)

-- Prettier

-- Mason
local status, mason = pcall(require, "mason")
if (not status) then return end
local status2, lspconfig = pcall(require, "mason-lspconfig")
if (not status2) then return end

mason.setup({})

lspconfig.setup {
  ensure_installed = { "lua_ls", "tailwindcss", "html", "tsserver", 'jsonls', "cssls" },
}

-- lspconfig
local nvim_lsp = require "lspconfig"
nvim_lsp.tailwindcss.setup {}
nvim_lsp.tsserver.setup{}
nvim_lsp.html.setup{}
nvim_lsp.jsonls.setup{}
nvim_lsp.tailwindcss.setup{}
nvim_lsp.cssls.setup{}

local function formatWithPrettier()
    local bufferName = vim.api.nvim_buf_get_name(0)

    -- surround buffer name with double quotes
    -- this helps with paths that contain weird shit like parentheses, etc..
    bufferName = '"' .. bufferName .. '"'

    return {
        -- must have prettierd for this to work. install via `npm install -g @fsouza/prettierd`
        exe = "prettierd",
        args = {bufferName},
        stdin = true
    }
end

local function formatWithGofmt()
    return {
        exe = "gofmt",
        stdin = true
    }
end

-- format lua
local function formatLuaWithLuafmt()
    return {
        exe = "luafmt",
        args = {"--indent-count", 4, "--stdin"},
        stdin = true
    }
end

local function formatRustWithRustFmt()
    vim.cmd("RustFmt")
end

require("formatter").setup {
    filetype = {
        typescript = {formatWithPrettier},
        typescriptreact = {formatWithPrettier},
        javascript = {formatWithPrettier},
        javascriptreact = {formatWithPrettier},
        html = {formatWithPrettier},
        css = {formatWithPrettier},
        scss = {formatWithPrettier},
        json = {formatWithPrettier},
        markdown = {formatWithPrettier},
        yaml = {formatWithPrettier},
        rust = {formatRustWithRustFmt},
        go = {formatWithGofmt}
    }
}

-- Format on save (disabled cuz it gets on my f@cking nerves with tailwind)
-- vim.api.nvim_exec(
--     [[
--         augroup FormatAutogroup
--             autocmd!
--             autocmd BufWritePost * FormatWrite
--         augroup END
--     ]],
--     true
-- )

-- leader f to format
vim.api.nvim_set_keymap(
    "n",
    "<leader>f",
    "<cmd>Format<CR>",
    {
        noremap = true,
        silent = true
    }
)
