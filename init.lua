vim.g.mapleader = ","

function to_array(x)
	if is_array(x) then
		return x
	else
		return { x }
	end
end
function noremap(key, expr, opts)
	if not opts then
		opts = {}
	end
	if opts.save then
		expr = vim.fn.printf(":w<cr><cmd>lua %s()<cr>", expr)
	elseif opts.args then
		local argstr = join(map(to_array(opts.args), to_string_argument), ", ")
		expr = vim.fn.printf("<cmd>lua %s(%s)<cr>", expr, argstr)
    elseif opts.lua then
		expr = vim.fn.printf("<cmd>lua %s()<cr>", expr)
    end
	vim.keymap.set("n", key, expr, { noremap = true, silent = true })
end

vim.keymap.set("n", "x", '"_x')
noremap("ls", ":ls<cr>")

vim.opt.guicursor = "n:block"
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.wrap = false
vim.opt.number = true
vim.opt.relativenumber = false

vim.opt.hlsearch = false
vim.opt.incsearch = false

vim.opt.laststatus = 2
vim.opt.showcmd = false
vim.opt.ruler = false
vim.opt.signcolumn = "no"
noremap("s", ":update<CR>")
-- vim.cmd("autocmd! BufWritePost $MYVIMRC source $MYVIMRC")
local group = vim.api.nvim_create_augroup("kdog3682", { clear = true })

function tail(file)
	-- https://github.com/hrsh7th/cmp-calc
	local bufname = file or vim.api.nvim_buf_get_name(0)
	return vim.fn.fnamemodify(bufname, ":p")
end
function head(file)
	local bufname = file or vim.api.nvim_buf_get_name(0)
	return vim.fn.fnamemodify(bufname, ":h")
end
function lua_bufwrite_callback()
	local bufname = vim.api.nvim_buf_get_name(0)
	print("howdy", bufname)
	pause(bufname)
	local dir = tail(head())
	if dir == "snippets" then
		print(bufname)
	end
	execute("source", bufname)
end

vim.cmd("autocmd! BufWritePost $MYVIMRC source $MYVIMRC")
vim.cmd("autocmd! BufWritePost /home/kdog3682/.config/nvim/lua/snippets/lua.lua source $MYVIMRC")
vim.cmd("autocmd! BufWritePost /home/kdog3682/.config/nvim/test.lua source ~/.config/nvim/test.lua")
vim.api.nvim_create_autocmd("BufWritePost", { group = group, callback = lua_bufwrite_callback, pattern = { "lua" } })
-- vim.api.nvim_create_autocmd("FileType", group = group, callback = filetype_callback)

-----------------------------
-----------------------------
-----------------------------

-- vim.o.termguicolors = true

vim.g.loaded_python3_provider = 0
vim.cmd("syntax on")
-- vim.cmd('highlight Cursor guifg=gray')
vim.cmd("highlight MatchParen guifg=black")

local very_light_gray = "#F0F0F0"
local normal_fg = "NONE"
local gray = "#808080"

-- vim.api.nvim_set_hl(0, "Comment", { fg = "#c0c0c0", bg = none })
-- vim.api.nvim_set_hl(0, "String", { fg = none, bg = none })
-- vim.api.nvim_set_hl(0, "Statement", { fg = none, bg = none })
-- vim.api.nvim_set_hl(0, "Special", { fg = none, bg = none })
-- vim.api.nvim_set_hl(0, "Type", { fg = none, bg = none })
-- vim.api.nvim_set_hl(0, "Title", { fg = none, bg = none })
-- vim.api.nvim_set_hl(0, "FloatTile", { fg = none, bg = none })
-- vim.api.nvim_set_hl(0, "NonText", { fg = none, bg = none })
-- vim.api.nvim_set_hl(0, "Constant", { fg = none, bg = none })
-- vim.api.nvim_set_hl(0, "Character", { fg = none, bg = none })
-- vim.api.nvim_set_hl(0, "Function", { fg = none, bg = none })
-- vim.api.nvim_set_hl(0, "Identifier", { fg = none, bg = none })
-- vim.api.nvim_set_hl(0, "String", { fg = none, bg = none })
-- vim.api.nvim_set_hl(0, "Number", { fg = none, bg = none })
-- vim.api.nvim_set_hl(0, "ErrorMsg", { fg = gray, bg = very_light_gray })
-- vim.api.nvim_set_hl(0, "MatchParens", { fg = gray, bg = gray })
-- vim.api.nvim_set_hl(0, "DiagnosticError", { fg = gray, bg = very_light_gray })
-- vim.api.nvim_set_hl(0, "DiagnosticWarn", { fg = gray, bg = very_light_gray })
-- vim.api.nvim_set_hl(0, "DiagnosticInfo", { fg = gray, bg = very_light_gray })
-- vim.api.nvim_set_hl(0, "DiagnosticHint", { fg = gray, bg = very_light_gray })
-- vim.api.nvim_set_hl(0, "LspDiagnosticsError", { fg = gray, bg = "NONE" })
-- vim.api.nvim_set_hl(0, "LspDiagnosticsWarning", { fg = gray, bg = "NONE" })
-- vim.api.nvim_set_hl(0, "LspDiagnosticsInformation", { fg = gray, bg = "NONE" })
-- vim.api.nvim_set_hl(0, "LspDiagnosticsHint", { fg = gray, bg = "NONE" })
-- vim.api.nvim_set_hl(0, "Pmenu", { fg = normal_fg, bg = very_light_gray })
-- vim.api.nvim_set_hl(0, "PmenuSel", { fg = normal_fg, bg = very_light_gray, reverse = true })

local blue = "#00BFFF" -- You can adjust this hex code to your desired shade of blue

-- Change the color of icons, bullets, and labels
-- vim.api.nvim_set_hl(0, "IconBullet", { fg = black })
-- vim.api.nvim_set_hl(0, "LabelIconBullet", { fg = black })

-- Function to scan the line above the current line for variable names and print them
local function print_variables_above_line()
	-- Get the line number of the line above the current line
	local line_above = vim.fn.line(".") - 1
	-- Ensure we don't go beyond the first line
	if line_above < 1 then
		print("No lines above the current line.")
		return
	end
	-- Get the content of the line above the current line
	local line_content = vim.fn.getline(line_above)
	-- Define a regular expression pattern to match variable names
	local pattern = "([a-zA-Z]\\w+)(?: in|[}\\]),])"
	-- Initialize a table to store variable names found in the line
	local variables = {}
	-- Iterate through each match of the pattern in the line
	for variable in line_content:gmatch(pattern) do
		-- Insert the variable name into the table if it's not already present
		if not variables[variable] then
			variables[variable] = true
		end
	end
	-- Construct the print statement with the variable names
	local print_statement = "print("
	local first = true
	for variable, _ in pairs(variables) do
		if not first then
			print_statement = print_statement .. ", "
		else
			first = false
		end
		print_statement = print_statement .. variable
	end
	print_statement = print_statement .. ")"
	-- Get the current indent level
	local indent = vim.fn.matchstr(line_content, "^%s*")
	-- Append the print statement with proper indentation to the current line
	vim.fn.append(".", indent .. print_statement)
