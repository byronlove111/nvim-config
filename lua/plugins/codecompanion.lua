return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      {
        "MeanderingProgrammer/render-markdown.nvim",
        opts = { file_types = { "markdown", "codecompanion" } },
        ft = { "markdown", "codecompanion" },
      },
    },
    opts = {
      adapters = {
        acp = {
          cursor = function()
            return require("codecompanion.adapters").extend("claude_code", {
              commands = {
                default = {
                  vim.fn.expand("~/.local/bin/agent"),
                  "acp",
                },
              },
              defaults = {
                auth_method = "cursor_login",
              },
              env = {
                HOME = vim.fn.expand("~"),
                PATH = vim.fn.getenv("PATH"),
              },
            })
          end,
        },
      },
      interactions = {
        chat = { adapter = "cursor" },
        inline = { adapter = "cursor" },
        cmd = { adapter = "cursor" },
      },
      display = {
        chat = {
          window = {
            width = 0.38,
          },
        },
      },
    },
    keys = {
      { "<leader>aa", "<cmd>CodeCompanionChat Toggle<cr>", desc = "Toggle Chat" },
      { "<leader>ac", "<cmd>CodeCompanionActions<cr>", desc = "Actions" },
      { "<leader>ai", "<cmd>CodeCompanion<cr>", desc = "Inline assistant", mode = { "n", "v" } },
      { "ga", "<cmd>CodeCompanionChat Add<cr>", mode = "v", desc = "Add to chat" },
    },
  },
}
