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
        http = {
          qwen = function()
            return require("codecompanion.adapters").extend("openai_compatible", {
              env = {
                url = "http://127.0.0.1:8080",
                api_key = "TERM",
                chat_url = "/v1/chat/completions",
              },
              schema = {
                model = { default = "qwen2.5-coder-7b-instruct" },
                temperature = { default = 0.7 },
                max_tokens = { default = 8192 },
              },
            })
          end,
        },
      },
      interactions = {
        chat = { adapter = "qwen" },
        inline = { adapter = "qwen" },
        cmd = { adapter = "qwen" },
      },
      system_prompt = "You are Qwen2.5-Coder, a coding assistant made by Alibaba Cloud, running locally via llama.cpp. Help the user with their code.",
    },
    keys = {
      { "<leader>aa", "<cmd>CodeCompanionChat Toggle<cr>", desc = "Toggle Chat" },
      { "<leader>ac", "<cmd>CodeCompanionActions<cr>", desc = "Actions" },
      { "<leader>ai", "<cmd>CodeCompanion<cr>", desc = "Inline assistant", mode = { "n", "v" } },
      { "ga", "<cmd>CodeCompanionChat Add<cr>", mode = "v", desc = "Add to chat" },
    },
  },
}
