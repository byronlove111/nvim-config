local map = vim.keymap.set

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

-- Déplacer les lignes sélectionnées
map("v", "J", ":m '>+1<cr>gv=gv", { desc = "Move selection down" })
map("v", "K", ":m '<-2<cr>gv=gv", { desc = "Move selection up" })

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

-- Toggle fond transparent
map("n", "<leader>ut", function()
  local current = require("catppuccin").options.transparent_background
  require("catppuccin").setup({ transparent_background = not current })
  vim.cmd("colorscheme catppuccin")
  vim.notify("Transparence: " .. (not current and "activée" or "désactivée"))
end, { desc = "Toggle transparency" })

-- Terminal via snacks.nvim
map("n", "<leader>tt", function() Snacks.terminal() end, { desc = "Terminal (float)" })
map("n", "<leader>th", function()
  Snacks.terminal(nil, { win = { position = "bottom" } })
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

-- Effacer la recherche
map("n", "<Esc>", "<cmd>nohlsearch<cr>", { desc = "Clear search highlight" })

-- Supermaven toggle
map("n", "<leader>us", "<cmd>SupermavenToggle<cr>", { desc = "Toggle Supermaven" })

-- Linting
map("n", "<leader>ml", function()
  require("lint").try_lint()
end, { desc = "Trigger linting" })
