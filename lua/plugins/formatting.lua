return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          javascript = { "prettier" },
          typescript = { "prettier" },
          javascriptreact = { "prettier" },
          typescriptreact = { "prettier" },
          vue = { "prettier" },
          css = { "prettier" },
          scss = { "prettier" },
          less = { "prettier" },
          html = { "prettier" },
          json = { "prettier" },
          jsonc = { "prettier" },
          yaml = { "prettier" },
          markdown = { "prettier" },
          python = { "ruff_format", "ruff_organize_imports" },
          lua = { "stylua" },
          sh = { "shfmt" },
          bash = { "shfmt" },
          go = { "gofumpt", "goimports" },
          c = { "clang_format" },
          cpp = { "clang_format" },
        },
        formatters = {
          prettier = {
            prepend_args = { "--tab-width", "2", "--use-tabs", "false" },
          },
          stylua = {
            prepend_args = { "--indent-type", "Spaces", "--indent-width", "2" },
          },
        },
        format_on_save = function()
          if vim.g.autoformat then
            return { timeout_ms = 500, lsp_fallback = true }
          end
        end,
      })
    end,
  },
}
