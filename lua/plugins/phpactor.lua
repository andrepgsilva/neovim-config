return {
  "phpactor/phpactor",
  ft = "php",
  build = "composer install --no-dev -o",
  config = function()
    vim.keymap.set("n", "<leader>ci", ":PhpactorImportClass<CR>", { desc = "Import PHP class" })
    vim.keymap.set("n", "<C-A-i>", ":PhpactorImportMissingClasses<CR>", { desc = "Import PHP class" })
    vim.keymap.set("n", "<leader>cp", ":PhpactorCopyFile<CR>", { desc = "Import PHP class" })
    vim.keymap.set("n", "<leader>cn", ":PhpactorClassNew<CR>", { desc = "Create new PHP class with namespace" })
    vim.keymap.set("n", "<leader>cf", ":PhpactorTransform<CR>", { desc = "Fix or add PHP namespace" })
  end
}
