-- Configuration de nvim-lint pour le linting automatique
return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")

    -- Associe chaque langage avec son linter
    lint.linters_by_ft = {
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typescriptreact = { "eslint_d" },
      svelte = { "eslint_d" },
      vue = { "eslint_d" },
      python = { "flake8" },
      sh = { "shellcheck" },
      bash = { "shellcheck" },
      zsh = { "shellcheck" },
      lua = { "luacheck" },
      go = { "golangci-lint" },
      rust = { "clippy" },
      kotlin = { "ktlint" },
      terraform = { "tflint" },
      ruby = { "standardrb" },
      yaml = { "yamllint" },
      json = { "jsonlint" },
      dockerfile = { "hadolint" },
    }

    -- Crée un groupe d'autocommandes pour déclencher le linter
    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint()
      end,
    })

    -- Raccourcis clavier
    vim.keymap.set("n", "<leader>ll", function()
      lint.try_lint()
    end, { desc = "Trigger linting for current file" })

    vim.keymap.set("n", "<leader>lc", function()
      local current_buf = vim.api.nvim_get_current_buf()
      vim.diagnostic.reset(nil, current_buf)
    end, { desc = "Clear linting diagnostics" })

    -- Message informatif
    vim.notify("🔍 nvim-lint configuré avec succès!", vim.log.levels.INFO, {
      title = "Linter",
      timeout = 2000,
    })
  end,
}