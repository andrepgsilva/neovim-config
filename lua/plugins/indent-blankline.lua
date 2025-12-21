return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  opts = {
    indent = { char = "┆" }, -- keep a subtle indent guide (optional)
    scope = { enabled = false },
  },
  config = function(_, opts)
    require("ibl").setup(opts)

    vim.opt.list = true
    vim.opt.listchars = {
      lead = "·",     -- show dots only for indentation spaces
      trail = "•",    -- optional: mark trailing space
      tab = "→ ",     -- optional: mark tabs
    }
  end,
}
