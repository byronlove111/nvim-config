return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    ft = { "markdown" },
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

      -- Désactiver pour les vrais fichiers .md ouverts depuis le disque
      -- Les floats LSP/hover sont des buffers virtuels, pas touchés par BufReadPost *.md
      vim.api.nvim_create_autocmd("BufReadPost", {
        pattern = "*.md",
        callback = function()
          require("render-markdown").disable()
        end,
      })
    end,
  },
}
