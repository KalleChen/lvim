--[[
lvim is the global options object

Linters should be
filled in as strings with either
a global executable or a path to
an executable
]] -- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT
-- general
lvim.log.level = "warn"
lvim.format_on_save = false
lvim.lint_on_save = true
lvim.colorscheme = "github_dark"
vim.opt.relativenumber = true
lvim.transparent_window = false
vim.opt.cursorline = false

-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["E"] = "$"
lvim.keys.normal_mode["B"] = "^"
lvim.keys.visual_mode["E"] = "$"
lvim.keys.visual_mode["B"] = "^"

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
-- unmap a default keymapping
-- vim.keymap.del("n", "<C-Up>")
-- override a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>" -- or vim.keymap.set("n", "<C-q>", ":q<cr>" )

-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
-- local _, actions = pcall(require, "telescope.actions")
-- lvim.builtin.telescope.defaults.mappings = {
--   -- for input mode
--   i = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--     ["<C-n>"] = actions.cycle_history_next,
--     ["<C-p>"] = actions.cycle_history_prev,
--   },
--   -- for normal mode
--   n = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--   },
-- }

-- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
-- lvim.builtin.which_key.mappings["t"] = {
--   name = "+Trouble",
--   r = { "<cmd>Trouble lsp_references<cr>", "References" },
--   f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
--   d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
--   q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
--   l = { "<cmd>Trouble loclist<cr>", "LocationList" },
--   w = { "<cmd>Trouble workspace_diagnostics<cr>", "Wordspace Diagnostics" },
-- }

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.filters.dotfiles = false
lvim.builtin.nvimtree.setup.renderer.icons.show.git = true

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
    "bash", "c", "javascript", "json", "lua", "python", "typescript", "tsx",
    "css", "rust", "java", "yaml", 'http'
}

lvim.builtin.treesitter.ignore_install = {"haskell"}
lvim.builtin.treesitter.highlight.enabled = true

-- generic LSP settings

-- ---@usage disable automatic installation of servers
-- lvim.lsp.automatic_servers_installation = false

-- ---configure a server manually. !!Requires `:LvimCacheReset` to take effect!!
-- ---see the full default list `:lua print(vim.inspect(lvim.lsp.automatic_configuration.skipped_servers))`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pyright", opts)

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. !!Requires `:LvimCacheReset` to take effect!!
-- ---`:LvimInfo` lists which server(s) are skiipped for the current filetype
-- vim.tbl_map(function(server)
--   return server ~= "emmet_ls"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- -- set a formatter, this will override the language server formatting capabilities (if it exists)
-- local formatters = require "lvim.lsp.null-ls.formatters"
-- formatters.setup {
--   { command = "black", filetypes = { "python" } },
--   { command = "isort", filetypes = { "python" } },
--   {
--     -- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--     command = "prettier",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     extra_args = { "--print-with", "100" },
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "typescript", "typescriptreact" },
--   },
-- }
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
    {
        command = "prettier",
        filetypes = {
            "html", "htmldjango", "javascript", "json", "javascriptreact",
            "typescript", "typescriptreact", "css", "http", "solidity"
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
    }, {command = "luacheck", filetypes = {"lua"}},
    {command = "solhint", filetypes = {"solidity"}}
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

-- -- set additional linters
-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup {
--   { command = "flake8", filetypes = { "python" } },
--   {
--     -- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--     command = "shellcheck",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     extra_args = { "--severity", "warning" },
--   },
--   {
--     command = "codespell",
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "javascript", "python" },
--   },
-- }

-- Additional Plugins
-- lvim.plugins = {
--     {"folke/tokyonight.nvim"},
--     {
--       "folke/trouble.nvim",
--       cmd = "TroubleToggle",
--     },
-- }

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- vim.api.nvim_create_autocmd("BufEnter", {
--   pattern = { "*.json", "*.jsonc" },
--   -- enable wrap mode for json files only
--   command = "setlocal wrap",
-- })
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "zsh",
--   callback = function()
--     -- let treesitter use bash highlight for zsh files as well
--     require("nvim-treesitter.highlight").attach(0, "bash")
--   end,
-- })

