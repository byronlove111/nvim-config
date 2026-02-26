return {
  {
    "supermaven-inc/supermaven-nvim",
    event = "InsertEnter",
    opts = {
      keymaps = {
        accept_suggestion = "<Tab>",
        clear_suggestion = "<C-]>",
        accept_word = "<C-j>",
      },
      ignore_filetypes = {
        "bigfile",
        "snacks_input",
        "snacks_notif",
        "Avante",
        "AvanteInput",
      },
      color = {
        suggestion_color = "#5c6370",
        cterm = 244,
      },
      log_level = "off",
      disable_inline_completion = false,
      disable_keymaps = false,
    },
    config = function(_, opts)
      require("supermaven-nvim").setup(opts)

      vim.defer_fn(function()
        vim.api.nvim_set_hl(0, "SupermavenSuggestion", {
          fg = "#5c6370",
          italic = true,
          bg = "NONE",
        })
        vim.api.nvim_set_hl(0, "SupermavenInlineSuggestion", {
          fg = "#6c7682",
          italic = true,
          bg = "NONE",
        })
      end, 100)
    end,
  },
}
