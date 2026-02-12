vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set number")
vim.cmd("set ignorecase")
vim.cmd("set nosmartcase")
vim.cmd("set autoread")
vim.cmd("set updatetime=50")
vim.g.mapleader = " "

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.api.nvim_set_hl(0, "FlashWindow", { bg = "#353552" }) -- cool gray

vim.api.nvim_create_autocmd("WinEnter", {
  callback = function()
    local win = vim.api.nvim_get_current_win()
    vim.wo[win].winhighlight = "Normal:FlashWindow,NormalNC:FlashWindow,EndOfBuffer:FlashWindow"

    vim.defer_fn(function()
      if vim.api.nvim_win_is_valid(win) then
        vim.wo[win].winhighlight = ""
      end
    end, 120)
  end,
})

vim.keymap.set("n", "<leader>ff", function()
  require("conform").format()
  vim.cmd("checktime") -- force buffer reload immediately after formatting
end, { desc = "Format file with Conform and reload" })

vim.api.nvim_create_autocmd("FileType", {
  pattern = "php",
  callback = function()
    -- vim.opt_local.formatoptions:append({ "r", "o", "c" })
    --
    vim.opt_local.smartindent = true
    vim.opt_local.autoindent = true

    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.expandtab = true
  end
})
