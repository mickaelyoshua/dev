-- Colorscheme for Neovim
return {
    "EdenEast/nightfox.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        vim.cmd("colorscheme carbonfox")

		require('nightfox').setup({
			options = {
				transparent = false,
			}
		})
    end
}

-- return {
-- 	"catppuccin/nvim",
-- 	name = "catppuccin",
-- 	priority = 1000,
-- 	config = function ()
-- 		require("catppuccin").setup({
-- 			transparent_background = true,
-- 		})
-- 	end
-- }
