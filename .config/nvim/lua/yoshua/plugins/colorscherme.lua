return {
    "EdenEast/nightfox.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        vim.cmd("colorscheme carbonfox")

		require('nightfox').setup({
			options = {
				transparent = true,
			}
		})
    end
}

