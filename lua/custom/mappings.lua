---@type MappingsTable
local M = {}

local global_grep = function()
  require("telescope.builtin").live_grep {
    additional_args = function(args)
      return vim.list_extend(args, { "--hidden", "--no-ignore" })
    end,
  }
end

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
    ["<leader>fF"] = { "<cmd>Telescope find_files hidden=true no_ignore=true<CR>", "Find Global [F]ile" },
    ["<leader>fG"] = { global_grep, "Global Live [G]rep" },
    ["<C-h>"] = { "<cmd>TmuxNavigateLeft<CR>" },
    ["<C-j>"] = { "<cmd>TmuxNavigateDown<CR>" },
    ["<C-k>"] = { "<cmd>TmuxNavigateUp<CR>" },
    ["<C-l>"] = { "<cmd>TmuxNavigateRight<CR>" },
  },

  v = {
    -- Reselect visual selection after indenting
    ["<"] = { "<gv" },
    [">"] = { ">gv" },
    -- Maintain the cursor position when yanking a visual selection
    -- http://ddrscott.github.io/blog/2016/yank-without-jank/
    ["y"] = { "myy`y" },
    ["Y"] = { "myY`y" },
    -- Paste replace visual selection without copying it
    ["p"] = { '"_dP' },
  },

  i = {
    ['<A-j>'] = { '<Esc>:move .+1<CR>==gi' },
    ['<A-k>'] = { '<Esc>:move .-2<CR>==gi' },
  },

  x = {
    ['<A-j>'] = { ":move '>+1<CR>gv-gv" },
    ['<A-k>'] = { ":move '<-2<CR>gv-gv" },
  },
}

-- more keybinds!

return M