end

local function capture_and_append_filtered(cmd, filter_pattern)
	-- Capture the output of the provided Neovim command
	local stream = io.capture()
	vim.api.nvim_command(cmd)
	local output = stream:get()
	io.close(stream)

	-- Filter lines based on a case-insensitive regex pattern
	local filtered_lines = {}
	local pattern = string.format("(?i)%s", filter_pattern) -- Compile case-insensitive regex
	for _, line in ipairs(output:gmatch(".+")) do
		if string.find(line, pattern) then
			table.insert(filtered_lines, line)
		end
	end

	-- Append filtered output to the bottom of the file
	vim.api.nvim_buf_write("\n" .. table.concat(filtered_lines, "\n"), 0)
end

-- Execute the command and filter/append the output (regex)
-- capture_and_append_filtered(":hi", "blue|magenta")  -- OR operator for multiple words

-- Define a class-like table
local MyClass = {
	_data = {
		name = "John",
		age = 30,
	},
}

-- Metatable for MyClass
local MyClass_mt = {
	__index = function(tbl, key)
		if key == "name" then
			return tbl._data.name
		elseif key == "age" then
			return tbl._data.age
		else
			return rawget(tbl, key)
		end
	end,
}

-- Set metatable for MyClass
setmetatable(MyClass, MyClass_mt)

-- Function to access properties with dot notation
local function get(tbl, key)
	return tbl[key]
end

-- Example usage

-- Define a Person class in Lua
local Person = {}

-- Constructor
function Person:new(name, age)
	local obj = { _name = name, _age = age }
	setmetatable(obj, self)
	self.__index = self
	return obj
end

-- Getter for name
function Person:getName()
	return self._name
end

-- Setter for name
function Person:setName(name)
	self._name = name
end

-- Getter for age
function Person:getAge()
	return self._age
end

-- Setter for age
function Person:setAge(age)
	self._age = age
end

-- Method to introduce the person
function Person:introduce()
	print("Hi, my name is " .. self._name .. " and I am " .. self._age .. " years old.")
end

-- Create an instance of the Person class
-- local person = Person:new("John", 30)

-- Access properties and call methods
-- print(person:getName()) -- Output: John
-- print(person:getAge()) -- Output: 30
-- person:introduce() -- Output: Hi, my name is John and I am 30 years old.

vim.api.nvim_set_keymap("n", "[", ":normal! 10k<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "]", ":normal! 10j<CR>", { noremap = true, silent = true })

local function fzf_normal_commands()
	local mappings = map(vim.api.nvim_get_keymap("n"), callback)
	require("fzf-lua").fzf_exec(input, { actions = { default = default } })
end

function is_object(x)
	if not is_table(x) then
		return false
	end
	if x[1] == nil then
		return true
	else
		return false
	end
end

function is_array(x)
	if not is_table(x) then
		return false
	end
	if x[1] == nil then
		return false
	else
		return true
	end
end
local function print_table_contents(tbl)
	if is_array(tbl) then
		for key, value in pairs(tbl) do
			print(key, "...", value)
		end
	elseif is_object(tbl) then
		for key, value in pairs(tbl) do
			print(key, ": ", value)
		end
	else
		print(tbl)
	end
end

-- Function to reload Neovim configuration
local function reload_neovim()
	-- Reload the init.vim or init.lua file
	vim.cmd("luafile $MYVIMRC")
end
vim.api.nvim_set_keymap("n", "<Leader>rr", ":lua reload_neovim()<CR>", { noremap = true, silent = true })

function select_item(items)
	local selected_index = vim.ui.select(items)
	print(selected_index)
end

function foo()
	vim.ui.select({ "tabs", "spaces" }, {
		prompt = "Select tabs or spaces:",
	}, function(choice)
		print(choice)
	end)
end
-- vim.g.your_cmp_disable_enable_toggle = 1

local api = vim.api

function getline()
	return vim.fn.getline(vim.fn.line("."))
end
local function add_keymap_and_append()
	vim.ui.input({ prompt = "Enter key expr you would liek to use: " }, function(input)
		_add_keymap_and_append(input, getline())
	end)
end
-- Function to add a new keymap if it doesn't exist and append the command to the current file
local function _add_keymap_and_append(key, mapping)
	-- Check if the keymap already exists
	local current_mapping = api.nvim_get_keymap("n", key)

	if not current_mapping then
		-- Keymap doesn't exist, so add it
		api.nvim_set_keymap("n", key, mapping, { noremap = true, silent = true })
		print("Keymap added:", key)
	else
		print("Keymap already exists:", key)
	end

	local mapping = "vim.api.nvim_set_keymap('n', key, mapping, { noremap = true, silent = true })"
	mapping = string.format(mapping, key, mapping)
	-- Append the command associated with the keymap to the current file
	api.nvim_buf_set_lines(0, -1, -1, true, { mapping })
	print("Command appended to file:", mapping)
end

function reload_vim()
	vim.cmd("source ~/.config/nvim/init.lua")
	print("Reload")
end

require("config")

vim.g.ts_file = "~/my-vitesse-app/src/main.ts"
vim.g.vue_file = "~/my-vitesse-app/src/main.ts"
vim.g.clip_file = "~/2023/clip.js"
vim.g.files = {
	"~/temp.txt",
	"~/2023/examples.template.js",
}
vim.g.directories = {
	"~/",
	"~/my-vitesse-app/src",
	"~/my-vitesse-app/src/components",
	"~/.config/nvim/lua",
	"~/.config/nvim/lua/plugins",
	"~/.config/nvim/ftplugin",
	"~/.config/nvim/lua/config",
	"~/.config/nvim/lua/snippets",
	"~/GITHUB",
	"~/PYTHON",
    "/home/kdog3682/.local/share/nvim/lazy",
    "/home/kdog3682/javascript"
}
vim.g.state = {
	debug = { 0, 1 },
	fzf = {
		vim.g.files,
		vim.g.directories,
	},
	files = vim.g.files,
}

function ToggleComment()
	local line = vim.api.nvim_get_current_line()
	local comment_string = vim.api.nvim_buf_get_option(0, "commentstring")
	vim.ui.input("cs", comment_string)

	-- Check if the line is already commented
	if string.find(line, "^%s*" .. comment_string) then
		-- Remove comment
		local uncommented_line = string.gsub(line, "^%s*" .. comment_string, "")
		vim.api.nvim_set_current_line(uncommented_line)
	else
		-- Add comment
		local commented_line = comment_string .. line
		vim.api.nvim_set_current_line(commented_line)
	end
end

vim.o.numberwidth = 2 -- Adjust to your preference

