return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      {
        "MeanderingProgrammer/render-markdown.nvim",
        ft = { "codecompanion" },
        opts = {
          file_types = { "codecompanion" },
          render_modes = { "n", "c", "t" },
          heading = {
            icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
            sign = true,
            width = "full",
            border = true,
          },
          code = {
            style = "full",
            border = "thin",
            language_icon = true,
            language_name = true,
            width = "full",
          },
          bullet = {
            icons = { "●", "○", "◆", "◇" },
          },
          checkbox = {
            unchecked = { icon = "󰄱 " },
            checked = { icon = "󰱒 " },
            custom = {
              todo = { raw = "[-]", rendered = "󰥔 ", highlight = "RenderMarkdownTodo" },
            },
          },
          pipe_table = {
            preset = "round",
            cell = "padded",
          },
          callout = {
            note      = { raw = "[!NOTE]",      rendered = "󰋽 Note",      highlight = "RenderMarkdownInfo" },
            tip       = { raw = "[!TIP]",       rendered = "󰌶 Tip",       highlight = "RenderMarkdownSuccess" },
            warning   = { raw = "[!WARNING]",   rendered = "󰀪 Warning",   highlight = "RenderMarkdownWarn" },
            important = { raw = "[!IMPORTANT]", rendered = "󰅾 Important", highlight = "RenderMarkdownHint" },
            caution   = { raw = "[!CAUTION]",   rendered = "󰳦 Caution",   highlight = "RenderMarkdownError" },
          },
          link = {
            hyperlink = "󰌹 ",
            image     = "󰥶 ",
            email     = "󰀓 ",
            custom = {
              web    = { pattern = "^http",        icon = "󰖟 " },
              github = { pattern = "github%.com",  icon = "󰊤 " },
            },
          },
          anti_conceal = {
            enabled = true,
            above   = 0,
            below   = 0,
          },
          completions = {
            lsp = { enabled = true },
          },
        },
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
