return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    -- lazy = false pour être dispo avant le premier hover LSP
    lazy = false,
    opts = {
      render_modes = { "n", "c" },
      heading = { enabled = true },
      code = { enabled = true },
      bullet = { enabled = true },
      checkbox = { enabled = true },
      table = { enabled = true },
      link = { enabled = true },
    },
    config = function(_, opts)
      require("render-markdown").setup(opts)

      -- Désactiver pour les fichiers .md ouverts dans une fenêtre normale (non-float)
      -- Les floats LSP/hover sont uniquement dans des fenêtres relatives → pas touchées
      vim.api.nvim_create_autocmd("BufWinEnter", {
        callback = function(event)
          if vim.bo[event.buf].filetype ~= "markdown" then return end
          for _, win in ipairs(vim.fn.win_findbuf(event.buf)) do
            if vim.api.nvim_win_get_config(win).relative == "" then
              vim.api.nvim_buf_call(event.buf, function()
                require("render-markdown").disable()
              end)
              return
            end
          end
        end,
      })
    end,
  },
}
