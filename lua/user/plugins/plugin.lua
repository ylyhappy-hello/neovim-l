return {
  "folke/which-key.nvim",
  { "folke/neoconf.nvim", cmd = "Neoconf" },
  "folke/neodev.nvim",
  "neovim/nvim-lspconfig",
  "nvim-treesitter/nvim-treesitter",
  "sainnhe/gruvbox-material",
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = { "nvim-lua/plenary.nvim" }
  },
  {
    "ggandor/leap.nvim",
    init = function()
      require("leap").create_default_mappings()
    end
  },

  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-cmdline",
  "hrsh7th/nvim-cmp",

  { "L3MON4D3/LuaSnip",   version = "v2.2.0", build = "make install_jsregexp" },
  "saadparwaiz1/cmp_luasnip",
  "rafamadriz/friendly-snippets",
  { "nvim-tree/nvim-tree.lua", lazy = false, dependencies = { "nvim-tree/nvim-web-devicons" } },
  "windwp/nvim-autopairs",
  { 'numToStr/Comment.nvim',   lazy = false, },
  "mfussenegger/nvim-jdtls",
  {
      'javiorfo/nvim-wildcat',
      lazy = true,
      cmd = { "WildcatRun", "WildcatUp", "WildcatInfo" },
      dependencies = { 'javiorfo/nvim-popcorn' },
      config = function()
          -- Not necessary. Only if you want to change the setup
      end
  }
}
