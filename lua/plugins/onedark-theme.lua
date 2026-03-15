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
      highlight_overrides = {
        macchiato = function(c)
          return {
            -- Floating windows : fond transparent pour laisser le blur Ghostty transparaître
            NormalFloat = { bg = "NONE" },
            FloatBorder = { fg = c.overlay1, bg = "NONE" },
            FloatTitle = { fg = c.lavender, bg = "NONE" },
            FloatFooter = { fg = c.overlay1, bg = "NONE" },
            -- Popup menu (complétion)
            Pmenu = { bg = "NONE" },
            PmenuSel = { fg = c.base, bg = c.lavender },
            PmenuSbar = { bg = "NONE" },
            -- Telescope
            TelescopeNormal = { bg = "NONE" },
            TelescopeBorder = { fg = c.overlay1, bg = "NONE" },
            TelescopePromptNormal = { bg = "NONE" },
            TelescopePromptBorder = { fg = c.overlay1, bg = "NONE" },
            TelescopeResultsNormal = { bg = "NONE" },
            TelescopePreviewNormal = { bg = "NONE" },
            -- Which-key
            WhichKeyFloat = { bg = "NONE" },
            WhichKeyNormal = { bg = "NONE" },
            -- Notify
            NotifyBackground = { bg = "NONE" },
            -- Lazy
            LazyNormal = { bg = "NONE" },
            LazyBackdrop = { bg = "NONE" },
            -- Mason
            MasonNormal = { bg = "NONE" },
            -- Neo-tree : tout en blanc
            NeoTreeFileName = { fg = c.text },
            NeoTreeFileNameOpened = { fg = c.text },
            NeoTreeDirectoryName = { fg = c.text },
            NeoTreeDirectoryIcon = { fg = c.text },
            NeoTreeRootName = { fg = c.text },
            NeoTreeGitUntracked = { fg = c.text },
            NeoTreeGitModified = { fg = c.text },
            NeoTreeGitAdded = { fg = c.text },
            NeoTreeGitConflict = { fg = c.text },
            NeoTreeGitDeleted = { fg = c.text },
            NeoTreeGitIgnored = { fg = c.text },
            NeoTreeGitStaged = { fg = c.text },
            NeoTreeGitUnstaged = { fg = c.text },
            NeoTreeSymbolicLinkTarget = { fg = c.text },
          }
        end,
      },
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd("colorscheme catppuccin")
    end,
  },

  -- Désactiver onedark s'il est encore installé
  { "navarasu/onedark.nvim", enabled = false },
}
