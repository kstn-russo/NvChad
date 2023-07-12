local present, null_ls = pcall(require, "null-ls")
local h = require("null-ls.helpers")

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
  b.formatting.pint,
  b.diagnostics.phpmd.with {
    filetypes = { "php" },
    generator_opts = {
      command = "phpmd",
      args = {
        "--ignore-violations-on-exit",
        "-", -- process stdin
        "json",
        'phpmd.xml',
      },
      format = "json_raw",
      to_stdin = true,
      from_stderr = false,
      check_exit_code = function(code)
        return code <= 1
      end,
      on_output = function(params)
        local parser = h.diagnostics.from_json {
          attributes = {
            message = "description",
            severity = "priority",
            row = "beginLine",
            end_row = "endLine",
            code = "rule",
          },
          severities = {
            h.diagnostics.severities["error"],
            h.diagnostics.severities["warning"],
            h.diagnostics.severities["information"],
            h.diagnostics.severities["hint"],
          },
        }
        params.violations = params.output
            and params.output.files
            and params.output.files[1]
            and params.output.files[1].violations
          or {}

        return parser { output = params.violations }
      end,
    },
  },
  -- b.diagnostics.phpstan,
  -- php
  -- b.diagnostics.sonar
}

null_ls.setup {
  debug = true,
  sources = sources,
  diagnostics_format = "[#{c}] #{m} (#{s})",
}
