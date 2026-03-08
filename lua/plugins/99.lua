return {
  {
    "ThePrimeagen/99",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      local _99 = require("99")

      local cwd = vim.uv.cwd()
      local basename = vim.fs.basename(cwd)

      _99.setup({
        provider = _99.Providers.CursorAgentProvider,

        logger = {
          level = _99.DEBUG,
          path = "/tmp/" .. basename .. ".99.debug",
          print_on_error = true,
        },

        tmp_dir = "./tmp",

        md_files = {
          "AGENT.md",
        },

        completion = {
          source = "native",
          files = {},
        },
      })

      vim.keymap.set("v", "<leader>9v", function()
        _99.visual()
      end, { desc = "Visual replace" })

      vim.keymap.set("n", "<leader>9x", function()
        _99.stop_all_requests()
      end, { desc = "Stop all requests" })

      vim.keymap.set("n", "<leader>9s", function()
        _99.search()
      end, { desc = "Search" })

      vim.keymap.set("n", "<leader>9o", function()
        _99.open()
      end, { desc = "Open last interaction" })

      vim.keymap.set("n", "<leader>9c", function()
        _99.clear_previous_requests()
      end, { desc = "Clear previous requests" })

      vim.keymap.set("n", "<leader>9l", function()
        _99.view_logs()
      end, { desc = "View logs" })

      vim.keymap.set("n", "<leader>9m", function()
        require("99.extensions.telescope").select_model()
      end, { desc = "Select model" })

      vim.keymap.set("n", "<leader>9p", function()
        require("99.extensions.telescope").select_provider()
      end, { desc = "Select provider" })
    end,
  },
}
