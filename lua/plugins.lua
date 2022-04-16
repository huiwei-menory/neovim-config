return require("packer").startup(function(use)
	-- Packer can manage itself
	use("wbthomason/packer.nvim")

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
			vim.cmd("colorscheme nightfox")
		end,
	})

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

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if packer_bootstrap then
		require("packer").sync()
	end
end)
