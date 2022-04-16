--
-- bootstrapping
--
-- https://github.com/wbthomason/packer.nvim
--
local packer_bootstrap = nil

local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
	print("packer_bootstrap...")
	packer_bootstrap = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("packer_bootstrap done")
end

vim.g.mapleader = [[ ]]

vim.cmd([[autocmd BufWritePost general.lua source <afile> | PackerCompile]])
vim.cmd([[autocmd BufWritePost plugins.lua source <afile> | PackerCompile]])

require("general")
require("plugins")
