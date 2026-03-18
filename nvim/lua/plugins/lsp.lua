return {
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        -- Python
        "pyright",
        "ruff",

        -- JS/React/TS
        "typescript-language-server",
        "eslint-lsp",

        -- Go
        "gopls",

        -- C
        "clangd",
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = {},
        ruff = {},
        ts_ls = {},
        eslint = {},
        gopls = {},
        clangd = {},
      },
    },
  },
}
