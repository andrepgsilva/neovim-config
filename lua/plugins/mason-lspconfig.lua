return {
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "lua_ls",
        -- "emmet_ls",
        "eslint",
        "html",
        "intelephense",
        "phpactor",
        "ts_ls",
        "vue_ls",
      },

      automatic_enable = true,
    },
    dependencies = {
      {
        "mason-org/mason.nvim",
        opts = {
          ui = {
            icons = {
              package_installed = "✔",
              package_pending = "🡲",
              package_uninstalled = "✗"
            }
          }
        }
      },
      "neovim/nvim-lspconfig"
    }
  },
}
