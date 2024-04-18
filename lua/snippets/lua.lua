---------------------------------------
-- this is a generated luasnip file
-- the source data is from
-- compiler is
-- date of compilation: 04-17-2024
---------------------------------------

local ls = require("luasnip")
local s = ls.snippet

local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node

local l = require("luasnip.extras").lambda
local rep = require("luasnip.extras").rep
local p = require("luasnip.extras").partial
local m = require("luasnip.extras").match
local n = require("luasnip.extras").nonempty
local dl = require("luasnip.extras").dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local types = require("luasnip.util.types")
local conds = require("luasnip.extras.conditions")
local conds_expand = require("luasnip.extras.conditions.expand")
local parser = ls.parser.parse_snippet

local get_visual = function(args, parent)
	if #parent.snippet.env.LS_SELECT_RAW > 0 then
		return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
	else -- If LS_SELECT_RAW is empty, return a blank insert node
		return sn(nil, i(1))
	end
end

ls.add_snippets("lua", {
	-- parser("abc", "wwwWow! This ${1:Stuff} really ${2:works. ${3:Well, a bit.}}"),
	-- parser("abcd", "wwwWow! This $1 really $2 is the answer$0"),
	-- parser("aaabcd", "wwwWow! This $1 really $2 is the answer$0"),
	parser("function", "function $1($2)\n\t$3\nend"),
	parser("ifnot", "if not $1 then\n\t$1 = $0\nend"),
	parser("if", "if $1 then\n\t$0\nend"),
	parser("ef", "elseif $1 then\n\t$0\n"),
	parser("a", "local a = $0"),
	parser("b", "local b = $0"),
	parser("noremap", "noremap('$1', $2)"),
	parser("store", "local store = $0"),
	parser("lambda", "function ()\n\t$0\nend"),
	parser("for", "for key, _ in pairs($1) do\n\t\t$0\n\tend\nend\n"),
	parser("fori", "for index, val in ipairs($1) do\n\t\t$0\n\tend\nend\n"),

	s(
		{ trig = "tii", dscr = "Expands 'tii' into LaTeX's textit{} command." },
		fmta("\\textit{<>}", {
			d(1, get_visual),
		})
	),
	s(
		"booga",
		fmta(
			[[
        <> <> <>
    ]],
			{
				i(1, "testname"),
				i(2, "testname2"),
				i(0),
			}
		)
	),
})

function format(name, template, nodes)
	return s(name, fmta(template, nodes))
end
ls.add_snippets("all", {
	-- format("bm", "<>\n<>", {
	-- i(1, util.datestamp)
	-- }),
	s(
		{ trig = "b(%d+)", regTrig = true },
		f(function(args, snip)
			return "Captured Text: " .. snip.captures[1] .. "."
		end, {})
	),

	s(
		{ trig = "bb(%d+)", regTrig = true, desc = "howdy" },
		f(function(args, snip)
			return "Captured Text: " .. snip.captures[1] .. ".!! "
		end, {})
	),
})

-- local M = require("stdlib.utils")
ls.add_snippets("text", {
	parser("bm", "$comment $choice: $0"),
})
