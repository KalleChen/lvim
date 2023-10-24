lvim.colorscheme = "tokyonight-storm"
vim.opt.relativenumber = true
lvim.transparent_window = true
vim.opt.cursorline = false

vim.opt.foldcolumn = "1"
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 99
vim.opt.foldenable = true
vim.o.fillchars = [[eob: ,fold: ,foldopen:▾,foldsep: ,foldclose:▸]]

vim.keymap.set("i", "jk", "<ESC>", {silent = true})
lvim.keys.normal_mode["E"] = "$"
lvim.keys.normal_mode["B"] = "^"
lvim.keys.visual_mode["E"] = "$"
lvim.keys.visual_mode["B"] = "^"

lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"
lvim.builtin.which_key.mappings["C"] = {
    name = "Python",
    c = {"<cmd>lua require('swenv.api').pick_venv()<cr>", "Choose Env"}
}
lvim.builtin.which_key.mappings["r"] = {
    name = "Replace",
    r = {"<cmd>lua require('spectre').open()<cr>", "Replace"},
    w = {
        "<cmd>lua require('spectre').open_visual({select_word=true})<cr>",
        "Replace Word"
    },
    f = {"<cmd>lua require('spectre').open_file_search()<cr>", "Replace Buffer"}
}
lvim.builtin.which_key.mappings["t"] = {
    name = "Todo",
    l = {"<cmd>TodoTrouble<CR>", "Trouble List"}
}

lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

lvim.builtin.treesitter.ensure_installed = {
    "bash", "c", "javascript", "json", "lua", "python", "typescript", "tsx",
    "css", "rust", "java", "yaml"
}

lvim.builtin.treesitter.ignore_install = {"haskell"}
lvim.builtin.treesitter.highlight.enable = true

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
    {
        command = "prettier",
        filetypes = {
            "html", "htmldjango", "javascript", "json", "javascriptreact",
            "typescript", "typescriptreact", "css", "http"
        }
    }, {command = "black", filetypes = {"python"}},
    {command = "lua-format", filetypes = {"lua"}}
}

local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
    {command = "flake8", filetypes = {"python"}}, {
        command = "eslint",
        filetypes = {
            "javascript", "javascriptreact", "typescript", "typescriptreact"
        }
    }, {command = "luacheck", filetypes = {"lua"}}
}

local code_actions = require "lvim.lsp.null-ls.code_actions"
code_actions.setup {
    {
        command = "eslint",
        filetypes = {
            "javascript", "javascriptreact", "typescript", "typescriptreact"
        }
    }
}

local copilot_config = function()
    require("copilot").setup {
        plugin_manager_path = get_runtime_dir() .. "/site/pack/packer",
        suggestion = {
            auto_trigger = true,
            keymap = {accept = "<C-e>", next = "<C-l>", prev = "<C-h>"}
        }
    }
end
local spectre_config = function()
    require("spectre").setup({
        color_devicons = true,
        highlight = {
            ui = "String",
            search = "DiffChange",
            replace = "DiffDelete"
        },
        mapping = {
            ["toggle_line"] = {
                map = "t",
                cmd = "<cmd>lua require('spectre').toggle_line()<CR>",
                desc = "toggle current item"
            },
            ["enter_file"] = {
                map = "<cr>",
                cmd = "<cmd>lua require('spectre.actions').select_entry()<CR>",
                desc = "goto current file"
            },
            ["send_to_qf"] = {
                map = "Q",
                cmd = "<cmd>lua require('spectre.actions').send_to_qf()<CR>",
                desc = "send all item to quickfix"
            },
            ["replace_cmd"] = {
                map = "c",
                cmd = "<cmd>lua require('spectre.actions').replace_cmd()<CR>",
                desc = "input replace vim command"
            },
            ["show_option_menu"] = {
                map = "o",
                cmd = "<cmd>lua require('spectre').show_options()<CR>",
                desc = "show option"
            },
            ["run_replace"] = {
                map = "R",
                cmd = "<cmd>lua require('spectre.actions').run_replace()<CR>",
                desc = "replace all"
            },
            ["change_view_mode"] = {
                map = "m",
                cmd = "<cmd>lua require('spectre').change_view()<CR>",
                desc = "change result view mode"
            },
            ["toggle_ignore_case"] = {
                map = "I",
                cmd = "<cmd>lua require('spectre').change_options('ignore-case')<CR>",
                desc = "toggle ignore case"
            },
            ["toggle_ignore_hidden"] = {
                map = "H",
                cmd = "<cmd>lua require('spectre').change_options('hidden')<CR>",
                desc = "toggle search hidden"
            }
            -- you can put your mapping here it only use normal mode
        },
        find_engine = {
            -- rg is map with finder_cmd
            ["rg"] = {
                cmd = "rg",
                -- default args
                args = {
                    "--color=never", "--no-heading", "--with-filename",
                    "--line-number", "--column"
                },
                options = {
                    ["ignore-case"] = {
                        value = "--ignore-case",
                        icon = "[I]",
                        desc = "ignore case"
                    },
                    ["hidden"] = {
                        value = "--hidden",
                        desc = "hidden file",
                        icon = "[H]"
                    }
                    -- you can put any option you want here it can toggle with
                    -- show_option function
                }
            },
            ["ag"] = {
                cmd = "ag",
                args = {"--vimgrep", "-s"},
                options = {
                    ["ignore-case"] = {
                        value = "-i",
                        icon = "[I]",
                        desc = "ignore case"
                    },
                    ["hidden"] = {
                        value = "--hidden",
                        desc = "hidden file",
                        icon = "[H]"
                    }
                }
            }
        },
        replace_engine = {
            ["sed"] = {cmd = "sed", args = nil},
            options = {
                ["ignore-case"] = {
                    value = "--ignore-case",
                    icon = "[I]",
                    desc = "ignore case"
                }
            }
        },
        default = {
            find = {
                -- pick one of item in find_engine
                cmd = "rg",
                options = {"ignore-case"}
            },
            replace = {
                -- pick one of item in replace_engine
                cmd = "sed"
            }
        },
        replace_vim_cmd = "cdo",
        is_open_target_win = true, -- open file on opener window
        is_insert_mode = false -- start open panel on is_insert_mode

    })
