local present, null_ls = pcall(require, "null-ls")
local h = require "null-ls.helpers"

if not present then
  return
end

local b = null_ls.builtins

local sources = {

  -- webdev stuff
  b.formatting.deno_fmt, -- choosed deno for ts/js files cuz its very fast!
  b.formatting.prettier.with { filetypes = { "html", "markdown", "css" } }, -- so prettier works only on these filetypes

  -- Lua
  b.formatting.stylua,

  -- cpp
  b.formatting.clang_format,

  -- php
  b.diagnostics.phpstan.with {
    extra_args = { "--level", "9" },
  },
  b.diagnostics.phpcs.with {
    extra_args = { "--standard", "/home/kr/.config/phpcs/rules.xml" },
  },
  b.formatting.pint,
}

null_ls.setup {
  debug = true,
  sources = sources,
  diagnostics_format = "[#{c}] #{m} (#{s})",
}