-- Function to write the current TreeSitter tree to a JSON file
function ExportTreeAsJSON2()
	local root = get_root_node()
	-- append_file(vim.g.temp_file, root)

	local function convertNode(node)
		local t = {
			type = node:type(),
			range = { node:range() },
		}

		local childNodes = {}
		for childNode in node:iter_children() do
			table.insert(childNodes, convertNode(childNode))
		end

		if #childNodes > 0 then
			t.children = childNodes
		end

		return t
	end
	append_file(vim.g.temp_file, convertNode(root))
end

vim.keymap.set("n", "\\", function()
	local line = vim.fn.getline(".")
	local col = vim.fn.col(".")

	local bufnr = vim.api.nvim_get_current_buf()

	local success, err = pcall(function()
		local new_lines = { "New line 1", "New line 2", "New line 3" }
		-- vim.api.nvim_buf_set_lines(bufnr, 0, 0, true, new_lines)
	end)

	-- Check if an error occurred
	if not success then
		-- Print the error
		print("Error:", err)
		return
	end

	local new_text = string.format("--- %s[%s]", line, col)
	print(new_text)
	-- return new_text
	return
end, { expr = false })

function ls_root_files()
	local output = vim.fn.system("ls", "/")
	print(output)
end

local ls = require("luasnip")