end

local git_blame_config = function()
    vim.cmd "highlight default link gitblame SpecialComment"
    vim.g.gitblame_enabled = 0
end

local swenv_config = function()
    require('swenv').setup({
        post_set_venv = function() vim.cmd("LspRestart") end
    })
end

local statuscol_config = function()
    local builtin = require("statuscol.builtin")
    require("statuscol").setup({
        relculright = true,
        segments = {
            {text = {builtin.foldfunc}, click = "v:lua.ScFa"},
            {text = {"%s"}, click = "v:lua.ScSa"},
            {text = {builtin.lnumfunc, " "}, click = "v:lua.ScLa"}
        }
    })
end

local ufo_config = function()
    vim.o.foldcolumn = '1' -- '0' is not bad
    vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true
    vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

    -- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
    vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
    vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
    local handler = function(virtText, lnum, endLnum, width, truncate)
        local newVirtText = {}
        local suffix = (' 󰁂 %d '):format(endLnum - lnum)
        local sufWidth = vim.fn.strdisplaywidth(suffix)
        local targetWidth = width - sufWidth
        local curWidth = 0
        for _, chunk in ipairs(virtText) do
            local chunkText = chunk[1]
            local chunkWidth = vim.fn.strdisplaywidth(chunkText)
            if targetWidth > curWidth + chunkWidth then
                table.insert(newVirtText, chunk)
            else
                chunkText = truncate(chunkText, targetWidth - curWidth)
                local hlGroup = chunk[2]
                table.insert(newVirtText, {chunkText, hlGroup})
                chunkWidth = vim.fn.strdisplaywidth(chunkText)
                -- str width returned from truncate() may less than 2nd argument, need padding
                if curWidth + chunkWidth < targetWidth then
                    suffix = suffix ..
                                 (' '):rep(targetWidth - curWidth - chunkWidth)
                end
                break
            end
            curWidth = curWidth + chunkWidth
        end
        table.insert(newVirtText, {suffix, 'MoreMsg'})
        return newVirtText
    end
    require('ufo').setup({
        provider_selector = function(bufnr, filetype, buftype)
            return {'treesitter', 'indent'}
        end,
        fold_virt_text_handler = handler
    })
end

local aerial_config = function()
    require("aerial").setup({
        backends = {"lsp", "treesitter"},
        layout = {default_direction = "right"},
        close_automatic_events = {'unfocus'},
        filter_kind = {
            "Class", "Constructor", "Enum", "Function", "Interface", "Module",
            "Method", "Struct", "Variable", "Constant", "NameSpace", "Package",
            "Field", "Event", "Operator", "TypeParameter", "Key"
        },
        manage_folds = true,
        link_folds_to_tree = false,
        link_tree_to_folds = true,
        open_automatic = true,
        lsp = {
            diagnostics_trigger_update = true,
            update_when_errors = true,
            update_delay = 300
        },
        treesitter = {update_delay = 300}
    })
end

lvim.plugins = {
    {
        "zbirenbaum/copilot.lua",
        event = {"VimEnter"},
        config = function() vim.defer_fn(copilot_config, 100) end
    }, {"folke/trouble.nvim", cmd = "TroubleToggle"},
    {"windwp/nvim-spectre", event = "BufRead", config = spectre_config}, {
        "folke/todo-comments.nvim",
        event = "BufRead",
        config = function() require("todo-comments").setup() end
    }, {'mg979/vim-visual-multi'}, {"wakatime/vim-wakatime"},
    {"f-person/git-blame.nvim", event = "BufRead", config = git_blame_config},
    {"p00f/nvim-ts-rainbow"}, {"sindrets/diffview.nvim", event = "BufRead"}, {
        "windwp/nvim-ts-autotag",
        event = "InsertEnter",
        config = function() require("nvim-ts-autotag").setup() end
    }, {
        "iamcco/markdown-preview.nvim",
        build = "cd app && npm install",
        init = function() vim.g.mkdp_filetypes = {"markdown"} end,
        ft = {"markdown"}
    }, {'andweeb/presence.nvim'}, {'AckslD/swenv.nvim', config = swenv_config},
    {'stevearc/dressing.nvim', opts = {}}, {
        'kevinhwang91/nvim-ufo',
        dependencies = {
            'kevinhwang91/promise-async',
            {"luukvbaal/statuscol.nvim", config = statuscol_config}
        },
        config = ufo_config
    }, {
        'stevearc/aerial.nvim',
        opts = {},
        -- Optional dependencies
        dependencies = {
            "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons"
        },
        config = aerial_config
    }
}
