-- Copilot autosuggestions
vim.g.copilot_no_tab_map = true
vim.g.copilot_hide_during_completion = false
vim.g.copilot_proxy_strict_ssl = false
vim.keymap.set('i', '<S-Tab>', 'copilot#Accept("\\<S-Tab>")', { expr = true, replace_keycodes = false })

-- Copilot chat
local chat = require('CopilotChat')
local prompts = require('CopilotChat.config.prompts')
local select = require('CopilotChat.select')
local cutils = require('CopilotChat.utils')

local COPILOT_PLAN = [[
You are a software architect and technical planner focused on clear, actionable development plans.
]] .. prompts.COPILOT_BASE.system_prompt .. [[

When creating development plans:
- Start with a high-level overview
- Break down into concrete implementation steps
- Identify potential challenges and their solutions
- Consider architectural impacts
- Note required dependencies or prerequisites
- Estimate complexity and effort levels
- Track confidence percentage (0-100%)
- Format in markdown with clear sections

Always end with:
"Current Confidence Level: X%"
"Would you like to proceed with implementation?" (only if confidence >= 90%)
]]

chat.setup({
    model = 'claude-3.7-sonnet',
    references_display = 'write',
    debug = false,
    selection = select.visual,
    context = 'buffers',
    mappings = {
        reset = false,
        accept_diff = {
            normal = '<C-a>',
            insert = '<C-a>',
        },
        show_diff = {
            full_diff = true,
        },
    },
    prompts = {},
    contexts = {
        vectorspace = {
            description =
            'Semantic search through workspace using vector embeddings. Find relevant code with natural language queries.',

            schema = {
                type = 'object',
                required = { 'query' },
                properties = {
                    query = {
                        type = 'string',
                        description = 'Natural language query to find relevant code.',
                    },
                    max = {
                        type = 'integer',
                        description = 'Maximum number of results to return.',
                        default = 10,
                    },
                },
            },

            resolve = function(input, source, prompt)
                local embeddings = cutils.curl_post('http://localhost:8000/query', {
                    json_request = true,
                    json_response = true,
                    body = {
                        dir = source.cwd(),
                        text = input.query or prompt,
                        max = input.max,
                    },
                }).body

                cutils.schedule_main()
                return vim.iter(embeddings)
                    :map(function(embedding)
                        embedding.filetype = cutils.filetype(embedding.filename)
                        return embedding
                    end)
                    :filter(function(embedding)
                        return embedding.filetype
                    end)
                    :totable()
            end,
        },
    },
})



vim.keymap.set({ 'n' }, '<leader>aa', chat.toggle, { desc = 'AI Toggle' })
vim.keymap.set({ 'n' }, '<leader>ax', chat.reset, { desc = 'AI Reset' })
vim.keymap.set({ 'n' }, '<leader>as', chat.stop, { desc = 'AI Stop' })
vim.keymap.set({ 'n' }, '<leader>am', chat.select_model, { desc = 'AI Models' })
vim.keymap.set({ 'n', 'v' }, '<leader>ap', chat.select_prompt, { desc = 'AI Prompts' })