vim.keymap.set({ "i", "s" }, "<c-l>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end)
-- fmt4

function toggler()
	vim.cmd("Lazy reload " .. vim.g.plugin)
end

function get_filetype(file)
	if not file then
		return vim.bo.filetype
	else
		local fileTypes = {
			txt = "text",
			pdf = "pdf",
			typ = "typst",
			lua = "lua",
			js = "javascript",
			css = "css",
			py = "python",
			vim = "vim",
			-- Add more extensions and types as needed
		}
		local extension = string.match(file, "%.(%a+)$")
		return fileTypes[extension]
	end
end
function join(a, delimiter)
	return table.concat(a, delimiter or " ")
end
function command(...)
	local s = join({ ... })
	print("command", s)
	vim.cmd(s)
end
function reloader()
	command("Lazy reload " .. vim.g.plugin)
end
vim.keymap.set("n", "<c-p>", ":FzfLua oldfiles resume = true<CR>", { silent = true })
function get_line()
	local row, col = unpack(vim.api.nvim_win_get_cursor(0))
	row = row - 1
	local line = vim.api.nvim_buf_get_lines(0, row, row + 1, false)[1]
	return line
end
function omni_toggle()
	local w = vim.fn.expand("<cword>")
	print(w)
	replace_word_under_cursor()
end
function replace_word_under_cursor()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	local s = vim.api.nvim_get_current_line()
	local a = s
	local new_line_text = line_text:sub(1, col - #word_start) .. "foobar" .. line_text:sub(col + #word_end + 1)
	vim.api.nvim_set_current_line(new_line_text)
end
noremap("<space>", omni_toggle)
function pause(arg)
	vim.fn.input(stringify(arg))
end
function motion_qw()
	-- local row, col = unpack(vim.api.nvim_win_get_cursor(0))
	local a = vim.fn.getline(".")
	local col = vim.fn.col(".")
	local s1 = a[col]

	if true then
		return "123555"
	end
	if s1 == "," then
		return "<RIGHT>"
	else
		return "<RIGHT>, "
	end
end
function help()
	local w = vim.fn.expand("<cword>")
	print(w)
	-- vim.fn
end
function see(access)
	temp(keys(access), "a")
end
noremap("k", ":m-2<CR>")
noremap("j", ":m+1<CR>")
local function split(inputstr, sep)
	sep = sep or "%s" -- Default separator is whitespace
	local t = {} -- Table to store the substrings
	for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
		table.insert(t, str) -- Insert each substring into the table
	end
	return t -- Return the table of substrings
end

function anything_handler(s)
	local handlers = {
		gft = get_filetype,
		help = help,
        e = "e!",
	}

	local key = ""
	local parts = split(s, " ")

	if #parts == 0 then
		if vim.g.state.anything_handler_key == nil then
			print("no vim.g.state.anything_handler_key ... early return")
			return
		else
			key = vim.g.state.anything_handler_key
		end
	else
		key = table.remove(parts, 1)
		vim.g.state.anything_handler_key = key
	end
	if is_number(key) then
		return vim.api.nvim_win_set_cursor(0, { tonumber(key - 1), 100 })
	end
	local func = handlers[key]

	if func then
        if is_string(func) then
            vim.cmd(func)
        else
            local success, result = pcall(func, unpack(parts))
            if success then
                print(result)
            end
        end
	else
		run_lua_function(key)
	end
end

vim.keymap.set("n", ";", ":lua anything_handler('')<LEFT><LEFT>") -- interesting

local M = require("stdlib.meta")

vim.keymap.set("n", "<leader>r", "diwi", { silent = true, noremap = true })
vim.keymap.set("n", "wa", ":wa<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>m", "<cmd> lua M.view_mappings()<CR>", { silent = false, noremap = true })

-- vim.o.statusline = "%f             %=%{mode()== 'n' && '' or '-- INSERT --'}           "
-- Define a Lua function to generate the status line

local modes = {
	["n"] = "NORMAL",
	["no"] = "NORMAL",
	["v"] = "VISUAL",
	["V"] = "VISUAL LINE",
	[""] = "VISUAL BLOCK",
	["s"] = "SELECT",
	["S"] = "SELECT LINE",
	[""] = "SELECT BLOCK",
	["i"] = "INSERT",
	["ic"] = "INSERT",
	["R"] = "REPLACE",
	["Rv"] = "VISUAL REPLACE",
	["c"] = "COMMAND",
	["cv"] = "VIM EX",
	["ce"] = "EX",
	["r"] = "PROMPT",
	["rm"] = "MOAR",
	["r?"] = "CONFIRM",
	["!"] = "SHELL",
	["t"] = "TERMINAL",
}
local function filepath()
	local fpath = vim.fn.fnamemodify(vim.fn.expand("%"), ":~")
	if fpath == "" or fpath == "." then
		return " "
	end
	return string.format(" %%<%s", fpath)
	-- Refer to :h filename-modifiers for more.
end
function statusline()
	-- Get current file name
	local filename = vim.fn.expand("%:t")
	local filetype = vim.bo.filetype
	local line = vim.fn.line(".")
	local current_mode = vim.api.nvim_get_mode().mode

	-- Get total number of lines in the buffer
	local total_lines = vim.fn.line("$")
	return string.format("File: %s | Type: %s | Line: %d/%d", filename, filetype, line, total_lines)
end
function statusline()
	local current_mode = vim.api.nvim_get_mode().mode
	return filepath() .. "     " .. (current_mode == "i" and "-- INSERT --" or "")
end

-- Set the statusline option to use the Lua function
vim.o.statusline = "%!v:lua.statusline()"
vim.o.laststatus = 2

function open(file_path)
	vim.api.nvim_command("edit! " .. file_path)
end
function open_buffer(file_path)
	local file_path = file_path or "~/abc.typ"
	open(file_path)
end

function open_prev_buffer()
	local file_path = "#"
	open(file_path)
end

vim.keymap.set("i", "_", "-")
vim.keymap.set("i", "-", "_")

local function empty(value)
	-- Check for nil values
	if value == "xxxxxs" then
		return true
	elseif value == "" then
		return true
	elseif value == nil then
		return true
	elseif type(value) == "table" then
		return next(value) == nil
	elseif type(value) == "string" then
		if len(value) == 0 then
			return false
		end
		return value == ""
	else
		return false
	end
end

function trim(s)
	return s:gsub("^%s*(.-)%s*$", "%1")
end

local function everything_before_cursor_is_spaces()
	local current_line = vim.api.nvim_get_current_line()
	local cursor_col = vim.api.nvim_win_get_cursor(0)[2]
	local slice = string.sub(current_line, 1, cursor_col)
	return empty(trim(slice))
end

function is_filetype(s)
	return s == get_filetype()
end
function smart_dash()
	if is_filetype("lua") and everything_before_cursor_is_spaces() then
		return "-- "
	else
		return "_"
	end
end

function fzf(input)
	if not is_array(input) then
		input = vim.g.state.fzf[2]
	end
	local function default(selected)
		local a = vim.fn.expand(selected[1])
		nvim_tree(a)
	end
	require("fzf-lua").fzf_exec(input, { actions = { default = default } })
end

function execute(cmd)
	print("CMD:", cmd)
	vim.api.nvim_command(cmd)
end
function resourcer()
	execute("source", vim.g.source_file)
end
vim.api.nvim_create_user_command("Upper", function(opts)
	print(string.upper(opts.args))
end, { nargs = 1 })

noremap("<leader><leader>e", ExportTreeAsJSON2)
noremap("f", "dd")
noremap("r", "<c-r>")
noremap("\\", open_buffer)
noremap("=", open_prev_buffer)
noremap("3", "#")
noremap("b", "<c-o>")
noremap("h", "<c-i>")
noremap("q", ":q<cr>")
noremap("<leader><leader>r", resourcer)

vim.g.plugin = "fzf-lua"
vim.g.dir = "~/.config/nvim/lua"
vim.g.source_file = "~/.config/nvim/lua/config/snippets/test.lua"
vim.g.source_file = "~/.config/nvim/lua/config/init.lua"
vim.g.source_file = "~/.config/nvim/lua/config/options.lua"
vim.g.source_file = "~/.config/nvim/lua/config/more/lua.lua"
vim.g.source_file = "~/.config/nvim/lua/snippets/lua.lua"
vim.g.vim_file = "~/.config/nvim/init.lua"
vim.g.typst_file = "~/abc.typ"
vim.g.plugin = "nvim-treesitter"
vim.g.plugin = "lsp"
vim.g.plugin = "cmp-calc"
vim.g.plugin = "nvim-grey"

local function count_params(fn)
	local info = debug.getinfo(fn, "u")
	return info.nparams
end

local function fast_command(key, cmd)
	noremap("<leader><leader>" .. key, ":" .. cmd .. "<CR>")
end
local function fastfile(key, file)
	table.insert(vim.g.files, file)
	local function func()
		open_buffer(file)
	end
	noremap(key, func)
end

local function iso8601()
	local time = os.date("!*t")
	local template = "%04d-%02d-%02d"
	return string.format(template, time.year, time.month, time.day)
end

function edit_dated_note_file()
	local file = string.format("~/NOTES/%s.txt", iso8601())
	open_buffer(file)
end
vim.g.lua_file = "/home/kdog3682/.config/nvim/init.lua"
noremap("ednf", edit_dated_note_file)
-- fastfile('ecf', vim.g.clip_f)
function inoremap(key, expr)
	vim.keymap.set("i", key, expr, { expr = true, noremap = true, silent = true })
end

function get_current_buffer(file)
	return file or vim.fn.expand("%")
end
function get_prev_buffer()
	return vim.fn.expand("#")
end

function get_current_buffer_directory()
	return head()
end
function get_prev_buffer_directory()
	return vim.fn.fnamemodify(vim.fn.expand("%"), ":h")
end
function qg_input()
	local a = vim.input("query")
	return a .. a .. a
end
inoremap("qgi", qg_input)
inoremap("qg3", get_prev_buffer)
inoremap("qgd3", get_prev_buffer_directory)
inoremap("qgd4", get_current_buffer_directory)
inoremap("qg4", get_current_buffer)

function prompt_for_input()
	prompt = "prompting for input"
	function callback(answer)
		return answer
	end
	local input = vim.ui.input({ prompt = prompt }, callback)
end

fast_command("t", "InspectTree")
fast_command("m", "messages")

function eval(s)
	return vim.fn.eval(s)
end

function is_file(x)
	return vim.fn.filereadable(x) == 1
end
function chdir(dir)
	vim.cmd.cd(dir)
end
function git_push_directory(dir)
	vim.fn.chdir(dir)
	vim.fn.system("git", "add .")
	vim.fn.system("git", "commit", '-m pushing"')
	vim.fn.system("git", "push")
	-- execute '!open ' . shellescape(expand('<cfile>'), 1
end
-- git_push_directory("/home/kdog3682/.config/nvim")

function doublequote(s)
	return vim.fn.printf('"%s"', s)
end

function maybe_print(s)
    if s then
        if type(s) == "userdata" then
            local a = s:type()
            if a then
                print(stringify(get_node_info(s)))
            end
        else
            print(s)
        end
    end
end
function run_lua_function(key, arg)
	local argstr = ""
    if arg then argstr = doublequote(arg) end
	local cmd = vim.fn.printf(":lua maybe_print(%s(%s))", key, argstr)
	vim.cmd(cmd)
end

function run_python_function(key, arg)
	vim.fn.system({ "python3", "~/PYTHON/run.py", key, arg })
end
function open_file(file)
	local file = file or vim.fn.expand("%")
	print(file)
	run_python_function("ofile", file)
end
vim.keymap.set("n", "<leader>o", open_file)

function foo()
	local bufnr = vim.api.nvim_get_current_buf()
	local comment_delimiters = vim.bo[bufnr].comments
	print(comment_delimiters)
	print(vim.inspect(comment_delimiters))
end


function test(s, r)
	if not s then
		return false
	end
	return s:find(r)
end
function is_number(x)
	return type(x) == "number" or test(x, "^%d")
end
function is_string(x)
	return type(x) == "string"
end
function find_parent_node(node, check)
	local checkpoint = check
	if is_string(check) then
		checkpoint = function(node)
			return node:type() == check
		end
	end

	local current = node
	while current ~= nil do
		if checkpoint(current) then
			return current
		end

		current = current:parent()
	end

	return false
end

function get_function_node()
	local node = get_cursor_node(node)
	return find_parent_node(node, "function_declaration")
end
function is_boolean(x)
	return type(x) == "boolean"
end
function find_child_node(node, kind)
	local function callback(node)
		return node:type() == kind
	end

	local function traverse_nodes(node)
        print_node(node)
		local current = node
		while current ~= nil do
			if callback(current) then
				return current
			end
			if current:child_count() > 0 then
				local child = current:child(i)
				local result = traverse_nodes(child)
				if result ~= nil then
					return result
				end
			end
			current = current:next_sibling()
		end
	end
	return traverse_nodes(node)
end
function get_identifier_node(node)
	local child = find_child_node(node, "identifier")
	return child
end

function simple_comment()
	local bufnr = vim.api.nvim_get_current_buf()
	local comment = vim.bo[bufnr].comments
end
vim.g.temp_file = "/home/kdog3682/temp.txt"
function get_set_node(node, callback)
	local start_row, start_col, end_row, end_col = node:range()
	local new_text = callback(node)
	vim.api.nvim_buf_set_text(0, start_row, start_col, end_row, end_col, { new_text })
end
function match(s, regex)
	local m = vim.fn.matchstr(s, vim.regex(regex))
	if m == nil then
		m = ""
	end
	return m
end
function len(x)
	return x and #x
end
function to_lines(x)
	if is_array(x) then
		return x
	else
		return vim.fn.split(x, "\n")
	end
end
local function replace_lines(from, to, payload)
	vim.api.nvim_buf_set_lines(0, from, to, false, payload)
end

function repeatstr(str, count)
	local result = ""
	for i = 1, count do
		result = result .. str
	end
	return result
end
function indent(payload, ind)
	ind = ind or 0
	local function indenter(s)
		local spaces = repeatstr(" ", ind)
		return spaces .. s
	end
	payload = map(to_lines(payload), indenter)
	return payload
end

function get_set_line(line_number, fn)
	local prev = vim.fn.getline(line_number)
	local text = vim.fn.trim(prev)
	local ind = len(match(text, "^%s*"))
	local payload = indent(fn(text, ind), ind)
	replace_lines(line_number - 1, line_number, payload)
end

local function read(file_path)
	local file, err = io.open(file_path, "r")
	if not file then
		error("Failed to open file: " .. err)
	end

	local content = file:read("*a")
	file:close()

	local decoded_data, decode_err = vim.json.decode(content)
	if decode_err then
		return content
	else
		return decoded_data
	end
end

function keys(iterable)
	local store = {}
	for key, _ in pairs(iterable) do
		table.insert(store, key)
	end
	return store
end

function is_table(x)
	return type(x) == "table"
end
local function write(file_path, data)
	local content = stringify(data)
	vim.fn.writefile(content, file_path)
end
function clip(s)
	write(vim.g.clip_file, s)
end

local function get_line_info()
	local current_buffer = vim.api.nvim_get_current_buf()
	local current_line = vim.api.nvim_get_current_line()
	local trimmed_line = current_line:gsub("^%s*(.-)%s*$", "%1")
	local leading_spaces = current_line:match("^%s*")
	local num_leading_spaces = leading_spaces and #leading_spaces or 0

	return {
		text = trimmed_line,
		ind = num_leading_spaces,
	}
end

function tern(a, b, c)
	if a then
		return b
	else
		return c
	end
end
function append_file(a, b)
	local content = to_line_content(b)
	vim.fn.writefile(content, a, "a")
end
function temp(data, mode)
	local fn = tern(mode == "a", append_file, write)
	fn(vim.g.temp_file, data)
end

function prettier()
	local file = get_current_buffer()
	local ft = get_filetype(file)
	local deno = "deno fmt --indent-width=4 --no-semicolons --line width=65"
	local stylua = "/mnt/chromeos/MyFiles/Downloads/stylua"

	local ref = {
		lua = stylua, -- works
		vue = "eslint --fix", -- not working
		javascript = deno, -- dunno
		typescript = deno,
	}
	local cmd = ref[ft] .. " " .. file
	pause(cmd)
	os.execute(cmd)
	vim.cmd("silent! e!")
end

function opposite(s)
	local ref = {
		["1"] = 0,
		["0"] = 1,
		["false"] = true,
		["true"] = false,
	}
	return ref[tostring(s)]
end
function toggle()
	local val = opposite(vim.g.state.debug)
	print("new value @ toggle", val)
	vim.g.state.debug = val
end
-- Execute a shell command using vim.fn.system
function execute_command(...)
	local command = table.concat({ ... }, " ")
	local result = vim.fn.system("clear;" .. command)
	print(result)
end

function foo()
	-- local iden = get_identifier_node(node)
	-- local apikeys = keys(vim.api)
	-- temp(apikeys)
	-- print(get_filetype("abc.js"))
	execute_command("ls -a")
end
-- foo()
function get_buffers()
	local buffers = vim.api.nvim_list_bufs()
	return buffers
end
function print_factory(fn)
	local function printed(...)
		local success, result = pcall(fn)
		print(result)
		print_table_contents(result)
	end
	return printed
end
inoremap("-", smart_dash) -- dangerous
noremap("ls", print_factory(get_buffers))

inoremap("qw", motion_qw)

vim.keymap.set("i", ";", ":")
vim.keymap.set("i", ":", ";")
vim.opt.list = false -- dont show hidden spaces


function find_line(r)
	local pattern = vim.regex(r)
	local lines = vim.fn.getline(1, "$")

	for i, line in ipairs(lines) do
		if pattern:match_line(line) then
			print("Match found on line " .. i .. ": " .. line)
		end
	end
end
function clone(url, to)
	local s = string.format("git clone %s %s", url, to)
	vim.fn.system(s)
end
function exists(x)
	return not empty(x)
end
function get_child_nodes(node)
	local store = {}
	local stop = node:child_count()
	for i = 1, stop do
		local child = node:child(i - 1)
		table.insert(store, child)
	end
	return store
end
function map(items, fn)
	local store = {}
	for i, item in pairs(items) do
		table.insert(store, fn(item))
	end
	return store
end
function get_page_text()
	local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
	return table.concat(lines, "\n")
end
function get_node_text(node)
	local bufnr = vim.api.nvim_get_current_buf()
    return vim.treesitter.get_node_text(node, bufnr)
end
function find_node(items, kind)
	local function checkpoint(node)
		return node:type() == kind
	end
	for i, item in pairs(items) do
		if checkpoint(item) then
			return item
		end
	end
end
function get_top_nodes()
	local a = 12
	return 123
end
function asdf()
	return
end

function caller(fn)
    success, result = pcall(fn)
    if success then
        maybe_print(result)
    else
        print("failed @ caller for fn", fn)
    end
end
function one()
	local node = get_function_node()
	local a = get_identifier_node(node)
	local identifier = get_node_text(a)
	local cmd = vim.fn.printf(":lua caller(%s)", identifier)
    vim.cmd(cmd)
end

function lua_function_caller()
	-- howdy
	local node = get_function_node()

	if node == false then
		print("error for some reason ... no node was found ...")
		return
	end

	local a = get_identifier_node(node)
	local identifier = get_node_text(a)
	local b = find_child_node(node, "block")
	local children = get_child_nodes(node)
	local comment = find_node(children, "comment")
	store = {}
	store.identifier = identifier
	store.arg = ""
	if comment then
		arg = get_node_text(comment)
		store.arg = arg
	end
    maybe_debug(store)
	if identifier == "lua_function_caller" then
		return
	end

	run_lua_function(identifier, arg)
end

function maybe_debug(x)
    vim.g.state.debug = true
    if vim.g.state.debug == true then
        pause(stringify(store))
    end
end
function to_line_content(data)
	if type(data) == "table" then
		if is_array(data) then
			return data
		end
		return { vim.fn.json_encode(data) }
	else
		return { data }
	end
end
function stringify(data)
	if type(data) == "table" then
		return vim.fn.json_encode(data)
	else
		return data
	end
end

noremap("P", "prettier", { save = true })
-- noremap("P", prettier)
noremap("1", lua_function_caller)
vim.keymap.set("i", "qp", "(<c-o>$)")
-- get_root_node()
-- lua_function_caller()
-- print(tail("aa"))
-- motion_qw()
-- https://github.com/yehuohan/cmp-im
-- https://github.com/hrsh7th/cmp-calc

-- clone("https://github.com/numToStr/Comment.nvim", "~/.config/nvim/lua/local-plugins/comment")
-- works

function bash(s)
	os.execute(s)
end
local function bashsnippet(_, _, command)
	local file = io.popen(command, "r")
	local res = {}
	for line in file:lines() do
		table.insert(res, line)
	end
	return res
end

function bash_smth()
	bash([[
 sudo unzip /mnt/chromeos/Myfiles/Downloads/Hack.zip -d /usr/.local/share/fonts;
 sudo fc-cache -f -v;
 ]])
end

function git_push_directory()
	bash([[
        cd ~/.config/nvim
        git add .
        git commit -m "pushing"
        git push
        echo pushed!
    ]])
end
fastfile("esf", vim.g.source_file)
fastfile("esf", vim.g.source_file)

fastfile("ex", vim.g.temp_file)
fastfile("evu", vim.g.vue_file)
fastfile("evc", vim.g.clip_file)
fastfile("evf", vim.g.lua_file)
fastfile("etf", vim.g.typst_file)

function sub(s, r, regex, flags)
	if not flags then
		flags = ""
	end
	return vim.fn.substitute(s, r, vim.regex(regex), flags)
end
function nvim_tree(path)
	local api = require("nvim-tree.api")
	api.tree.open({ path = path })
end

function get_root_node()
	return vim.treesitter.get_parser():parse()[1]:root()
end

local function collect_top_level_identifiers()
	local node = get_root_node()
    if empty(node) then return end
	local store = {}
	for child in node:iter_children() do
		if child:type() == "function_declaration" then
			local iden = get_identifier_node(child)
			push(store, get_node_text(iden))
		end
	end
	return store
end

function get_cursor_node()
	local cursor = vim.api.nvim_win_get_cursor(0)
	local left_of_cursor_range = { cursor[1] - 1, cursor[2] - 1 }
	local node = vim.treesitter.get_node({ pos = left_of_cursor_range })
	return node
end

function fuzzyfind(dir)
	if not dir then
		dir = vim.g.state.directories[1]
	end
end
noremap("<leader>f", fuzzyfind)

function nvim_tree_toggle()
	local tree = require("nvim-tree.api").tree
	if tree.is_visible() then
		tree.toggle()
	end
end

function arrow_right()
	local tree = require("nvim-tree.api").tree
	if tree.is_visible() then
		tree.toggle()
	end
end

function arrow_left()
	local tree = require("nvim-tree.api").tree
	if tree.is_visible() then
		tree.toggle()
	end
end
function omni_copy()
	local w = vim.fn.expand("<cword>")
	print(w)
end
function choose(items, opt)
	local select = vim.ui.select
	if opt.multiple then
		select = vim.ui.select_mult
	end
	local label = opt.label or "item"
	local prompt = vim.fn.printf("please choose a %s", label)

	select(options, {
		prompt = prompt,
	}, opt.callback)
end
function upper(s)
	return s:upper()
end
function append(s, i)
	if not i then
		i = vim.fn.line(".")
	end
	vim.api.nvim_buf_set_lines(0, i, i, false, to_lines(s))
end
function jspy(key, filetype)
	filetype = get_filetype(filetype)
	ref = jspyref[filetype]
	return ref and ref[key]
end

function vimeval(s)
	-- timestamp
	local aliases = {
		timestamp = "tostring(os.time())",
	}
	local code = aliases[s] or s
	return load(code)
end
function vt(s, o)
	local function callback(capture)
		local m = jspy(capture)
		if exists(m) then
			return m
		end
		m = vimeval(capture)
		if exists(m) then
			return m
		end
		m = o and o[capture]
		if exists(m) then
			return m
		end
	end
	local r = "%$(%w+)"
	return string.gsub(s, r, callback)
end
function set_bookmark()
	local choices = { "fix", "todo", "problem" }
	local function callback(label)
		label = upper(label)
		message = vt("$comment_delimiter$timestamp $label: ")
		append(message)
	end
	local a = choose(choices, { label = "bookmark type", callback = callback })
end
noremap("<s-left", arrow_left)
function implicit_anything_handler(arg)
	local items = {
		{
			match = "github",
			callback = clone,
		},
		{
			match = "githubb",
		},
	}
	local opts = imatch(arg, items)
	local params = count_params(v.callback) - 1
	local args = {}
	local function callback(input)
		push(args, input)
	end

	for i = 1, #params do
		local m = vim.fn.printf("requesting arg %s", i)
		prompt(m, callback)
	end

	args = map(args, to_string_argument)
	pause(args)
	status, result = pcall(opts.callback, unpack(args))
	if status then
		print(result)
	end
end

function to_string_argument(s)
	if is_number(s) then
		return tonumber(s)
	end
	return doublequote(tostring(s))
end
function to_argument(s)
	if is_number(s) then
		return tonumber(s)
	end
	return tostring(s)
end
function imatch(arg, items)
	for i, v in pairs(items) do
		if test(arg, v.match) then
			return v
		end
	end
end
function foobarasd(sadsad) end
function prompt(message, callback)
	vim.ui.input({ prompt = message }, function(input)
		callback(input)
	end)
end
function push(base, item)
	if empty(item) then
		return
	end
	table.insert(base, item)
end
-- implicit_anything_handler()
-- see(vim.fn) -- lets you see what it has

-- require("filetype")
function fzf_query_directory(s)
	local q =
		[[find $(pwd) -regextype posix-extended -type f | grep -vE '(fonts|.git|node_modules|.log$|temp|package)']]
	local actions = {
		["default"] = require("fzf-lua").actions.file_edit,
	}
	require("fzf-lua").fzf_exec(q, { cwd = s, actions = actions })
end
function abc()
	-- fzf(vim.g.state.files)
end
noremap("<leader>a", "fzf_query_directory", { args = "~/.config/nvim" })
-- https://github.com/JoosepAlviste/dotfiles/tree/c171efbbbe0daa5e737250ec82338a51ed53c15a/config/nvim/lua/j

local alphabet = { "a", "b", "c" }
local function select(items, callback)
	vim.ui.select(items, {}, callback)
end

local function regex_find_function(key)
    vim.cmd(vim.fn.printf("normal! /^\\v(local )?function %s\\(/e\r", key))
end
function four()
	local ids = collect_top_level_identifiers()
	select(ids, regex_find_function)
end
noremap("4", four)

noremap("<leader><leader>s", "<cmd> source /home/kdog3682/.config/nvim/lua/plugins/lsp.lua<cr>")

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

function formatter(name, template, nodes)
	return s(name, fmta(template, nodes))
end

function wrapf2(fn)
    local function lambda(...)
        return pcall(fn, unpack({...}))[2]
    end
    return lambda
end
function booga(s)
    return "a"
end

function get_identifier_nodes_above_cursor()
    local nodes = {}
    local node = get_cursor_node()
    pause(node:type())
    local s = get_node_text(node)
    pause(s)
    return s
end
local snippets = {
	formatter("x3", "<>\ndatetime: <>\nsubreddit: <>\ntitle: <>\nbody:\n<>", {
        p(vimeval, "timestamp"),
		t("aabbbbbbb"),
		c(1, {
            p(repeatstr, "-", 30),
            p(repeatstr, "-", 50),
			t("vim"),
			t("neovim"),
			t("askprogramming"),
			t("learnjavascript"),
			t("vuejs"),
		}),
		i(2),
		i(0),
	}),
	formatter("abc", "abcde <> fgh", { t("ax1") }),
}

-- ls.add_snippets("lua", snippets)

function get_node_info(root)
    return {range = root:range(), text = get_node_text(root), type = root:type()}
end
local function get_identifier_nodes_above_cursor()
    local root = get_root_node()

    local cursor_pos = vim.api.nvim_win_get_cursor(0)
    local cursor_node = root:named_descendant_for_range(cursor_pos[1] - 1, cursor_pos[2])
    get_node_info(cursor_node)


    local identifier_nodes = {}
    local current_node = cursor_node
    while current_node do
        if current_node:type() == "identifier" then
            table.insert(identifier_nodes, current_node)
        end
        current_node = current_node:parent()
    end

    for i, node in ipairs(identifier_nodes) do
        local start_row, start_col, end_row, end_col = node:range()
        local identifier_text = vim.treesitter.get_node_text(node, bufnr)
        pause(string.format("Identifier %d: %s (%d, %d) - (%d, %d)", i, identifier_text, start_row + 1, start_col, end_row + 1, end_col))
    end
end

-- get_identifier_nodes_above_cursor()
vim.opt.modifiable = true

function go_file_or_function()
    local a = go_file()
    if a then return end
    if go_function() then return end
    print("no file and no function")
end
function go_file()
	local a = vim.fn.getline(".")
    local pattern = "%b''"
    local match = string.match(a, pattern)

    if not match or len(match) < 5 then
        pattern = '%b""'
        match = string.match(a, pattern)
    end
    if not match or len(match) < 5 then
        return false
    end
    if match then
        match = string.sub(match, 2, -2)
        pause(match)
        if is_file(match) then
            open_buffer(match)
            return true
        end
    end
    print('no file found in a string')

end
function go_function()
	local w = vim.fn.expand("<cword>")
	local a = vim.fn.getline(".")
    if test(a, w .. "%(") then
        regex_find_function(w)
        return true
    end
end

noremap('gf', go_file_or_function)
local lazyrootpath = vim.fn.stdpath("data") .. "/lazy" -- directory where plugins will be installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local calc = "/home/kdog3682/.local/share/nvim/lazy/cmp-calc/lua/cmp_calc/init.lua"
noremap("<leader><leader>r", reloader)

local function evaluate(program)
  local m = load('return ' .. program)
  if type(m) ~= 'function' then
    return false
  end
  local status, value = pcall(m)

  if not status or type(value) ~= "number" then
    return false
  else
    return tostring(value)
    end
end



local cmp = require 'cmp'

local NAME_REGEX = '\\%([^/\\\\:\\*?<>\'"`\\|]\\)'
local PATH_REGEX = vim.regex(([[\%(\%(/PAT*[^/\\\\:\\*?<>\'"`\\| .~]\)\|\%(/\.\.\)\)*/\zePAT*$]]):gsub('PAT', NAME_REGEX))

local source = {}

local constants = {
  max_lines = 20,
}

---@class cmp_path.Option
---@field public trailing_slash boolean
---@field public label_trailing_slash boolean
---@field public get_cwd fun(): string

---@type cmp_path.Option
local defaults = {
  trailing_slash = false,
  label_trailing_slash = true,
  get_cwd = function(params)
    return vim.fn.expand(('#%d:p:h'):format(params.context.bufnr))
  end,
}

source.new = function()
  return setmetatable({}, { __index = source })
end

source.get_trigger_characters = function()
  return { '.', ':' }
end

source.complete = function(self, params, callback)
  local candidates = self:get(params)
  return callback(candidates)
end

source.resolve = function(self, completion_item, callback)
  callback(completion_item)
end

source.get = function(self, params, option)
  local s = params.context.cursor_before_line
  local offset = params.offset
  local input = string.sub(s, offset - 1)
  -- local prefix = string.sub(s, 1, offset - 1) -- includes the dot
  local prefix = string.sub(s, 1, offset - 2) -- includes the dot
  local name = "ggggggggg"
  print(stringify({input = input, prefix = prefix, cursor_before_line = s}))
   local item = {
      label = name,
      filterText = name,
      insertText = name,
      kind = cmp.lsp.CompletionItemKind.File,
      data = {
          booga = 123
      },
    }
    return {item}
end


function generate_random_id(length)
    local chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'
    local id = ''
    local random = math.random

    for i = 1, length or 10 do
        id = id .. chars:sub(random(1, #chars), 1)
    end

    return id
end

-- local handler = "a"
-- cmp.register_source(handler, source.new())
-- cmp.setup.filetype("lua", {
--     sources = cmp.config.sources({
--         {name = "luasnip"},
--         {name = handler},
--         {name = "buffer"},
--     })
-- })
function visual_handler()
    fooo()
   -- gccasdf
end
function to_array(t)
    if not t then return {}
    elseif vim.tbl_islist(t) then
        return t
    end
    return { t }
end

local function contains(types, target)
    if not is_array(types) then
        return types == target
    end
    for _, type in ipairs(types) do
        if target == type then
            return true
        end
    end
    return false
end

function get_root_node2()
    local ts_utils = require("nvim-treesitter.ts_utils") 
    local root = ts_utils.get_node_at_cursor()
    return root
end

function get_visual_selection_lines()
  local start_pos = vim.fn.getpos("'<")
  local end_pos = vim.fn.getpos("'>")

  local start_line = start_pos[2]
  local end_line = end_pos[2]

  return {start_line, end_line}
end

function get_lines(a, b)
    return vim.api.nvim_buf_get_lines(0, a, b, false)
end
function fooo()
    local vstart = vim.fn.getpos("'<")
    local vend = vim.fn.getpos("'>")
    local line_start = vstart[2] 
    local line_end = vend[2]
    local p = vim.fn.getline(line_start, line_end)
    if true then return print(stringify(p)) end

-- or use api.nvim_buf_get_lines local lines = vim.fn.getline(line_start,line_end)


    local a, b = unpack(get_visual_selection_lines())
    local lines = get_lines(a, b + 1)
    append_file(vim.g.temp_file, lines)

    if true then return end
    local root = get_cursor_node()
        --local next = root:prev_sibling
    print(stringify(get_node_info(root)))


    if true then
        return end
    while root:parent() do
        root = root:parent()
    end
    -- DFS through the tree and find all nodes that have the given type
    local stack = { root }
    local nodes, selections_list = {}, {}
    while #stack > 0 do
        local cur = stack[#stack]
        -- If the current node's type matches the target type, process it
        if is_any_of(cur:type(), node_types) then
            -- Add the current node to the stack
            nodes[#nodes + 1] = cur
            -- Compute the node's selection and add it to the list
            local range = { ts_utils.get_vim_range({ cur:range() }) }
            selections_list[#selections_list + 1] = {
                left = {
                    first_pos = { range[1], range[2] },
                },
                right = {
                    last_pos = { range[3], range[4] },
                },
            }
        end
        -- Pop off of the stack
        stack[#stack] = nil
        -- Add the current node's children to the stack
        for child in cur:iter_children() do
            stack[#stack + 1] = child
        end
    end
end
function vnoremap(k, v)
    vim.keymap.set('v', k, vim.fn.printf(":'<,'> lua %s()<CR>", v))
end

function get_decl_node()
    local start = get_far_left_node()
    return start
end

function get_indent()
    local s = vim.fn.line('.')
    local indent_level = vim.fn.indent(s)
    return indent_level
end
function create_snippet(s)
    return snippet
end
function getvis()
    local vstart = vim.fn.getpos("'<")
    local vend = vim.fn.getpos("'>")
    return {start, vend}
end

function uncomment(s)
    
end
function add_snippet()
    local s = uncomment(vim.fn.line('.'))
    local key = vim.fn.input("snippet key?")
    local ls = require("luasnip")
    local snippet = ls.parser.parse_snippet(key, expr)
    local ft = get_filetype()
    ls.add_snippets(ft, {
        snippet
    })
end
function print_node(node)
    pause(stringify(get_node_info(node)))
end
function get_far_right_node()
	local cursor = vim.api.nvim_win_get_cursor(0)
	local left_of_cursor_range = { cursor[1] - 1, start }
	local node = vim.treesitter.get_node({ pos = left_of_cursor_range })
	return node
end
function get_far_left_node()
	local cursor = vim.api.nvim_win_get_cursor(0)
	local left_of_cursor_range = { cursor[1] - 1, get_indent() + 1 }
	local node = vim.treesitter.get_node({ pos = left_of_cursor_range })
	return node
end

function foo()
    local my_query = [[
        ((function_definition
        name: (identifier) @function)
        (#set! "type" "$name"))
    ]]
    vim.treesitter.query.add_query('lua', 'my-query', my_query)

    local node = get_root_node()
    for _, match in ipairs(node) do
        print(get_node_text(match))
    end
end

function foo_asdfads_bar()
   local aaaa = 1
   return 123
end
function get_cmd_history()
  local cmd_history = vim.split(vim.cmdline, '\n')
  return cmd_history
end
function clear_cmd_history()
    vim.opt.cmdline = ""
end

function parse_query(s)
    return vim.treesitter.query.parse_query("lua", s)
end
function do_query(query, node)
    local query = parse_query(query)
    for _, matches, _ in ipairs(query:iter_matches(node), 0) do
        local return_type = vim.treesitter.query.get_node_text(matches[1], 0)
        local name = vim.treesitter.query.get_node_text(matches[2], 0)
        local param_node = matches[3]
        local param_info = {}

        for param in param_node:iter_children() do
            if param:type() == "formal_parameter" then
                table.insert(param_info, {
                    type = vim.treesitter.query.get_node_text(param:field("type")[1], 0),
                    name = vim.treesitter.query.get_node_text(param:field("name")[1], 0),
                })
            end
        end

        return {
            return_type = return_type,
            name = name,
            param_info = param_info,
            start_line = method_node:start(),
        }
    end
end
vnoremap('v', 'visual_handler')
noremap('1', 'one', {lua = true})

function get_identifier_node_left_of_cursor()
	local cursor = vim.api.nvim_win_get_cursor(0)
    local row = cursor[1] - 1
    local col = get_indent()
    pause("hI")

    local c = 0
    while c < 10 do
        c = c + 1
        local node = vim.treesitter.get_node({ pos = {row, col} })
        if node:type() == "block" then
            col = col + 1
        else
            local cccc = 0
            print_node(node)
            return pause(find_child_node(node, "identifier"))
        end
    end
    return 'error: no node found'
end


function prepare_text_input(s)
    return sub(s, "\n", "\\n")
end
function abc()
	local a = vim.fn.system('ls ~/LOREMDIR')
    a = prepare_text_input(a)
    print(a)
end
function get_identifier()
    return fli("^function (%w+)")
end
function run_lua_function_with_identifier()
    local arg = get_identifier()
    run_lua_function(arg)
end
noremap("2", "get_identifier", {lua = true})
noremap("1", run_lua_function_with_identifier)

-- print(vim.fn.match("abc", "%a"))

function redirector(cmd)
    -- Redirect the output of `:highlight` to the temporary file
    local tmp_file = "/home/kdog3682/del.txt"
    vim.cmd("redir! > " .. tmp_file)
    vim.cmd("silent " .. cmd)
    vim.cmd("redir END")
end


function remove_items(sources, targets)
    for i = #sources, 1, -1 do
        if contains(targets, sources[i]) then
            table.remove(sources, i)
        end
    end
    return sources
end
