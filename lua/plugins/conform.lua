return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>ff",
      function()
        require("conform").format({ async = true })
      end,
      mode = "",
      desc = "Format buffer",
    },
  },
  opts = {
    formatters_by_ft = {
      php = { "pint" },
    },
    default_format_opts = {
      lsp_format = "fallback",
    },
    -- format_on_save = { timeout_ms = 500 },
    formatters = {
      shfmt = {
        append_args = { "-i", "2" },
      },
    },
  },
}
