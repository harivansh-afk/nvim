return {
  {
    "ludovicchabant/vim-gutentags",
    event = "VeryLazy",
    config = function()
      -- Store tags in a cache directory to keep project clean
      vim.g.gutentags_cache_dir = vim.fn.expand("~/.cache/nvim/ctags")

      -- Enable both ctags and LSP to work together
      vim.g.gutentags_modules = { "ctags" }

      -- Configure ctags generation
      vim.g.gutentags_ctags_extra_args = {
        "--tag-relative=yes",
        "--fields=+ailmnS",
        "--languages=Python,JavaScript,TypeScript,Go,Rust,C,C++,Lua",
        "--python-kinds=-i", -- Exclude imports
      }

      -- Don't generate tags for these directories
      vim.g.gutentags_ctags_exclude = {
        "*.git",
        "*.svg",
        "*.hg",
        "*/tests/*",
        "build",
        "dist",
        "*sites/*/files/*",
        "bin",
        "node_modules",
        "bower_components",
        "cache",
        "compiled",
        "docs",
        "example",
        "bundle",
        "vendor",
        "*.md",
        "*-lock.json",
        "*.lock",
        "*bundle*.js",
        "*build*.js",
        ".*rc*",
        "*.json",
        "*.min.*",
        "*.map",
        "*.bak",
        "*.zip",
        "*.pyc",
        "*.class",
        "*.sln",
        "*.Master",
        "*.csproj",
        "*.tmp",
        "*.csproj.user",
        "*.cache",
        "*.pdb",
        "tags*",
        "cscope.*",
        "*.css",
        "*.less",
        "*.scss",
        "*.exe",
        "*.dll",
        "*.mp3",
        "*.ogg",
        "*.flac",
        "*.swp",
        "*.swo",
        "*.bmp",
        "*.gif",
        "*.ico",
        "*.jpg",
        "*.png",
        "*.rar",
        "*.zip",
        "*.tar",
        "*.tar.gz",
        "*.tar.xz",
        "*.tar.bz2",
        "*.pdf",
        "*.doc",
        "*.docx",
        "*.ppt",
        "*.pptx",
        "__pycache__",
        ".venv",
        "venv",
      }

      -- Create cache directory if it doesn't exist
      vim.fn.mkdir(vim.fn.expand("~/.cache/nvim/ctags"), "p")
    end,
  },
}
