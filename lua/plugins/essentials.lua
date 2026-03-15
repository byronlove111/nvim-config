return {
  -- Librairies utilisées par de nombreux plugins
  { "nvim-lua/plenary.nvim", lazy = true },
  {
    url = "https://github.com/DaikyXendo/nvim-material-icon",
    name = "nvim-web-devicons",
    lazy = true,
    config = function()
      require("nvim-web-devicons").setup()
    end,
  },
  { "MunifTanjim/nui.nvim", lazy = true },

  -- Snacks: notifications, terminal flottant, et utilitaires modernes
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      notifier = { enabled = true },
      terminal = { enabled = true, win = { wo = { winbar = "" } } },
      bigfile = { enabled = true },
      quickfile = { enabled = true },
      -- Smooth scrolling
      scroll = { enabled = true },
      words = { enabled = false },
      -- Beautiful vim.ui.input / vim.ui.select
      input = { enabled = true },
      -- Dashboard au démarrage
      dashboard = {
        enabled = true,
        sections = {
          { section = "header" },
          { section = "keys", gap = 1, padding = 1 },
          { section = "startup" },
        },
        preset = {
          keys = {
            { icon = " ", key = "f", desc = "Find File",       action = ":Telescope find_files" },
            { icon = " ", key = "g", desc = "Live Grep",       action = ":Telescope live_grep" },
            { icon = " ", key = "r", desc = "Recent Files",    action = ":Telescope oldfiles" },
            { icon = " ", key = "c", desc = "Config",          action = ":e $MYVIMRC" },
            { icon = "󰒲 ", key = "l", desc = "Lazy",            action = ":Lazy" },
            { icon = " ", key = "q", desc = "Quit",            action = ":qa" },
          },
        },
      },
      -- Statuscolumn moderne (numéros + signes + fold)
      statuscolumn = { enabled = true },
      -- Scope highlight (bloc courant)
      scope = { enabled = true },
      -- Indent guides via snacks
      indent = { enabled = false },
    },
  },

  -- Which-key: aide visuelle pour les raccourcis
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      win = {
        border = "rounded",
        wo = {
          winblend = 0,
          winhighlight = "Normal:Normal,FloatBorder:FloatBorder,FloatTitle:Normal,FloatFooter:Normal",
        },
      },
      spec = {
        { "<leader>f", group = "find" },
        { "<leader>c", group = "code" },
        { "<leader>g", group = "git" },
        { "<leader>l", group = "lazy" },
        { "<leader>u", group = "ui" },
        { "<leader>t", group = "terminal" },
        { "<leader>a", group = "avante" },
        { "<leader>b", group = "buffer" },
        { "<leader>9", group = "99" },
      },
    },
  },

  -- Treesitter: syntax highlighting et indentation
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "bash", "c", "diff", "html", "javascript", "jsdoc",
          "json", "jsonc", "lua", "luadoc", "markdown",
          "markdown_inline", "python", "regex", "toml",
          "tsx", "typescript", "vim", "vimdoc", "yaml",
        },
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },

  -- Telescope: fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader><leader>", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
      { "<leader>/", "<cmd>Telescope live_grep<cr>", desc = "Grep" },
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent Files" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help Tags" },
      { "<leader>fd", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics" },
      { "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps" },
      { "<leader>fc", "<cmd>Telescope commands<cr>", desc = "Commands" },
      { "<leader>ft", "<cmd>TodoTelescope<cr>", desc = "Find TODOs" },
    },
    opts = {
      defaults = {
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        winblend = 0,
      },
    },
  },

  -- LSP via nvim-lspconfig + mason-lspconfig
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      local capabilities = vim.lsp.protocol.make_client_capabilities()

      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "ts_ls", "pyright", "clangd", "gopls", "rust_analyzer" },
        automatic_installation = true,
        handlers = {
          function(server)
            require("lspconfig")[server].setup({ capabilities = capabilities })
          end,
          lua_ls = function()
            require("lspconfig").lua_ls.setup({
              capabilities = capabilities,
              settings = {
                Lua = {
                  diagnostics = { globals = { "vim", "Snacks" } },
                  workspace = {
                    library = vim.api.nvim_get_runtime_file("", true),
                    checkThirdParty = false,
                  },
                  telemetry = { enable = false },
                },
              },
            })
          end,
        },
      })

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("lsp_attach", { clear = true }),
        callback = function(event)
          local opts = { buffer = event.buf }
          local m = function(keys, func, desc)
            vim.keymap.set("n", keys, func, vim.tbl_extend("force", opts, { desc = desc }))
          end
          m("gd", vim.lsp.buf.definition, "Go to definition")
          m("gD", vim.lsp.buf.declaration, "Go to declaration")
          m("gr", "<cmd>Telescope lsp_references<cr>", "References")
          m("gi", vim.lsp.buf.implementation, "Go to implementation")
          m("K", vim.lsp.buf.hover, "Hover")
          m("<leader>ca", vim.lsp.buf.code_action, "Code action")
          m("<leader>rn", vim.lsp.buf.rename, "Rename")
        end,
      })
    end,
  },

  -- Completion avec nvim-cmp
  {
    "hrsh7th/nvim-cmp",
    enabled = true,
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      { "L3MON4D3/LuaSnip", build = "make install_jsregexp" },
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        window = {
          completion = {
            border = "rounded",
            winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
            winblend = 0,
          },
          documentation = {
            border = "rounded",
            winhighlight = "Normal:Normal,FloatBorder:FloatBorder,Search:None",
            winblend = 0,
          },
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          -- Tab réservé à Supermaven, sauf pour sauter dans les snippets luasnip
          ["<Tab>"] = cmp.mapping(function(fallback)
            if luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),
        formatting = {
          format = function(_, item)
            local icons = {
              Text = "", Method = "󰆧", Function = "󰊕", Constructor = "",
              Field = "󰇽", Variable = "󰂡", Class = "󰠱", Interface = "",
              Module = "", Property = "󰜢", Unit = "", Value = "󰎠",
              Enum = "", Keyword = "󰌋", Snippet = "", Color = "󰏘",
              File = "󰈙", Reference = "", Folder = "󰉋", EnumMember = "",
              Constant = "󰏿", Struct = "", Event = "", Operator = "󰆕",
              TypeParameter = "󰅲",
            }
            item.kind = string.format("%s %s", icons[item.kind] or "", item.kind)
            return item
          end,
        },
      })
    end,
  },

  -- Gitsigns: décorations git dans la gouttière
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      current_line_blame = false,
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
      },
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns
        local m = function(l, r, desc)
          vim.keymap.set("n", l, r, { buffer = buffer, desc = desc })
        end
        m("]h", gs.next_hunk, "Next hunk")
        m("[h", gs.prev_hunk, "Prev hunk")
        m("<leader>gp", gs.preview_hunk, "Preview hunk")
        m("<leader>gb", gs.blame_line, "Blame line")
        m("<leader>gs", gs.stage_hunk, "Stage hunk")
        m("<leader>gr", gs.reset_hunk, "Reset hunk")
      end,
    },
  },

  -- Neo-tree: explorateur de fichiers
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    cmd = "Neotree",
    keys = {
      { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "File Explorer" },
      { "<leader>o", "<cmd>Neotree focus<cr>", desc = "Focus Explorer" },
    },
    opts = {
      filesystem = {
        follow_current_file = { enabled = true },
        hijack_netrw_behavior = "disabled",
        use_libuv_file_watcher = true,
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = false,
        },
      },
      window = {
        width = 25,
        mappings = {},
      },
      default_component_configs = {
        indent = { padding = 1 },
        icon = { folder_closed = "", folder_open = "", folder_empty = "" },
        modified = { symbol = "", highlight = "NeoTreeModified" },
        name = { trailing_slash = true, use_git_status_colors = false },
        git_status = { symbols = {} },
        file_size = { enabled = false },
        type = { enabled = false },
        last_modified = { enabled = false },
        created = { enabled = false },
        symlink_target = { enabled = false },
      },
      sources = { "filesystem" },
      source_selector = { winbar = false, statusline = false },
      use_popups_for_input = true,
    },
    config = function(_, opts)
      local orig_name = require("neo-tree.sources.common.components").name
      opts.filesystem = opts.filesystem or {}
      opts.filesystem.components = {
        name = function(config, node, state)
          if node:get_depth() == 1 and node.type ~= "message" then
            return { text = vim.fn.fnamemodify(node:get_id(), ":t") .. "/", highlight = "NeoTreeRootName" }
          end
          return orig_name(config, node, state)
        end,
      }
      require("neo-tree").setup(opts)
    end,
  },

  -- Lazygit
  {
    "kdheepak/lazygit.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
    },
  },

  -- Commentaires
  {
    "numToStr/Comment.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
  },

  -- Auto-paires de brackets/quotes
  {
    "echasnovski/mini.pairs",
    event = "InsertEnter",
    opts = {},
  },

  -- Guides d'indentation (remplacé par snacks.indent)
  { "lukas-reineke/indent-blankline.nvim", enabled = false },

  -- TODO comments
  {
    "folke/todo-comments.nvim",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
  },
}
