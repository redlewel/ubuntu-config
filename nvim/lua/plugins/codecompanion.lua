return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    { "MeanderingProgrammer/render-markdown.nvim", ft = { "markdown", "codecompanion" } },
  },
  opts = {
    adapters = {
      acp = {
        claude_code = function()
          return require("codecompanion.adapters").extend("claude_code", {
            env = {
              CLAUDE_CODE_OAUTH_TOKEN = "CLAUDE_CODE_OAUTH_TOKEN",
            },
          })
        end,
      },

      http = {
        minimax = function()
          return require("codecompanion.adapters").extend("openai_compatible", {
            env = {
              url = "https://openrouter.ai/api",
              api_key = "OPENROUTER_API_KEY",
              chat_url = "/v1/chat/completions",
            },
            schema = {
              model = {
                default = "minimax/minimax-m2.5",
              },
            },
            handlers = {
              parse_message_meta = function(self, data)
                return data
              end,
            },
          })
        end,

        deepseek = function()
          return require("codecompanion.adapters").extend("openai_compatible", {
            env = {
              url = "https://openrouter.ai/api",
              api_key = "OPENROUTER_API_KEY",
              chat_url = "/v1/chat/completions",
            },
            schema = {
              model = {
                default = "deepseek/deepseek-chat",
              },
            },
          })
        end,
      },
    },
	display = {
	  chat = {
		window = {
		  width = 0.3,
		  layout = "vertical",
		},
	  },
	},

    interactions = {
      chat = { adapter = "claude_code" },
      inline = { adapter = "minimax" },
      cmd = { adapter = "minimax" },
    },
  },

  keys = {
    { "<leader>ac", "<cmd>CodeCompanionChat Toggle<cr>", mode = { "n", "v" }, desc = "Toggle CodeCompanion Chat" },
    { "<leader>aa", "<cmd>CodeCompanionActions<cr>", mode = { "n", "v" }, desc = "CodeCompanion Actions" },
    { "<leader>ai", ":<C-u>'<,'>CodeCompanion ", mode = "v", desc = "CodeCompanion Inline" },
    { "<leader>as", "<cmd>CodeCompanionChat Add<cr>", mode = "v", desc = "Add Selection to Chat" },
    { "<leader>ae", ":<C-u>'<,'>CodeCompanion /explain<cr>", mode = "v", desc = "Explain Selection" },
    { "<leader>af", ":<C-u>'<,'>CodeCompanion /fix<cr>", mode = "v", desc = "Fix Selection" },
    { "<leader>at", ":<C-u>'<,'>CodeCompanion /tests<cr>", mode = "v", desc = "Generate Tests" },
  },

  init = function()
    vim.cmd([[cab cc CodeCompanion]])
  end,
}
