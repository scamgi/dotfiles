vim.api.nvim_create_user_command("CommentSlayer", function()
  local ft_map = {
    c = "c",
    cpp = "cpp",
    cs = "csharp",
    css = "css",
    dart = "dart",
    erlang = "erlang",
    fish = "fish",
    go = "go",
    haskell = "haskell",
    html = "html",
    java = "java",
    javascript = "javascript",
    kotlin = "kotlin",
    lua = "lua",
    perl = "perl",
    php = "php",
    ps1 = "powershell",
    python = "python",
    r = "r",
    ruby = "ruby",
    rust = "rust",
    scheme = "scheme",
    sh = "shell",
    bash = "shell",
    zsh = "shell",
    solidity = "solidity",
    sql = "sql",
    swift = "swift",
    toml = "toml",
    typescript = "typescript",
    yaml = "yaml",
  }

  local ft = vim.bo.filetype
  local lang = ft_map[ft]

  if lang then
    vim.cmd(string.format("%%!commentslayer -l %s", lang))
  else
    vim.notify("CommentSlayer: Language '" .. ft .. "' not supported yet", vim.log.levels.WARN)
  end
end, {})

vim.keymap.set("n", "<leader>rc", ":CommentSlayer<CR>", { desc = "Remove Comments" })
vim.keymap.set("n", "<leader>rs", "<cmd>!cat-repo -s<CR>", { desc = "Generate cat-repo.txt" })
