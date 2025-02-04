local ls = require("luasnip")
local postfix = require("luasnip.extras.postfix").postfix
local matches = require("luasnip.extras.postfix").matches
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

local get_visual = function(args, parent)
  if (#parent.snippet.env.LS_SELECT_RAW > 0) then
    return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
  else  -- If LS_SELECT_RAW is empty, return a blank insert node
    return sn(nil, i(1))
  end
end

local in_mathzone = function()
  -- The `in_mathzone` function requires the VimTeX plugin
  return vim.fn['vimtex#syntax#in_mathzone']() == 1
end

return {

        s({trig = '\\Im', snippetType="autosnippet" , regTrig = true, wordTrig = false},
            fmta( [[\text{Im } ]], {} ), {condition = in_mathzone}
        ),
        s({trig = '\\Re', snippetType="autosnippet" , regTrig = true, wordTrig = false},
            fmta( [[\text{Re } ]], {} ), {condition = in_mathzone}
        ),

        s({trig = '\\snzti', snippetType="autosnippet" , regTrig = true, wordTrig = false},
            fmta( [[\sum_{n=0}^\infty ]], {} ), {condition = in_mathzone}
        ),
        s({trig = '\\snoti', snippetType="autosnippet" , regTrig = true, wordTrig = false},
            fmta( [[\sum_{n=1}^\infty ]], {} ), {condition = in_mathzone}
        ),
        s({trig = '\\i02pi', snippetType="autosnippet" , regTrig = true, wordTrig = false},
            fmta( [[\int_{0}^{2\pi} ]], {} ), {condition = in_mathzone}
        ),
        s({trig = '\\Ocal', snippetType="autosnippet", regTrig = true, wordTrig = false},
            fmta( [[\mathcal{O} ]], {} ), {condition = in_mathzone}
        ),
        s({trig = '\\holo', snippetType="autosnippet" , regTrig = true, wordTrig = false},
             fmta( [[\mathcal{O}(<>) ]], {i(1, "<<<domain>>>")} ), {condition = in_mathzone}
        ),



}
