local map = vim.keymap.set

-- Cycle entre les fenêtres
map("n", "<S-Tab>", "<C-w>w", { desc = "Next window" })
map("n", "<S-n>", "<C-w>w", { desc = "Next window" })

-- Navigation entre les fenêtres
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Redimensionnement des fenêtres
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Navigation entre les buffers
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete buffer" })

-- Indentation en mode visuel (garde la sélection)
map("v", "<", "<gv", { desc = "Indent left" })
map("v", ">", ">gv", { desc = "Indent right" })

-- Diagnostics LSP
map("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Prev diagnostic" })
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line diagnostics" })

-- Formatage
map("n", "<leader>cf", function()
  require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format buffer" })

map("n", "<leader>uf", function()
  vim.g.autoformat = not vim.g.autoformat
  vim.notify("Formatage auto: " .. (vim.g.autoformat and "activé" or "désactivé"))
end, { desc = "Toggle auto format" })

-- Terminal via snacks.nvim
map("n", "<leader>tt", function() Snacks.terminal() end, { desc = "Terminal (float)" })
map("n", "<leader>th", function()
  Snacks.terminal(nil, { win = { position = "bottom", height = 0.25 } })
end, { desc = "Terminal (horizontal)" })
map("n", "<leader>tv", function()
  Snacks.terminal(nil, { win = { position = "right" } })
end, { desc = "Terminal (vertical)" })

-- Lazy
map("n", "<leader>ll", "<cmd>Lazy<cr>", { desc = "Lazy" })
map("n", "<leader>lu", "<cmd>Lazy update<cr>", { desc = "Lazy Update" })
map("n", "<leader>ls", "<cmd>Lazy status<cr>", { desc = "Lazy Status" })
map("n", "<leader>lp", "<cmd>Lazy profile<cr>", { desc = "Lazy Profile" })
map("n", "<leader>lc", "<cmd>Lazy clean<cr>", { desc = "Lazy Clean" })

-- Quitter plus facilement
map("n", "<leader>q", "<cmd>qa<cr>", { desc = "Quit all" })
map("n", "<leader>w", "<cmd>w<cr>", { desc = "Save" })
vim.cmd("cabbrev wq! wqa")
vim.cmd("cabbrev W w")
vim.cmd("cabbrev Q q")

-- Commenter comme VS Code (Cmd+/)
map("n", "<D-/>", function()
  require("Comment.api").toggle.linewise.current()
end, { desc = "Toggle comment" })
map("v", "<D-/>", function()
  local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
  vim.api.nvim_feedkeys(esc, "nx", false)
  require("Comment.api").toggle.linewise(vim.fn.visualmode())
end, { desc = "Toggle comment" })

-- Effacer la recherche
map("n", "<Esc>", "<cmd>nohlsearch<cr>", { desc = "Clear search highlight" })

-- Désactiver n (next search result)
map("n", "n", "<Nop>", { desc = "Disabled" })

-- Shift+J/K = j/k
map("n", "J", "j", { desc = "Down" })
map("n", "K", "k", { desc = "Up" })

-- Supermaven toggle
map("n", "<leader>us", "<cmd>SupermavenToggle<cr>", { desc = "Toggle Supermaven" })

-- Linting
map("n", "<leader>ml", function()
  require("lint").try_lint()
end, { desc = "Trigger linting" })

-- Markdown preview with mdv
map("n", "<leader>p", function()
  local file = vim.fn.expand("%:p")
  if file == "" then
    vim.notify("No file", vim.log.levels.WARN)
    return
  end
  vim.fn.jobstart({ "mdv", file }, { detach = true })
end, { desc = "Preview in mdv" })