lvim.plugins = {
    {"folke/trouble.nvim", cmd = "TroubleToggle"}, {
        "windwp/nvim-spectre",
        event = "BufRead",
        config = function()
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
    }, {
        "karb94/neoscroll.nvim",
        event = "WinScrolled",
        config = function()
            require('neoscroll').setup({
                -- All these keys will be mapped to their corresponding default scrolling animation
                mappings = {
                    "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt",
                    "zz", "zb"
                },
                hide_cursor = true, -- Hide cursor while scrolling
                stop_eof = true, -- Stop at <EOF> when scrolling downwards
                use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
                respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
                cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
                easing_function = nil, -- Default easing function
                pre_hook = nil, -- Function to run before the scrolling animation starts
                post_hook = nil -- Function to run after the scrolling animation ends
            })
        end
    }, {'projekt0n/github-nvim-theme'}, {'TovarishFin/vim-solidity'}, {
        "folke/todo-comments.nvim",
        event = "BufRead",
        config = function() require("todo-comments").setup() end
    }, {'ellisonleao/glow.nvim'},
    {'pwntester/octo.nvim', config = function() require"octo".setup() end},
    {'andweeb/presence.nvim'}, {'mg979/vim-visual-multi'},
    {"github/copilot.vim"}, {"wakatime/vim-wakatime"}, {
        "f-person/git-blame.nvim",
        event = "BufRead",
        config = function()
            vim.cmd "highlight default link gitblame SpecialComment"
            vim.g.gitblame_enabled = 0
        end
    }, {
        "tpope/vim-fugitive",
        cmd = {
            "G", "Git", "Gdiffsplit", "Gread", "Gwrite", "Ggrep", "GMove",
            "GDelete", "GBrowse", "GRemove", "GRename", "Glgrep", "Gedit"
        },
        ft = {"fugitive"}
    }, {"p00f/nvim-ts-rainbow"}, {"sindrets/diffview.nvim", event = "BufRead"},
    {
        "windwp/nvim-ts-autotag",
        event = "InsertEnter",
        config = function() require("nvim-ts-autotag").setup() end
    }, {"rafamadriz/neon"}, {
        'navarasu/onedark.nvim',
        config = function()
            require('onedark').setup {style = 'darker'}
            require('onedark').load()
        end
    }, {'ianding1/leetcode.vim'}, {
        "lukas-reineke/indent-blankline.nvim",
        event = "BufRead",
        setup = function()
            vim.g.indentLine_enabled = 1
            vim.g.indent_blankline_char = "|"
            vim.g.indent_blankline_filetype_exclude = {
                "help", "terminal", "dashboard"
            }
            vim.g.indent_blankline_buftype_exclude = {"terminal"}
            vim.g.indent_blankline_show_trailing_blankline_indent = false
            vim.g.indent_blankline_show_first_indent_level = false
            vim.g.indent_blankline_show_current_context = true
            vim.g.indent_blankline_show_current_context_start = true
        end
    }, {
        "iamcco/markdown-preview.nvim",
        run = "cd app && npm install",
        ft = "markdown",
        config = function() vim.g.mkdp_auto_start = 1 end
    }, {
        "NTBBloodbath/rest.nvim",
        requires = {"nvim-lua/plenary.nvim"},
        config = function()
            require("rest-nvim").setup({
                -- Open request results in a horizontal split
                result_split_horizontal = false,
                -- Keep the http file buffer above|left when split horizontal|vertical
                result_split_in_place = false,
                -- Skip SSL verification, useful for unknown certificates
                skip_ssl_verification = false,
                -- Highlight request on run
                highlight = {enabled = true, timeout = 150},
                result = {
                    -- toggle showing URL, HTTP info, headers at top the of result window
                    show_url = true,
                    show_http_info = true,
                    show_headers = true
                },
                -- Jump to request line on run
                jump_to_request = false,
                env_file = '.env',
                custom_dynamic_variables = {},
                yank_dry_run = true
            })
        end
    }

}

vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true
vim.g.copilot_tab_fallback = ""
local cmp = require "cmp"
lvim.builtin.cmp.mapping["<C-e>"] = function(fallback)
    cmp.mapping.abort()
    local copilot_keys = vim.fn["copilot#Accept"]()
    if copilot_keys ~= "" then
        vim.api.nvim_feedkeys(copilot_keys, "i", true)
    else
        fallback()
    end
end

vim.g.leetcode_solution_filetype = 'javascript'
vim.g.leetcode_browser = "chrome"
