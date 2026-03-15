return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    opts = {
      flavour = "macchiato",
      background = { light = "latte", dark = "macchiato" },
      transparent_background = true,
      show_end_of_buffer = false,
      term_colors = true,
      styles = {
        comments = { "italic" },
        keywords = { "bold" },
        functions = {},
        variables = {},
      },
      integrations = {
        telescope = { enabled = true, style = "nvchad" },
        which_key = true,
        gitsigns = true,
        neo_tree = true,
        mason = true,
        indent_blankline = { enabled = true },
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
          },
        },
      },
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd("colorscheme catppuccin")
    end,
  },

  { "ydkulks/cursor-dark.nvim", enabled = false },
  { "navarasu/onedark.nvim", enabled = false },
}
