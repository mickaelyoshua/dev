-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'

	-- Fuzzy finder
	use {
		'nvim-telescope/telescope.nvim', branch = '0.1.x',
		-- or                            ,
		requires = { {'nvim-lua/plenary.nvim'} }
	}

	-- Color scheme
	use({
		'EdenEast/nightfox.nvim',
		as = 'carbonfox',
		config = function()
			vim.cmd('colorscheme carbonfox')
		end
	})

end)
