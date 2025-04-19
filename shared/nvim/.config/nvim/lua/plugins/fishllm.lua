return {
  {
    dir = '~/documents/dev/fishllm/',
    dependencies = { 'nvim-lua/plenary.nvim', 'rcarriga/nvim-notify', 'nvim-telescope/telescope.nvim' },
    config = function()
      local fishllm = require("fishllm")
      local system_prompt =
      "You are a senior dev. You are passing a very important test and need to fill in the code where there is the <cursor/> marker. Do not use any backticks. write only code, nothing else. No comments, no text, no backtics, only code."

      fishllm.read_config()

      local function invoke_qwen_local()
        fishllm.invoke_llm({
          url = "https://llm.emien.ch/v1/chat/completions",
          model = "Qwen/Qwen2.5-Coder-32B-Instruct-AWQ",
          api_key_name = "EMIEN_API_KEY",
          max_tokens = 4096,
          system_prompt = system_prompt,

        }, fishllm.openai_request_data, fishllm.handle_openai_spec_data)
      end

      -- vim.api.nvim_create_autocmd("InsertCharPre", {
      --   callback = function()
      --     invoke_qwen_local()
      --   end,
      -- })

      vim.keymap.set({ 'n', 'v' }, '<leader>llm', fishllm.add_buf_to_context)
      vim.keymap.set({ 'n', 'v' }, '<leader>llr', fishllm.read_config)
      vim.keymap.set({ 'n', 'v' }, '<leader>lls', fishllm.view_context)
      vim.keymap.set({ 'n', 'v' }, '<leader>lli', invoke_qwen_local)
      vim.keymap.set({ 'n', 'v' }, '<leader>lla', fishllm.accept_suggestions)
      -- vim.keymap.set({ 'n', 'v' }, '<leader>llg', fishllm.display_suggestions)
    end
  }
}
