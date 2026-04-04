return {
  {
    "nvim-neotest/neotest",
    version = "v5.*",
    dependencies = {
      "nvim-neotest/nvim-nio",
      {
        "fredrikaverpil/neotest-golang",
        version = "v2.*",
      },
    },
    keys = {
      { "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "[t]est run [f]ile", },
      { "<leader>tA", function() require("neotest").run.run(vim.uv.cwd()) end, desc = "[t]est [A]ll files", },
      { "<leader>tS", function() require("neotest").run.run({ suite = true }) end, desc = "[t]est [S]uite", },
      { "<leader>tn", function() require("neotest").run.run() end, desc = "[t]est [n]earest", },
      { "<leader>tl", function() require("neotest").run.run_last() end, desc = "[t]est [l]ast", },
      { "<leader>ts", function() require("neotest").summary.toggle() end, desc = "[t]est [s]ummary", },
      { "<leader>to", function() require("neotest").output.open({ enter = true, auto_close = true }) end, desc = "[t]est [o]utput", },
      { "<leader>tO", function() require("neotest").output_panel.toggle() end, desc = "[t]est [O]utput panel", },
      { "<leader>tt", function() require("neotest").run.stop() end, desc = "[t]est [t]erminate", },
    },
    config = function()
      local neotest_ns = vim.api.nvim_create_namespace("neotest")
      vim.diagnostic.config({
        virtual_text = {
          format = function(diagnostic)
            local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
            return message
          end,
        },
      }, neotest_ns)

      local function load_dotenv(filepath)
        local env = {}
        local f = io.open(filepath, "r")
        if not f then
          return env
        end
        for line in f:lines() do
          if not line:match("^#") and line:match("=") then
            local key, val = line:match("^(.-)=(.*)$")
            if key then
              env[key] = val
            end
          end
        end
        f:close()
        return env
      end

      require("neotest").setup({
        adapters = {
          require("neotest-golang")({
            go_test_args = { "-v", "-count=1", "-race" },
            env = load_dotenv(vim.fn.getcwd() .. "/.env"),
          }),
        },
      })
    end,
  },
}
