return {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
        {
            'L3MON4D3/LuaSnip',
            config = function(_, opts)
                local ls = require 'luasnip'

                local types = require 'luasnip.util.types'

                local luasnip_config_opts = {
                    history = true,
                    update_events = { 'TextChanged', 'TextChangedI' },
                    store_selection_keys = '<Tab>',
                    -- enable_autosnippets = true,

                    ext_opts = {
                        [types.choiceNode] = {
                            active = {
                                virt_text = { { '●●●', 'LuasnipChoice' } },
                            },
                        },
                        [types.insertNode] = {
                            active = {
                                virt_text = { { '●', 'LuasnipInsert' } },
                            },
                        },
                    },
                }

                ls.config.set_config(luasnip_config_opts)

                require("snippets.lua")

                vim.api.nvim_create_autocmd('InsertLeave', {
                    callback = function()
                        if require('luasnip').session.current_nodes[vim.api.nvim_get_current_buf()] and not require('luasnip').session.jump_active then
                            require('luasnip').unlink_current()
                        end
                    end,
                })
            end,
        },
        {
            'saadparwaiz1/cmp_luasnip',
            'hrsh7th/cmp-nvim-lua',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-calc',
        },
    }, -- cmp sources plugins
    opts = function()
        local cmp = require 'cmp'

        local function border(hl_name)
            return {
                { '╭', hl_name },
                { '─', hl_name },
                { '╮', hl_name },
                { '│', hl_name },
                { '╯', hl_name },
                { '─', hl_name },
                { '╰', hl_name },
                { '│', hl_name },
            }
        end

        local options = {
            enable_autosnippets = true,
            completion = {
                completeopt = 'menu,menuone',
                completion = { completeopt = 'menu,menuone,noinsert' },
            },

            window = {
                max_entries = 8,
                completion = {
                    winhighlight = 'Normal:CmpPmenu,CursorLine:CmpSel',
                    -- winhighlight = 'Normal:CmpPmenu,CursorLine:CmpSel,Search:PmenuSel',
                    scrollbar = false,
                },
                documentation = {
                    border = border 'CmpDocBorder',
                    winhighlight = 'Normal:CmpDoc',
                },
            },

            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                end,
            },

            mapping = {
                ['<up>'] = cmp.mapping.select_prev_item(),
                ['<down>'] = cmp.mapping.select_next_item(),
                ['<C-d>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-e>'] = cmp.mapping.close(),
                ['<CR>'] = cmp.mapping.confirm {
                    behavior = cmp.ConfirmBehavior.Insert,
                    select = true,
                },
                ['<Tab>'] = cmp.mapping(function(fallback)
                    if require('luasnip').expand_or_jumpable() then
                        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-expand-or-jump', true, true, true), '')
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
                ['<S-Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif require('luasnip').jumpable(-1) then
                        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-jump-prev', true, true, true), '')
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
            },
            sources = {
                { name = 'luasnip' },
                {
                    name = 'buffer',
                    option = {
                        keyword_pattern = [[\k\+]],
                    },
                },
            },
        }

        return options
    end,
    config = function(_, opts)
        require('cmp').setup(opts)
    end,
}
