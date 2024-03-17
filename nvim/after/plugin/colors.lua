-- Colorscheme options:
--
-- github_light_high_contrast
-- github_dark
-- old_cyberpunk
-- custom_cyberpunk
-- silverhand
-- alabaster
-- rose-pine



vim.cmd("set cursorline")

-- This function is supposed to assign default colors

function ColorMyPencils(color) 
	color = color  or "alabaster"  --set color here 
	vim.cmd.colorscheme(color)
    
    if not (color == "github_light_high_contrast") then
        vim.api.nvim_set_hl(0, "Normal", { bg = "none"})
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none"})
    end


end

ColorMyPencils()
