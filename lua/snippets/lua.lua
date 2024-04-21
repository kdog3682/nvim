---------------------------------------
-- this is a generated luasnip file
-- the source data is from
-- compiler is
-- date of compilation: 04-17-2024
---------------------------------------

local ls = require 'luasnip'
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node

local l = require('luasnip.extras').lambda
local rep = require('luasnip.extras').rep
local p = require('luasnip.extras').partial
local m = require('luasnip.extras').match
local n = require('luasnip.extras').nonempty
local dl = require('luasnip.extras').dynamic_lambda
local fmt = require('luasnip.extras.fmt').fmt
local fmta = require('luasnip.extras.fmt').fmta
local types = require 'luasnip.util.types'
local conds = require 'luasnip.extras.conditions'
local conds_expand = require 'luasnip.extras.conditions.expand'
local parser = ls.parser.parse_snippet

local function get_visual(args, parent)
    if #parent.snippet.env.LS_SELECT_RAW > 0 then
        return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
    else
        return sn(nil, i(1))
    end
end

function formatter(name, template, nodes)
    if not nodes then return parser(name, template) end
    return s({trig = name, wordTrig = false}, fmta(template, nodes))
end

local snippets = {
    formatter("nodes", "local nodes = {}"),
    formatter("node", "local node = <>", c(1, {
        t("get_root_node()"),
        t("ts_utils.get_node_at_cursor()"),
        t("get_cursor_node()"),
        t("get_cursor_node()"),
    })),
    formatter("s", "local s = "),
    formatter("cursor_pos", "local cursor_pos = vim.api.nvim_win_get_cursor(0)"),
    formatter("cursor_node", "local cursor_node = root:named_descendant_for_range(cursor_pos[1] - 1, cursor_pos[2])"),
    formatter("identifier_nodes", "local identifier_nodes = {}"),
    formatter("current_node", "local current_node = cursor_node"),
    formatter("a", "local a = "),
    formatter("file", "local file = io.open(path, \"r\")"),
    formatter("pattern", "local pattern = \"%b''\""),
    formatter("match", "local match = string.match(a, pattern)"),
    formatter("chars", "local chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'"),
    formatter("id", "local id = "),
    formatter("random", "local random = math.random"),
    formatter("ts_utils", "local ts_utils = require(\"nvim-treesitter.ts_utils\") "),
    formatter("vstart", "local vstart = vim.fn.getpos(\"'<\")"),
    formatter("vend", "local vend = vim.fn.getpos(\"'>\")"),
    formatter("line_start", "local line_start = vstart[2] "),
    formatter("line_end", "local line_end = vend[2]"),
    formatter("p", "local p = "),
    formatter("lines", "local lines = get_lines(a, b + 1)"),
    formatter("stack", "local stack = { root }"),
    formatter("start", "local start = get_far_left_node()"),
    formatter("indent_level", "local indent_level = vim.fn.indent(s)"),
    formatter("key", "local key = vim.fn.input(\"snippet key?\") or match()"),
    formatter("ls", "local ls = require(\"luasnip\")"),
    formatter("snippet", "local snippet = ls.parser.parse_snippet(key, expr)"),
    formatter("function", "function $1($2)\n\t$3\nend"),
    formatter("callback", "function callback($1)\n\t$2\nend"),
    formatter("runner", "function runner($1)\n\t$2\nend"),
}
ls.add_snippets("lua", snippets)

local logicSnippets = {
    formatter("if is_object", "if is_object(<>) then\n\t<>\nend", {i(1), i(2)}),
    formatter("ef is_object", "elseif is_object(<>) then\n\t<>\nend", {i(1), i(2)}),
    formatter("if is_array", "if is_array(<>) then\n\t<>\nend", {i(1), i(2)}),
    formatter("ef is_array", "elseif is_array(<>) then\n\t<>\nend", {i(1), i(2)}),
    formatter("if is_filetype", "if is_filetype(<>) then\n\t<>\nend", {i(1), i(2)}),
    formatter("ef is_filetype", "elseif is_filetype(<>) then\n\t<>\nend", {i(1), i(2)}),
    formatter("if is_file", "if is_file(<>) then\n\t<>\nend", {i(1), i(2)}),
    formatter("ef is_file", "elseif is_file(<>) then\n\t<>\nend", {i(1), i(2)}),
    formatter("if is_number", "if is_number(<>) then\n\t<>\nend", {i(1), i(2)}),
    formatter("ef is_number", "elseif is_number(<>) then\n\t<>\nend", {i(1), i(2)}),
    formatter("if is_string", "if is_string(<>) then\n\t<>\nend", {i(1), i(2)}),
    formatter("ef is_string", "elseif is_string(<>) then\n\t<>\nend", {i(1), i(2)}),
    formatter("if is_boolean", "if is_boolean(<>) then\n\t<>\nend", {i(1), i(2)}),
    formatter("ef is_boolean", "elseif is_boolean(<>) then\n\t<>\nend", {i(1), i(2)}),
    formatter("if is_table", "if is_table(<>) then\n\t<>\nend", {i(1), i(2)}),
    -- formatter("ifnot", "if not <> then\n\t<> = <>", {c(1, p(get_nearby_identifier)), rep(1)}),
}
ls.add_snippets("lua", logicSnippets)
