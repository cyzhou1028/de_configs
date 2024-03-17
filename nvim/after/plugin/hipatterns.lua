local words = { TODO =  '#ffff00', FIXME =  '#ff0000', NOTE =  '#00ff00', }
  local word_color_group = function(_, match)
    local hex = words[match]
    if hex == nil then return nil end
    return MiniHipatterns.compute_hex_color_group(hex, 'bg')
  end

  local hipatterns = require('mini.hipatterns')
  hipatterns.setup({
    highlighters = {
      word_color = { pattern = '%f[%w]()%S+()%f[%W]', group = word_color_group },
      hex_color = hipatterns.gen_highlighter.hex_color(),
    },
  })


-- FIXME
-- TODO
-- NOTE 

-- FIXME:
-- TODO:
-- NOTE:
