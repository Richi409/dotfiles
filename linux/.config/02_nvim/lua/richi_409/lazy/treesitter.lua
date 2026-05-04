return {
    "nvim-treesitter/nvim-treesitter",

    build = ":TSUpdate",

    lazy = false,

    config = function()
        require('nvim-treesitter').install {
            "bash",
			"java",
			"javascript",
			"typescript",
			"c",
			"lua",
			"vim",
			"vimdoc",
			"query",
			"html",
			"css",
            "markdown",
            "markdown_inline",
            "latex"
        }
    end

}
