-- Transparence : étend l'option native du thème aux floats et panels plugins
local function clear_bg(name)
  local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = name, link = false })
  if ok and hl then
    hl.bg, hl.ctermbg = nil, nil
    pcall(vim.api.nvim_set_hl, 0, name, hl)
  end
end

local function apply_transparency()
  for _, group in ipairs({
    "NormalFloat", "FloatBorder", "FloatTitle",
    "Pmenu", "PmenuSbar", "PmenuThumb",
    "SignColumn",
  }) do
    clear_bg(group)
  end
  for _, prefix in ipairs({ "Telescope", "NeoTree", "WhichKey", "Lazy", "Mason", "Cmp", "Snacks" }) do
    for _, name in ipairs(vim.fn.getcompletion(prefix, "highlight")) do
      clear_bg(name)
    end
  end
  -- Neo-tree : forcer les noms de dossiers/fichiers en blanc
  for _, group in ipairs({
    "NeoTreeDirectoryName", "NeoTreeDirectoryIcon", "NeoTreeRootName",
    "NeoTreeFileName", "NeoTreeFileNameOpened",
  }) do
    pcall(vim.api.nvim_set_hl, 0, group, { fg = "#ffffff" })
  end
end

vim.api.nvim_create_autocmd("ColorScheme", { callback = apply_transparency })
apply_transparency()

-- Makefile : afficher les tabs (obligatoires) et désactiver expandtab
vim.api.nvim_create_autocmd("FileType", {
  pattern = "make",
  callback = function()
    vim.opt_local.list = true
    vim.opt_local.listchars = { tab = ">·" }
    vim.opt_local.expandtab = false
  end,
})

-- Markdown brut : désactiver le conceal pour voir la syntaxe telle quelle
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.opt_local.conceallevel = 0
  end,
})

-- Installer les formatters/linters Mason au premier démarrage (sans mason-tool-installer)
vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  once = true,
  callback = function()
    local tools = {
      "stylua", "prettier", "shfmt", "clang-format",
      "eslint_d", "flake8", "shellcheck",
      "gofumpt", "goimports",
    }
    local registry = require("mason-registry")
    registry.refresh(function()
      for _, name in ipairs(tools) do
        local ok, pkg = pcall(registry.get_package, name)
        if ok and not pkg:is_installed() then
          pkg:install()
        end
      end
    end)
  end,
})

-- Fermer certaines fenêtres avec q
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "help", "lspinfo", "man", "notify", "qf", "startuptime", "checkhealth" },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

-- Highlight au yank
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Égaliser les splits lors du redimensionnement
vim.api.nvim_create_autocmd("VimResized", {
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. current_tab)
  end,
})

-- Retourner au dernier emplacement à l'ouverture d'un fichier
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function(event)
    local exclude = { "gitcommit" }
    local buf = event.buf
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) then return end
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Sauvegarder automatiquement lors du changement de buffer (focus change)
vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost" }, {
  callback = function()
    if vim.bo.modified and not vim.bo.readonly and vim.fn.expand("%") ~= "" and vim.bo.buftype == "" then
      vim.api.nvim_command("silent! update")
    end
  end,
})
