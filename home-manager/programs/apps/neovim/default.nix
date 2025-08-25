{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraLuaConfig = ''
      -- Bootstrap lazy.nvim
      local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
      if not (vim.uv or vim.loop).fs_stat(lazypath) then
        local lazyrepo = "https://github.com/folke/lazy.nvim.git"
        local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
        if vim.v.shell_error ~= 0 then
          vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
          }, true, {})
          vim.fn.getchar()
          os.exit(1)
        end
      end
      vim.opt.rtp:prepend(lazypath)

      -- Make sure to setup `mapleader` and `maplocalleader` before
      -- loading lazy.nvim so that mappings are correct.
      vim.g.mapleader = " "
      vim.g.maplocalleader = "\\"

      -- Setup lazy.nvim
      require("lazy").setup({
        spec = {
          -- Import LazyVim and its plugin specs
          { "LazyVim/LazyVim", import = "lazyvim.plugins" },
          -- Import/override with your plugins
          { import = "plugins" },
        },
        defaults = {
          lazy = false,
          version = false, -- always use the latest git commit
        },
        install = { colorscheme = { "tokyonight", "habamax" } },
        checker = { enabled = true }, -- automatically check for plugin updates
        performance = {
          rtp = {
            disabled_plugins = {
              "gzip",
              "tarPlugin",
              "tohtml",
              "tutor",
              "zipPlugin",
            },
          },
        },
      })
    '';

    extraPackages = with pkgs; [
      # Build tools (required for tree-sitter and native plugins)
      gcc
      gnumake
      pkg-config

      # Node.js for Copilot
      nodejs

      # Language servers
      lua-language-server
      nil # Nix LSP
      nodePackages.typescript-language-server
      pyright
      rust-analyzer

      # Formatters
      stylua
      nixpkgs-fmt
      nodePackages.prettier
      black
      rustfmt

      # Tools
      ripgrep
      fd
      git
      lazygit
      tree-sitter
    ];
  };

  # Create LazyVim config directory structure
  xdg.configFile = {
    "nvim/lua/config/autocmds.lua".text = ''
      -- Autocmds are automatically loaded on the VeryLazy event
      -- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
      -- Add any additional autocmds here
    '';

    "nvim/lua/config/keymaps.lua".text = ''
      -- Keymaps are automatically loaded on the VeryLazy event
      -- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
      -- Add any additional keymaps here
    '';

    "nvim/lua/config/lazy.lua".text = ''
      local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
      if not vim.loop.fs_stat(lazypath) then
        vim.fn.system({
          "git",
          "clone",
          "--filter=blob:none",
          "https://github.com/folke/lazy.nvim.git",
          "--branch=stable",
          lazypath,
        })
      end
      vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

      require("lazy").setup({
        spec = {
          { "LazyVim/LazyVim", import = "lazyvim.plugins" },
          { import = "plugins" },
        },
        defaults = {
          lazy = false,
          version = false,
        },
        install = { colorscheme = { "tokyonight", "habamax" } },
        checker = { enabled = true },
        performance = {
          rtp = {
            disabled_plugins = {
              "gzip",
              "tarPlugin",
              "tohtml",
              "tutor",
              "zipPlugin",
            },
          },
        },
      })
    '';

    "nvim/lua/config/options.lua".text = ''
      -- Options are automatically loaded before lazy.nvim startup
      -- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
      -- Add any additional options here
    '';

    "nvim/lua/plugins/example.lua".text = ''
      -- Every spec file under the "plugins" directory will be loaded automatically by Lazy
      -- In your plugin files, you can:
      -- * add extra plugins
      -- * disable/enabled LazyVim plugins
      -- * override the configuration of LazyVim plugins
      return {
        -- add gruvbox
        { "ellisonleao/gruvbox.nvim" },

        -- Configure LazyVim to load gruvbox
        {
          "LazyVim/LazyVim",
          opts = {
            colorscheme = "gruvbox",
          },
        },

        -- change trouble config
        {
          "folke/trouble.nvim",
          -- opts will be merged with the parent spec
          opts = { use_diagnostic_signs = true },
        },

        -- disable trouble
        { "folke/trouble.nvim", enabled = false },

        -- override nvim-cmp and add cmp-emoji
        {
          "hrsh7th/nvim-cmp",
          dependencies = { "hrsh7th/cmp-emoji" },
          ---@param opts cmp.ConfigSchema
          opts = function(_, opts)
            table.insert(opts.sources, { name = "emoji" })
          end,
        },
      }
    '';

    "nvim/lua/plugins/copilot.lua".text = ''
      return {
        -- GitHub Copilot
        {
          "github/copilot.vim",
          event = "InsertEnter",
          config = function()
            vim.g.copilot_no_tab_map = true
            vim.g.copilot_assume_mapped = true
            vim.g.copilot_tab_fallback = ""
            -- Tab ile kabul etme
            vim.api.nvim_set_keymap("i", "<Tab>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
          end,
        },
        
        -- Copilot Chat
        {
          "CopilotC-Nvim/CopilotChat.nvim",
          branch = "canary",
          dependencies = {
            { "github/copilot.vim" },
            { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
          },
          config = function()
            require("CopilotChat").setup({
              debug = true, -- Enable debugging
              -- See Configuration section for rest
            })
          end,
          -- See Commands section for default commands if you want to lazy load on them
        },
      }
    '';
  };
}
