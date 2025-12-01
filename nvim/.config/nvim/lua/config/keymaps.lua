-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Create a user command for easy access
vim.api.nvim_create_user_command("CommentSlayer", function()
  -- Detect filetype to pass the -l flag eventually, defaults to dart for now
  local ft = vim.bo.filetype
  if ft == "dart" then
    vim.cmd("%!commentslayer -l dart")
  else
    print("CommentSlayer: Language not supported yet")
  end
end, {})

-- Map <leader>rc to the command
vim.keymap.set("n", "<leader>rc", ":CommentSlayer<CR>", { desc = "Remove Comments" })
