local ls = require("luasnip")
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
s({trig = '([^%a])ee', regTrig = true, wordTrig = false},
  fmta(
    "<>e^{<>}",
    {
      f( function(_, snip) return snip.captures[1] end ),
      d(1, get_visual)
    }
  )
),
s({trig = '\\divider', snippetType="autosnippet" , regTrig = true, wordTrig = false},
     fmta( [[\bigskip\hrule\bigskip ]], {} )
),
s({trig = '([^%a])ff', regTrig = true, wordTrig = false},
  fmta(
    [[<>\frac{<>}{<>}]],
    {
      f( function(_, snip) return snip.captures[1] end ),
      i(1, "<<<numerator>>>"),
      i(2, "<<<denominator>>>")
    }
  ),
  {condition = in_mathzone}
),
s({
    trig = '\\pr', regTrig = true, wordTrig = false,
    dscr="prime macro",
    snippetType="autosnippet"
  },
  fmta(
    [[\prime ]],
    {
    }
  ),
  {condition = in_mathzone}
),
s({
    trig = '\\lra',regTrig = true, wordTrig = false, 
    dscr="leftrightarrow macro",
    snippetType="autosnippet"
  },
  fmta(
    [[\leftrightarrow ]],
    {
    }
  ),
  {condition = in_mathzone}
),
s({trig = "tii", dscr = "Expands 'tii' into LaTeX's textit{} command."},
  fmta("\\textit{<>}",
    {
      d(1, get_visual),
    }
  )
),

s({
    trig="([^%a])env", regTrig = true, wordTrig = false,
    dscr="A generic new environment",
    snippetType="autosnippet"
  },
  fmta(
    [[
      \begin{<>}
          <>
      \end{<>}
    ]],
    {
      i(1, "<<<name>>>"),
      i(2, "<<<contents>>>"),
      rep(1),
    }
  )
),
s({
    trig="\\definition", regTrig = true, wordTrig = false,
    dscr="A definition",
    snippetType="autosnippet"
  },
  fmta(
    [[
        \quad\\
      \begin{definition}
          <>
      \end{definition}
        \quad\\
    ]],
    {
      i(1, "<<<contents>>>"),
    }
  )
),
s({
    trig="\\proposition", regTrig = true, wordTrig = false,
    dscr="A proposition",
    snippetType="autosnippet"
  },
  fmta(
    [[
        \quad\\
      \begin{proposition}
          <>
      \end{proposition}
        \quad\\
    ]],
    {
      i(1, "<<<contents>>>"),
    }
  )
),
s({
    trig="\\theorem", regTrig = true, wordTrig = false,
    dscr="A theorem",
    snippetType="autosnippet"
  },
  fmta(
    [[
        \quad\\
      \begin{theorem}
          <>
      \end{theorem}
        \quad\\
    ]],
    {
      i(1, "<<<contents>>>"),
    }
  )
),
s({
    trig="\\lemma", regTrig = true, wordTrig = false,
    dscr="A lemma",
    snippetType="autosnippet"
  },
  fmta(
    [[
        \quad\\
      \begin{lemma}
          <>
      \end{lemma}
        \quad\\
    ]],
    {
      i(1, "<<<contents>>>"),
    }
  )
),
s({
    trig="\\corollary", regTrig = true, wordTrig = false,
    dscr="A corollary",
    snippetType="autosnippet"
  },
  fmta(
    [[
        \quad\\
      \begin{corollary}
          <>
      \end{corollary}
        \quad\\
    ]],
    {
      i(1, "<<<contents>>>"),
    }
  )
),
s({
    trig="\\remark", regTrig = true, wordTrig = false,
    dscr="A remark",
    snippetType="autosnippet"
  },
  fmta(
    [[
        \quad\\
      \begin{remark}
          <>
      \end{remark}
        \quad\\
    ]],
    {
      i(1, "<<<contents>>>"),
    }
  )
),
s({
    trig="\\proof", regTrig = true, wordTrig = false,
    dscr="A proof",
    snippetType="autosnippet"
  },
  fmta(
    [[
      \begin{proof}
          <>
      \end{proof}
    ]],
    {
      i(1, "<<<contents>>>"),
    }
  )
),
s({
    trig="\\proofsketch", regTrig = true, wordTrig = false,
    dscr="A proofsketch",
    snippetType="autosnippet"
  },
  fmta(
    [[
      \begin{proofsketch}
          <>
      \end{proofsketch}
    ]],
    {
      i(1, "<<<contents>>>"),
    }
  )
),

s({
    trig="\\note", regTrig = true, wordTrig = false,
    dscr="A note",
    snippetType="autosnippet"
  },
  fmta(
    [[
        \quad\\
      \begin{note}
          <>
      \end{note}
        \quad\\
    ]],
    {
      i(1, "<<<contents>>>"),
    }
  )
),

s({
    trig="\\example", regTrig = true, wordTrig = false,
    dscr="A note",
    snippetType="autosnippet"
  },
  fmta(
    [[
        \quad\\
      \begin{note}
          <>
      \end{note}
        \quad\\
    ]],
    {
      i(1, "<<<contents>>>"),
    }
  )
),
}

