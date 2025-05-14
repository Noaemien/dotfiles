return {
  {
    dir = '~/documents/dev/fishllm/',
    dependencies = { 'nvim-lua/plenary.nvim', 'rcarriga/nvim-notify', 'nvim-telescope/telescope.nvim' },
    config = function()
      local fishllm = require("fishllm")
      local system_prompt =
      "You are an inline code completion ai. You are required to fill in the code where there is the <cursor/> marker. You have been provided with all relevant files. Do not simply copy the code i send you and do not use any backticks. write only code, nothing else. No comments, no text, no backtics, only code. No backtics. Only provide valid code. Look at what comes before and after cursor and provide a response that fits within given context."

      local function invoke_qwen_local()
        fishllm.invoke_llm({
          url = "https://llm.emien.ch/v1/chat/completions",
          model = "Qwen/Qwen2.5-Coder-32B-Instruct-AWQ",
          api_key_name = "EMIEN_API_KEY",
          max_tokens = 4096,
          system_prompt = system_prompt,

        }, fishllm.openai_request_data, fishllm.handle_openai_spec_data)
      end

      local function invoke_grok_mini()
        fishllm.invoke_llm({
          url = "https://api.x.ai/v1/chat/completions",
          model = "grok-3-mini",
          api_key_name = "XAI_API_KEY",
          max_tokens = 4096,
          system_prompt = system_prompt,

        }, fishllm.openai_request_data, fishllm.handle_openai_spec_data)
      end
      -- show suggestions on idle
      fishllm.set_cursor_hold_autocmd(invoke_qwen_local)

      vim.keymap.set({ 'n', 'v' }, '<leader>llm', fishllm.add_buf_to_context, { desc = "Add buffer to context" })
      vim.keymap.set({ 'n', 'v' }, '<leader>lls', fishllm.view_current_context, { desc = "View session context" })
      vim.keymap.set({ 'n', 'v' }, '<leader>lla', fishllm.accept_suggestions, { desc = "Accept llm suggestions" })
      vim.keymap.set({ 'n', 'v' }, '<leader>llb', fishllm.add_buf_to_marks, { desc = "Add buffer to marks" })
      vim.keymap.set({ 'n', 'v' }, '<leader>llv', fishllm.view_current_marks, { desc = "View session marks" })
      vim.keymap.set({ 'n', 'v' }, '<leader>lly', function() fishllm.load_mark(1) end, { desc = "Jump to first mark" })
      vim.keymap.set({ 'n', 'v' }, '<leader>llx', function() fishllm.load_mark(2) end, { desc = "Jump to second mark" })
      vim.keymap.set({ 'n', 'v' }, '<leader>llc', function() fishllm.load_mark(3) end, { desc = "Jump to third mark" })
      -- vim.keymap.set({ 'n', 'v' }, '<leader>llv', function() fishllm.load_mark(4) end, { desc = "Jump to fourth mark" })
      -- vim.keymap.set({ 'n', 'v' }, '<leader>lli', invoke_qwen_local())
      -- vim.keymap.set({ 'n', 'v' }, '<leader>llg', fishllm.display_suggestions)
    end
  }
}
