-- codecompanion-config.lua
-- Drop this into your lazy.nvim plugin specs
-- e.g., ~/.config/nvim/lua/plugins/codecompanion.lua

return {
  "olimorris/codecompanion.nvim",
  version = "^19.0.0",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    -- Optional but recommended: renders markdown nicely in the chat buffer
    { "MeanderingProgrammer/render-markdown.nvim", ft = { "markdown", "codecompanion" } },
  },
  opts = {
    adapters = {
      -- ACP adapters (for chat only)
      acp = {
        claude_code = function()
          return require("codecompanion.adapters").extend("claude_code", {
            env = {
              CLAUDE_CODE_OAUTH_TOKEN = "CLAUDE_CODE_OAUTH_TOKEN",  -- env var
            },
          })
        end,
      },
    
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
    
    interactions = {
      chat = { adapter = "claude_code" },
      inline = { adapter = "minimax" },
      cmd = { adapter = "minimax" },
    },
  },
  -- Keymaps
  keys = {
    -- Toggle chat buffer (your main on/off switch)
    { "<leader>ac", "<cmd>CodeCompanionChat Toggle<cr>", mode = { "n", "v" }, desc = "Toggle CodeCompanion Chat" },

    -- Open action palette (lists all available actions)
    { "<leader>aa", "<cmd>CodeCompanionActions<cr>", mode = { "n", "v" }, desc = "CodeCompanion Actions" },

    -- Inline assistant (type a prompt, AI writes into your buffer)
	{ "<leader>ai", ":<C-u>'<,'>CodeCompanion ", mode = "v", desc = "CodeCompanion Inline" },

    -- Add visual selection to current chat
    { "<leader>as", "<cmd>CodeCompanionChat Add<cr>", mode = "v", desc = "Add Selection to Chat" },

    -- Quick prompts from the prompt library (visual mode)
    { "<leader>ae", ":<C-u>'<,'>CodeCompanion /explain<cr>", mode = "v", desc = "Explain Selection" },
    { "<leader>af", ":<C-u>'<,'>CodeCompanion /fix<cr>", mode = "v", desc = "Fix Selection" },
    { "<leader>at", ":<C-u>'<,'>CodeCompanion /tests<cr>", mode = "v", desc = "Generate Tests" },
  },

  -- Shorthand: type :cc instead of :CodeCompanion in command mode
  init = function()
    vim.cmd([[cab cc CodeCompanion]])
  end,
}

-- SETUP INSTRUCTIONS:
--
-- 1. Set your OpenRouter API key as an environment variable:
--    export OPENROUTER_API_KEY="sk-or-v1-your-key-here"
--    (add this to ~/.bashrc, ~/.zshrc, or equivalent)
--
-- 2. Drop this file into ~/.config/nvim/lua/plugins/codecompanion.lua
--    (or wherever your lazy.nvim plugin specs live)
--
-- 3. Restart Neovim and run :Lazy sync
--
-- 4. Run :checkhealth codecompanion to verify everything is working
--
-- 5. Quick test: press <leader>ac to open chat, type a question, press <C-s>
--
-- KEYBIND SUMMARY:
--   <leader>ac  - Toggle chat buffer on/off
--   <leader>aa  - Open action palette
--   <leader>ai  - Inline assistant (prompt -> code in buffer)
--   <leader>as  - Add visual selection to chat (visual mode)
--   <leader>ae  - Explain selected code (visual mode)
--   <leader>af  - Fix selected code (visual mode)
--   <leader>at  - Generate tests for selection (visual mode)
--   :cc <prompt> - Quick inline prompt from command line
--
-- SWITCHING MODELS:
--   You can switch models on the fly in chat with:
--   :CodeCompanionChat adapter=deepseek
--   :CodeCompanionChat adapter=minimax
--
--   Or try any OpenRouter model by adding more adapters above
--   using the same pattern (just change schema.model.default)
--
-- COST TRACKING:
--   Check your OpenRouter usage at: https://openrouter.ai/activity
