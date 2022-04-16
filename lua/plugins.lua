return require("packer").startup(function(use)
	-- Packer can manage itself
	use("wbthomason/packer.nvim")

	-- 常用默认设置
	-- https://github.com/tpope/vim-sensible
	use("tpope/vim-sensible")

	-- 文件浏览器
	-- https://github.com/kyazdani42/nvim-tree.lua
	use({
		"kyazdani42/nvim-tree.lua",
		requires = {
			"kyazdani42/nvim-web-devicons", -- optional, for file icon
		},
		config = function()
			vim.api.nvim_set_keymap("n", "<C-n>", "<cmd>NvimTreeToggle<cr>", {})
			require("nvim-tree").setup({
				-- open the tree when running this setup function
				open_on_setup = true,
				open_on_setup_file = true,
				open_on_tab = true,
				-- update the focused file on `BufEnter`, un-collapses the folders recursively until it finds the file
				update_focused_file = {
					-- enables the feature
					enable = true,
					-- update the root directory of the tree to the one of the folder containing the file if the file is not under the current root directory
					-- only relevant when `update_focused_file.enable` is true
					update_cwd = false,
					-- list of buffer names / filetypes that will not update the cwd if the file isn't found under the current root directory
					-- only relevant when `update_focused_file.update_cwd` is true and `update_focused_file.enable` is true
					ignore_list = {},
				},
			})
		end,
	})

	-- 配色方案
	use({
		"EdenEast/nightfox.nvim",
		config = function()
			local nightfox = require("nightfox")
			-- This function set the configuration of nightfox. If a value is not passed in the setup function
			-- it will be taken from the default configuration above
			-- https://github.com/EdenEast/nightfox.nvim
			nightfox.setup({
				options = {
					styles = {
						comments = "italic", -- change style of comments to be italic
						-- keywords = "bold", -- change style of keywords to be bold
						-- functions = "italic,bold", -- styles can be a comma separated list
					},
				},
			})

			vim.cmd([[ silent! colorscheme nordfox ]])
		end,
	})

	-- 滚动条
	-- use 'dstein64/nvim-scrollview'

	-- git
	use("tpope/vim-fugitive")
	-- https://github.com/itchyny/vim-gitbranch
	-- 这个插件提供了一个返回 git 分支名称的函数
	use("itchyny/vim-gitbranch")
	-- git
	-- use({
	-- 	"lewis6992/gitsigns.nvim",
	-- 	requires = { "nvim-lua/plenary.nvim" },
	-- 	config = function()
	-- 		require("gitsigns").setup({
	-- 			signs = {
	-- 				add = { hl = "DiffAdd", text = "│", numhl = "GitSignsAddNr" },
	-- 				change = { hl = "DiffChange", text = "│", numhl = "GitSignsChangeNr" },
	-- 				delete = { hl = "DiffDelete", text = "_", numhl = "GitSignsDeleteNr" },
	-- 				topdelete = { hl = "DiffDelete", text = "‾", numhl = "GitSignsDeleteNr" },
	-- 				changedelete = { hl = "DiffChange", text = "~", numhl = "GitSignsChangeNr" },
	-- 			},
	-- 			numhl = false,
	-- 			sign_priority = 7,
	-- 			status_formatter = nil, -- Use default
	-- 		})
	-- 	end,
	-- })

	-- 启动页
	-- https://github.com/mhinz/vim-startify
	use("mhinz/vim-startify")

	-- 状态行
	-- https://github.com/itchyny/lightline.vim
	use({
		"itchyny/lightline.vim",
		config = function()
			vim.g.lightline = {
				["enable"] = { ["statusline"] = 1, ["tabline"] = 1 },
				-- ["colorscheme"] = "nightfox",
				["active"] = {
					["left"] = { { "mode", "paste" }, { "gitbranch", "readonly", "filename", "modified" } },
				},
				["tabline"] = {
					["left"] = { { "tabs" } },
					["right"] = { { "close" } },
				},
				["component_function"] = {
					["gitbranch"] = "FugitiveHead",
				},
			}
		end,
	})

	-- 格式化
	-- https://github.com/mhartington/formatter.nvim
	use({
		"mhartington/formatter.nvim",
		config = function()
			require("formatter").setup({
				logging = true,
				-- https://github.com/mhartington/formatter.nvim/blob/master/CONFIG.md
				filetype = {
					lua = {
						function()
							return {
								-- paru stylua for archlinux
								exe = "stylua",
								args = {
									"--search-parent-directories",
									"--stdin-filepath",
									vim.api.nvim_buf_get_name(0),
									"-",
								},
								stdin = true,
							}
						end,
					},
					javascript = {
						-- prettier
						function()
							return {
								exe = "prettier",
								args = { "--stdin-filepath", vim.api.nvim_buf_get_name(0), "--single-quote" },
								stdin = true,
							}
						end,
					},
				},
			})
			vim.api.nvim_set_keymap("n", "<leader>kf", "<cmd>Format<cr>", { noremap = true, silent = true })
		end,
	})

	-- 括号 引号 自动配对
	use("jiangmiao/auto-pairs")

	-- 文件变更提示
	-- https://github.com/chrisbra/changesPlugin
	use("chrisbra/changesPlugin")

	-- 快速跳转
	-- https://github.com/phaazon/hop.nvim
	use({
		"phaazon/hop.nvim",
		config = function()
			require("hop").setup({ keys = "etovxqpdygfblzhckisuran", term_seq_bias = 0.5 })
			vim.api.nvim_set_keymap("n", "s", "<cmd>lua require'hop'.hint_char2()<cr>", {})
			vim.api.nvim_set_keymap("n", "S", "<cmd>lua require'hop'.hint_patterns()<cr>", {})
		end,
	})

	-- 相对行数
	-- https://github.com/jeffkreeftmeijer/vim-numbertoggle
	use("jeffkreeftmeijer/vim-numbertoggle")

	-- 惯性滚动
	-- https://github.com/yuttie/comfortable-motion.vim
	use("yuttie/comfortable-motion.vim")

	-- 快速注释
	use({
		"preservim/nerdcommenter",
		config = function()
			vim.g.NERDCreateDefaultMappings = 1
			vim.g.NERDSpaceDelims = 1
			vim.g.NERDCompactSexyComs = 1
			vim.g.NERDDefaultAlign = "left"
			vim.g.NERDCommentEmptyLines = 1
			vim.g.NERDTrimTrailingWhitespace = 1
			vim.g.NERDToggleCheckAllLines = 1
		end,
	})
	use("tpope/vim-commentary")
	use({
		"JoosepAlviste/nvim-ts-context-commentstring",
		requires = { "nvim-treesitter/nvim-treesitter" },
	})

	-- 快速去除尾部空格
	use("bronson/vim-trailing-whitespace")

	-- 快速区域选择
	-- https://github.com/terryma/vim-expand-region
	-- S+ S-
	use("terryma/vim-expand-region")

	-- 浮动窗口
	use({
		"numtostr/FTerm.nvim",
		config = function()
			require("FTerm").setup({
				dimensions = {
					height = 0.8,
					width = 0.8,
					x = 0.5,
					y = 0.5,
				},
				border = "single", -- or 'double'
			})
			-- Running gitui
			-- paru gitui for archlinux
			local gitui = require("FTerm.terminal"):new():setup({
				cmd = "gitui",
				dimensions = {
					height = 0.9,
					width = 0.9,
				},
			})
			-- Use this to toggle gitui in a floating terminal
			function _G.__fterm_gitui()
				gitui:toggle()
			end
			vim.api.nvim_set_keymap(
				"n",
				"<leader>i",
				'<CMD>lua require("FTerm").toggle()<CR>',
				{ noremap = true, silent = true }
			)
			vim.api.nvim_set_keymap("n", "<leader>j", "<CMD>lua __fterm_gitui()<CR>", { noremap = true, silent = true })
		end,
	})

	-- 模糊查找
	-- https://github.com/nvim-telescope/telescope.nvim
	use({
		"nvim-telescope/telescope.nvim",
		requires = { { "nvim-lua/popup.nvim" }, { "nvim-lua/plenary.nvim" } },
		config = function()
			-- This will load fzy_native and have it override the default file sorter
			-- require("telescope").load_extension("fzy_native")

			local actions = require("telescope.actions")
			require("telescope").setup({
				defaults = {
					mappings = {
						i = {
							-- To disable a keymap, put [map] = false
							-- So, to not map "<C-n>", just put
							["<C-n>"] = false,
							["<C-p>"] = false,

							["<C-j>"] = actions.move_selection_next,
							["<C-k>"] = actions.move_selection_previous,
						},
					},
				},
			})
			vim.api.nvim_set_keymap(
				"n",
				"gr",
				'<cmd>lua require ("telescope.builtin").lsp_references()<cr>',
				{ silent = true }
			)
			vim.api.nvim_set_keymap(
				"n",
				"<leader><leader><leader>",
				'<cmd>lua require ("telescope.builtin").live_grep()<cr>',
				{}
			)
			vim.api.nvim_set_keymap(
				"n",
				"<leader><leader>",
				'<cmd>lua require ("telescope.builtin").find_files()<cr>',
				{}
			)
			vim.api.nvim_set_keymap(
				"n",
				"<leader>d",
				'<cmd>lua require ("telescope.builtin").lsp_definitions()<cr>',
				{ silent = true }
			)
			vim.api.nvim_set_keymap(
				"n",
				"<leader>a",
				'<cmd>lua require ("telescope.builtin").lsp_code_actions()<cr>',
				{ silent = true }
			)
			vim.api.nvim_set_keymap(
				"n",
				"<leader>ss",
				'<cmd>lua require ("telescope.builtin").git_status()<cr>',
				{ silent = true }
			)
			vim.api.nvim_set_keymap(
				"n",
				"<leader>bb",
				'<cmd>lua require ("telescope.builtin").git_branches()<cr>',
				{ silent = true }
			)
		end,
	})

	-- 语法树
	-- https://github.com/nvim-treesitter/nvim-treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"go",
					"typescript",
					"javascript",
					"php",
					"html",
					"css",
					"toml",
					"yaml",
					"vue",
					"bash",
					"lua",
					"json",
					"rust",
				},
				highlight = { enable = true },
			})
		end,
	})
	-- https://github.com/chr4/nginx.vim
	use("chr4/nginx.vim")

	use({
		"folke/trouble.nvim",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("trouble").setup({
				position = "right",
			})
		end,
	})

	-- lsp
	-- https://github.com/rrethy/vim-illuminate
	use({
		"rrethy/vim-illuminate",
		config = function()
			vim.g.Illuminate_ftblacklist = { "NvimTree" }
		end,
	})
	-- https://github.com/neovim/nvim-lspconfig
	use({
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")
			local mix_attach = function(client, bufnr)
				require("illuminate").on_attach(client)
				--require("completion").on_attach(client)
				--vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

				--vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', { noremap=true, silent=true })
				-- Set some keybinds conditional on server capabilities
				if client.resolved_capabilities.document_formatting then
					vim.api.nvim_buf_set_keymap(
						bufnr,
						"n",
						"<space>f",
						"<cmd>lua vim.lsp.buf.formatting()<CR>",
						{ noremap = true, silent = true }
					)
				elseif client.resolved_capabilities.document_range_formatting then
					vim.api.nvim_buf_set_keymap(
						bufnr,
						"n",
						"<space>f",
						"<cmd>lua vim.lsp.buf.range_formatting()<CR>",
						{ noremap = true, silent = true }
					)
				end
			end

			-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#gopls
			-- go install golang.org/x/tools/gopls@latest
			lspconfig.gopls.setup({
				on_attach = mix_attach,
			})

			-- local system_name
			-- if vim.fn.has("mac") == 1 then
			--      system_name = "macOS"
			-- elseif vim.fn.has("unix") == 1 then
			--      system_name = "Linux"
			-- elseif vim.fn.has("win32") == 1 then
			--      system_name = "Windows"
			-- else
			--      print("Unsupported system for sumneko")
			-- end
			-- -- local sumneko_root_path = "/home/huiwei/Workspace/service/lua-language-server"
			-- -- local sumneko_binary = sumneko_root_path .. "/bin/" .. system_name .. "/lua-language-server"
			-- -- local sumneko_binary = "/Users/huiwei/Workspace/service/lua-language-server/bin/lua-language-server"
			-- local runtime_path = vim.split(package.path, ";")
			-- table.insert(runtime_path, "lua/?.lua")
			-- table.insert(runtime_path, "lua/?/init.lua")
			-- lspconfig.sumneko_lua.setup({
			--      cmd = {
			--              sumneko_binary,
			--              "-E",
			--              sumneko_root_path .. "/main.lua",
			--      },
			--      settings = {
			--              Lua = {
			--                      runtime = {
			--                              -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
			--                              version = "LuaJIT",
			--                              -- Setup your lua path
			--                              path = runtime_path,
			--                      },
			--                      diagnostics = {
			--                              -- Get the language server to recognize the `vim` global
			--                              globals = { "vim" },
			--                      },
			--                      workspace = {
			--                              -- Make the server aware of Neovim runtime files
			--                              library = vim.api.nvim_get_runtime_file("", true),
			--                      },
			--                      -- Do not send telemetry data containing a randomized but unique identifier
			--                      telemetry = {
			--                              enable = false,
			--                      },
			--              },
			--      },
			-- })

			-- rust
			lspconfig.rls.setup({
				unstable_features = true,
				build_on_save = false,
				all_features = true,
			})
		end,
	})
	-- https://github.com/glepnir/lspsaga.nvim
	use({
		"glepnir/lspsaga.nvim",
		config = function()
			local saga = require("lspsaga")
			saga.init_lsp_saga({
				use_saga_diagnostic_sign = false,
				code_action_keys = {
					quit = "q",
					exec = "<CR>",
				},
				rename_action_keys = {
					quit = "<esc><esc>",
					exec = "<CR>", -- quit can be a table
				},
			})
			vim.api.nvim_set_keymap(
				"n",
				"<leader>rn",
				"<cmd>lua require('lspsaga.rename').rename()<CR>",
				{ noremap = true, silent = true }
			)
		end,
	})
	-- https://github.com/j-hui/fidget.nvim
	use({
		"j-hui/fidget.nvim",
		config = function()
			require("fidget").setup({
				text = {
					spinner = "meter",
				},
			})
		end,
	})

	-- 自动完成
	-- Copilot setup
	use({
		"github/copilot.vim",
	})

	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-nvim-lua")
	-- use "hrsh7th/cmp-omni"
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-cmdline")
	-- For luasnip user.
	use({
		"L3MON4D3/LuaSnip",
		requires = { "rafamadriz/friendly-snippets" },
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load()
		end,
	})
	use("saadparwaiz1/cmp_luasnip")
	use({
		"hrsh7th/nvim-cmp",
		config = function()
			local has_words_before = function()
				local line, col = unpack(vim.api.nvim_win_get_cursor(0))
				return col ~= 0
					and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
			end

			-- local luasnip = require("luasnip")
			local cmp = require("cmp")
			cmp.setup({
				window = {
					documentation = {
						border = "single",
					},
				},
				snippet = {
					expand = function(args)
						-- For `vsnip` user.
						-- vim.fn["vsnip#anonymous"](args.body)

						-- For `luasnip` user.
						require("luasnip").lsp_expand(args.body)

						-- For `ultisnips` user.
						-- vim.fn["UltiSnips#Anon"](args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					-- item go down and up
					["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
					["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
					["<Down>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
					["<Up>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
					-- doc scrool
					["<C-d>"] = cmp.mapping.scroll_docs(-4),
					["<C-u>"] = cmp.mapping.scroll_docs(4),
					-- confirm
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.close(),
					-- https://github.com/hrsh7th/nvim-cmp#what-is-the-pairs-wise-plugin-automatically-supported
					["<CR>"] = cmp.mapping.confirm({
						-- behavior = cmp.ConfirmBehavior.Replace,
						select = true,
					}),
					-- 	["<Tab>"] = cmp.mapping(function(fallback)
					-- 		if cmp.visible() then
					-- 			cmp.select_next_item()
					-- 		elseif luasnip.expand_or_jumpable() then
					-- 			luasnip.expand_or_jump()
					-- 		elseif has_words_before() then
					-- 			cmp.complete()
					-- 		else
					-- 			fallback()
					-- 		end
					-- 	end, {
					-- 		"i",
					-- 		"s",
					-- 	}),
					-- 	["<S-Tab>"] = cmp.mapping(function(fallback)
					-- 		if cmp.visible() then
					-- 			cmp.select_prev_item()
					-- 		elseif luasnip.jumpable(-1) then
					-- 			luasnip.jump(-1)
					-- 		else
					-- 			fallback()
					-- 		end
					-- 	end, {
					-- 		"i",
					-- 		"s",
					-- 	}),
				}),
				sources = {
					{ name = "nvim_lsp" },
					-- For vsnip user.
					-- { name = "vsnip" },
					-- For luasnip user.
					{ name = "luasnip" },
					-- For ultisnips user.
					-- { name = "ultisnips" },
					{ name = "crates" },
					{ name = "cmp_tabnine" },
					{ name = "nvim_lua" },
					-- { name = "omni" },
					{ name = "buffer" },
				},
				-- formatting = {
				-- 	format = require("lsp").cmp_format({
				-- 		with_text = true,
				-- 		menu = {
				-- 			buffer = "[Buffer]",
				-- 			nvim_lsp = "[LSP]",
				-- 			nvim_lua = "[Lua]",
				-- 			luasnip = "[LuaSnip]",
				-- 			ultisnips = "[Ultisnips]",
				-- 			crates = "[Crates]",
				-- 			cmp_tabnine = "[TabNine]",
				-- 			latex_symbols = "[Latex]",
				-- 		},
				-- 	}),
				-- },
			})
		end,
	})
	use({
		"tzachar/cmp-tabnine",
		run = "./install.sh",
		requires = "hrsh7th/nvim-cmp",
		-- https://github.com/tzachar/cmp-tabnine#setup
		config = function()
			local tabnine = require("cmp_tabnine.config")
			tabnine:setup({
				max_lines = 1000,
				max_num_results = 20,
				sort = true,
				run_on_every_keystroke = true,
				snippet_placeholder = "..",
			})
		end,
	})

	-- linter
	use({
		"mfussenegger/nvim-lint",
		config = function()
			require("lint").linters_by_ft = {
				-- markdown = { "vale" },
				-- paru shellcheck for archlinux
				sh = { "shellcheck" },
				-- https://golangci-lint.run
				-- https://golangci-lint.run/usage/install/#install-from-source
				-- go install github.com/golangci/golangci-lint/cmd/golangci-lint@v1.45.2
				go = { "golangcilint" },
			}
		end,
	})

	-- markdown
	-- https://github.com/preservim/vim-markdown
	--use({
	--	"plasticboy/vim-markdown",
	--	--config = function() end,
	--})
	-- https://github.com/dhruvasagar/vim-table-mode
	-- 表格自动格式化
	-- use({
	-- 	"dhruvasagar/vim-table-mode",
	-- 	config = function()
	-- 		vim.g.table_mode_corner = "|"
	-- 		vim.g.table_mode_corner_corner = "+"
	-- 		vim.g.table_mode_header_fillchar = "="
	-- 		vim.g.vim_markdown_folding_disabled = 1
	-- 		vim.g.vim_markdown_math = 1
	-- 		vim.g.vim_markdown_frontmatter = 1 -- for YAML format
	-- 		vim.g.vim_markdown_toml_frontmatter = 1 -- for TOML format
	-- 		vim.g.vim_markdown_json_frontmatter = 1 -- for JSON format
	-- 	end,
	-- })
	-- use({
	-- 	"iamcco/markdown-preview.nvim",
	-- 	run = function()
	-- 		vim.cmd("call mkdp#util#install()")
	-- 	end,
	-- 	config = function()
	-- 		vim.api.nvim_set_keymap("n", "<leader>md", "<Plug>MarkdownPreview", {})
	-- 		vim.api.nvim_set_keymap("n", "<leader>mt", "<Plug>MarkdownPreviewToggle", {})
	-- 		vim.api.nvim_set_keymap("n", "<M-s>", "<Plug>MarkdownPreviewStop", {})
	-- 	end,
	-- })

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if packer_bootstrap then
		require("packer").sync()
	end
end)
