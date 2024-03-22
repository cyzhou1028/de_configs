local words = { TODO =  '#f0e851', FIXME =  '#f04d5a', NOTE =  '#7cff6e', }
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
