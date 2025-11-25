return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      sources = {
        files = {
          hidden = true, -- Show hidden files (starting with dot)
        },
        grep = {
          hidden = true, -- Also search hidden files when grepping
        },
      },
    },
  },
}
