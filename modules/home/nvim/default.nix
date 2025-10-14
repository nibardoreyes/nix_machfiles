{ config, pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    
    extraPackages = with pkgs; [
      tree-sitter
      gcc
      ripgrep
      fd
      
      # Language servers
      nil              # Nix
      pyright          # Python
      rust-analyzer    # Rust
      clang-tools      # C/C++ (includes clangd)
      jdt-language-server  # Java
      
      # Formatters/Linters
      black            # Python formatter
      rustfmt          # Rust formatter
      clang-tools      # C/C++ formatter (clang-format)
      
      # Clipboard support
      wl-clipboard     # Wayland clipboard
      xclip            # X11 clipboard
    ];
    
    plugins = with pkgs.vimPlugins; [
      # Theme
      tokyonight-nvim
      
      # Treesitter for syntax highlighting
      (nvim-treesitter.withPlugins (p: [
        p.tree-sitter-nix
        p.tree-sitter-python
        p.tree-sitter-rust
        p.tree-sitter-c
        p.tree-sitter-cpp
        p.tree-sitter-java
      ]))
      
      # LSP
      nvim-lspconfig
      
      # Telescope (fuzzy finder)
      telescope-nvim
      plenary-nvim
      
      # File explorer
      nvim-tree-lua
      nvim-web-devicons
      
      # Which-key for keymap popup
      which-key-nvim
      
      # Buffer line for visual buffers
      bufferline-nvim
    ];
    
    extraLuaConfig = ''
      -- Set colorscheme
      vim.cmd[[colorscheme tokyonight-night]]
      
      -- Set leader key to space
      vim.g.mapleader = " "
      
      -- Enable system clipboard
      vim.opt.clipboard = "unnamedplus"
      
      -- Enable treesitter highlighting
      require'nvim-treesitter.configs'.setup {
        highlight = {
          enable = true,
        },
      }
      
      -- LSP setup
      local lspconfig = require('lspconfig')
      
      -- Nix
      lspconfig.nil_ls.setup{}
      
      -- Python
      lspconfig.pyright.setup{}
      
      -- Rust
      lspconfig.rust_analyzer.setup{}
      
      -- C/C++
      lspconfig.clangd.setup{}
      
      -- Java
      lspconfig.jdtls.setup{}
      
      -- Telescope setup
      require('telescope').setup{}
      
      -- Nvim-tree setup
      require('nvim-tree').setup{}
      
      -- Bufferline setup (visual buffer tabs)
      require('bufferline').setup{
        options = {
          diagnostics = "nvim_lsp",
          offsets = {
            {
              filetype = "NvimTree",
              text = "File Explorer",
              highlight = "Directory",
              text_align = "left"
            }
          }
        }
      }
      
      -- Which-key setup (shows popup when you press space)
      require('which-key').setup{
        delay = 200,
      }
      
      -- Navigate between windows (Ctrl + h/l for file explorer <-> buffer)
      vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Window left' })
      vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Window right' })
      vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Window down' })
      vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Window up' })
      
      -- Select all with Ctrl+A
      vim.keymap.set('n', '<C-a>', 'ggVG', { desc = 'Select all' })
      
      -- Register keymaps with which-key
      require('which-key').add({
        -- Main menu
        { "<leader>f", "<cmd>Telescope find_files<cr>", desc = "Find files" },
        { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "File explorer" },
        
        -- Buffer/Keymap submenu (Space + k)
        { "<leader>k", group = "Keybinds & Buffers" },
        { "<leader>kh", "<cmd>BufferLineCyclePrev<cr>", desc = "← Previous buffer (Shift+H)" },
        { "<leader>kl", "<cmd>BufferLineCycleNext<cr>", desc = "→ Next buffer (Shift+L)" },
        { "<leader>kj", "<cmd>BufferLinePick<cr>", desc = "↓ Pick buffer (Shift+J)" },
        { "<leader>kk", "<cmd>BufferLinePickClose<cr>", desc = "↑ Close buffer (Shift+K)" },
        { "<leader>kc", "<cmd>bdelete<cr>", desc = "✕ Close current buffer" },
        { "<leader>kw", "<cmd>lua print('Ctrl+H/L: Switch windows')<cr>", desc = "⬌ Ctrl+H/L switch windows" },
        { "<leader>ka", "<cmd>lua print('Ctrl+A: Select all, y: yank/copy')<cr>", desc = "📋 Ctrl+A select all" },
      })
      
      -- Buffer navigation with Shift + h/j/k/l
      vim.keymap.set('n', '<S-h>', '<cmd>BufferLineCyclePrev<cr>', { desc = 'Previous buffer' })
      vim.keymap.set('n', '<S-l>', '<cmd>BufferLineCycleNext<cr>', { desc = 'Next buffer' })
      vim.keymap.set('n', '<S-j>', '<cmd>BufferLinePick<cr>', { desc = 'Pick buffer' })
      vim.keymap.set('n', '<S-k>', '<cmd>BufferLinePickClose<cr>', { desc = 'Pick buffer to close' })
      
      -- Basic settings
      vim.opt.number = true
      vim.opt.relativenumber = true
      vim.opt.tabstop = 2
      vim.opt.shiftwidth = 2
      vim.opt.expandtab = true
    '';
  };
}