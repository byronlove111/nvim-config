-- Configuration du formatage automatique
return {
  -- Configuration de conform.nvim (formateur principal de LazyVim)
  {
    "stevearc/conform.nvim",
    opts = {
      -- LazyVim gère déjà format_on_save automatiquement
      -- On configure juste les formateurs personnalisés
      -- Configuration des formateurs par type de fichier
      formatters_by_ft = {
        -- Langages web
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
        
        -- Python
        python = { "black", "isort" },
        
        -- Lua
        lua = { "stylua" },
        
        -- Shell scripts
        sh = { "shfmt" },
        bash = { "shfmt" },
        
        -- Go
        go = { "gofumpt", "goimports" },
        
        -- Rust
        rust = { "rustfmt" },
        
        -- C/C++
        c = { "clang_format" },
        cpp = { "clang_format" },
        
        -- PHP
        php = { "php_cs_fixer" },
        
        -- SQL
        sql = { "sqlformat" },
        
        -- XML
        xml = { "xmlformat" },
      },
      -- Configuration personnalisée des formateurs
      formatters = {
        prettier = {
          prepend_args = { "--tab-width", "2", "--use-tabs", "false" },
        },
        black = {
          prepend_args = { "--line-length", "88" },
        },
        stylua = {
          prepend_args = { "--indent-type", "Spaces", "--indent-width", "2" },
        },
      },
    },
  },

}