return {
  'stevearc/conform.nvim',
  opts = {
    formatters_by_ft = {
      php = { "pint" },
    },
    formatters = {
      pint = {
        command = '/vendor/bin/php',
        args = { "--quiet", "--" },
        stdin = false,
      },
    },
    format_on_save = {
      lsp_fallback = true,
    },
  },
}
