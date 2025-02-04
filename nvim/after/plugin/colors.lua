-- Colorscheme options:
--
-- github_light_high_contrast
-- github_dark
-- custom_cyberpunk
-- silverhand
-- alabaster
-- rose-pine
-- lackluster
-- lackluster-hack
-- lackluster-mint
--
-- NOTE: for lackluster fonts, must first set to rose-pine then lackluster 
-- to get the correct colors for some weird reason



vim.cmd("set cursorline")

-- This function is supposed to assign default colors

function ColorMyPencils(color) 
	color = color  or "lackluster-hack"  --set color here 
	vim.cmd.colorscheme(color)
    vim.opt.background = "dark"   -- set light or dark mode here (if supported)
    
    if not ((color == "github_light_high_contrast") or (color == "alabaster")) then
        vim.api.nvim_set_hl(0, "Normal", { bg = "none"})
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none"})
    end


end

ColorMyPencils()
