return {
	"echasnovski/mini.trailspace",
	version = false,
	enabled = false, -- Messes up my dashboard
	config = function()
		require("mini.trailspace").setup()
	end,
}
