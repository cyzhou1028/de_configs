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
    -- Blackboard Bold
        
        -- FIXME: Make it so that it only triggers if no letter follows, and do not "consume" the character that follows e.g. \R^ should become \mathbb{R}^ but \Ri should stay \Ri

        s({trig = '\\R', snippetType="autosnippet", regTrig = true, wordTrig = false},
     fmta( [[\mathbb{R} ]], {} ), {condition = in_mathzone}
        ),
        s({trig = '\\C', snippetType="autosnippet" , regTrig = true, wordTrig = false},
     fmta( [[\mathbb{C} ]], {} ), {condition = in_mathzone}
        ),
        s({trig = '\\N', snippetType="autosnippet" , regTrig = true, wordTrig = false},
     fmta( [[\mathbb{N} ]], {} ), {condition = in_mathzone}
        ),
        s({trig = '\\Q', snippetType="autosnippet" , regTrig = true, wordTrig = false},
     fmta( [[\mathbb{Q} ]], {} ), {condition = in_mathzone}
        ),
        s({trig = '\\P', snippetType="autosnippet" , regTrig = true, wordTrig = false},
     fmta( [[\mathbb{P} ]], {} ), {condition = in_mathzone}
        ),
        s({trig = '\\E', snippetType="autosnippet" , regTrig = true, wordTrig = false}, -- NOTE: maybe get rid of over?
     fmta( [[\mathbb{E}_{<>} [<>] ]], {i(1, "<<<over>>>"), i(2, "<<<arg>>>")} ), {condition = in_mathzone}
        ),
        s({trig = '\\Hu', snippetType="autosnippet" , regTrig = true, wordTrig = false},
     fmta( [[\mathbb{H} ]], {} ), {condition = in_mathzone}
        ),
        s({trig = '\\Z', snippetType="autosnippet" , regTrig = true, wordTrig = false},
     fmta( [[\mathbb{Z} ]], {} ), {condition = in_mathzone}
        ),
        s({trig = '\\F', snippetType="autosnippet" , regTrig = true, wordTrig = false},
     fmta( [[\mathbb{F} ]], {} ), {condition = in_mathzone}
        ),

    -- greek, indicator, inverse

        s({trig = '\\eps', snippetType="autosnippet" , regTrig = true, wordTrig = false},
            fmta( [[\epsilon ]], {} ), {condition = in_mathzone}
        ),
        s({trig = '\\lam', snippetType="autosnippet" , regTrig = true, wordTrig = false},
            fmta( [[\lambda ]], {} ), {condition = in_mathzone}
        ),
        s({trig = '\\alf', snippetType="autosnippet" , regTrig = true, wordTrig = false},
            fmta( [[\alpha ]], {} ), {condition = in_mathzone}
        ),
        s({trig = '\\i ', snippetType="autosnippet" , regTrig = true, wordTrig = false},
            fmta( [[^{-1} ]], {} ), {condition = in_mathzone}
        ),
        s({trig = '\\ind', snippetType="autosnippet" , regTrig = true, wordTrig = false},
            fmta( [[\mathbbm{1} ]], {} ), {condition = in_mathzone}
        ),

    -- text expansion and literalization
        s({trig = ' st ', snippetType="autosnippet" , regTrig = true, wordTrig = false},
            t(" such that ")
        ),
        s({trig = 'tfae ', snippetType="autosnippet" , regTrig = true, wordTrig = false},
            fmta( [[the following are equivalent ]], {} )
        ),
        s({trig = 'Tfae ', snippetType="autosnippet" , regTrig = true, wordTrig = false},
            fmta( [[The following are equivalent ]], {} )
        ),
        s({trig = 'bwoc ', snippetType="autosnippet" , regTrig = true, wordTrig = false},
            fmta( [[by way of contradiction ]], {} )
        ),
        s({trig = 'Bwoc ', snippetType="autosnippet" , regTrig = true, wordTrig = false},
            fmta( [[By way of contradiction ]], {} )
        ),




        s({trig = '\\rank', snippetType="autosnippet" , regTrig = true, wordTrig = false},
            fmta( [[\textbf{rank} ]], {} ), {condition = in_mathzone}
        ),
        s({trig = '\\im', snippetType="autosnippet" , regTrig = true, wordTrig = false},
            fmta( [[\textbf{im} ]], {} ), {condition = in_mathzone}
        ),
        s({trig = '\\ker', snippetType="autosnippet" , regTrig = true, wordTrig = false},
            fmta( [[\textbf{ker} ]], {} ), {condition = in_mathzone}
        ),
        s({trig = '\\dim', snippetType="autosnippet" , regTrig = true, wordTrig = false},
            fmta( [[\textbf{dim} ]], {} ), {condition = in_mathzone}
        ),
        s({trig = '\\det', snippetType="autosnippet" , regTrig = true, wordTrig = false},
            fmta( [[\textbf{det} ]], {} ), {condition = in_mathzone}
        ),
        s({trig = '\\tr', snippetType="autosnippet" , regTrig = true, wordTrig = false},
            fmta( [[\textbf{tr} ]], {} ), {condition = in_mathzone}
        ),

    -- set notation
        
        s({trig = '\\set', snippetType="autosnippet" , regTrig = true, wordTrig = false},
            fmta( [[\{<>\} ]], {
              i(1, "<<<contents>>>")
            } ), 
            {condition = in_mathzone}
        ),
        s({trig = '\\contains', snippetType="autosnippet" , regTrig = true, wordTrig = false},
            fmta( [[\supset ]], {} ), {condition = in_mathzone}
        ),
        s({trig = '\\containseq', snippetType="autosnippet" , regTrig = true, wordTrig = false},
            fmta( [[\supseteq ]], {} ), {condition = in_mathzone}
        ),
        s({trig = '\\iscontainedin', snippetType="autosnippet" , regTrig = true, wordTrig = false},
            fmta( [[\subset ]], {} ), {condition = in_mathzone}
        ),
        s({trig = '\\iscontainedineq', snippetType="autosnippet" , regTrig = true, wordTrig = false},
            fmta( [[\subseteq ]], {} ), {condition = in_mathzone}
        ),

    -- postfix modifiers
        s({trig = 'star', snippetType="autosnippet" , regTrig = true, wordTrig = false},
            fmta( [[^{\ast}]], {} ), {condition = in_mathzone}
        ),
        postfix(".br",  {
            f(function(_, parent)
                return "[" .. parent.snippet.env.POSTFIX_MATCH .. "]"
            end, {condition = in_mathzone}),
        }),
        postfix({trig = "hat", snippetType="autosnippet"}, {
            f(function(_, parent)
                return "\\hat{" .. parent.snippet.env.POSTFIX_MATCH .. "}"
            end, {condition = in_mathzone}),
        }),
        postfix({trig = "bar", snippetType="autosnippet"}, {
            f(function(_, parent)
                return "\\overline{" .. parent.snippet.env.POSTFIX_MATCH .. "}"
            end, {condition = in_mathzone}),
        }),
}
