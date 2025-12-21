-- lua/smartpaste/init.lua
-- Smart Paste for Neovim: paste with auto-indent, safe for macros

local function smart_paste(mode, reg)
  -- Build register prefix: '"reg' if non-empty, otherwise empty
  local prefix = reg ~= '' and ('"' .. reg) or ''

  -- 1️⃣ Skip smart indent if inside macro/plugin recording
  if vim.fn.reg_executing() ~= '' or vim.fn.reg_recording() ~= '' then
    if mode == 'v' then
      vim.cmd(([[normal! %sgvp]]):format(prefix))
    else
      vim.cmd(([[normal! %sp]]):format(prefix))
    end
    return
  end

  -- 2️⃣ Smart paste: paste and auto-indent
  if mode == 'v' then
    -- Visual mode: replace selection, reselect pasted text, indent it
    vim.cmd(([[normal! %sgvpgv=']^]]):format(prefix))
  else
    -- Normal mode: paste after cursor, indent pasted block
    vim.cmd(([[normal! %sp=']^]]):format(prefix))
  end
end

-- 3️⃣ Keymap options
local opts = { silent = true, noremap = true }

vim.keymap.set('n', 'p', function()
  smart_paste('n', vim.v.register)
end, opts)

vim.keymap.set('n', 'P', function()
  smart_paste('n', vim.v.register)
end, opts)

vim.keymap.set('x', 'p', function()
  smart_paste('v', vim.v.register)
end, opts)

vim.keymap.set('x', 'P', function()
  smart_paste('v', vim.v.register)
end, opts)

-- Conform(Formatting)
vim.api.nvim_create_user_command("Format", function(args)
  local range = nil
  if args.count ~= -1 then
    local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
    range = {
      start = { args.line1, 0 },
      ["end"] = { args.line2, end_line:len() },
    }
  end
  require("conform").format({ async = true, lsp_format = "fallback", range = range })
end, { range = true })

-- Wrap words with quotes
-- vim.keymap.set('n', ' "', 'bi"<Esc>ea"<Esc>')
vim.keymap.set('n', ' "', 'viw<Esc>a"<Esc>gvo<Esc>i"<Esc>')
vim.keymap.set('n', " '", "viw<Esc>a'<Esc>gvo<Esc>i'<Esc>")

vim.keymap.set('v', ' "', '<Esc>a"<Esc>gvo<Esc>i"<Esc>')
vim.keymap.set('v', " '", "<Esc>a'<Esc>gvo<Esc>i'<Esc>")

-- Float Window --
function _G.float_current_window()
  local buf = vim.api.nvim_get_current_buf()

  vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = math.floor(vim.o.columns * 0.8),
    height = math.floor(vim.o.lines * 0.8),
    row = math.floor(vim.o.lines * 0.1),
    col = math.floor(vim.o.columns * 0.1),
    style = "minimal",
    border = "rounded",
  })

  -- allow closing with q
  vim.keymap.set("n", "q", function()
    vim.api.nvim_win_close(0, false)
  end, { buffer = buf })
end

vim.api.nvim_create_user_command("FloatMe", float_current_window, {})
vim.keymap.set("n", " wf", ":FloatMe<CR>", { silent = true })
