vim.g.mapleader = ","
vim.cmd('set nohlsearch')


function noremap(key, expr)
  vim.keymap.set('n', key, expr, { noremap = true, silent = true})
end


-----------------------------
-----------------------------
-----------------------------

-- noremap("kl", "ToggleSyntax()")
-- noremap("la", "Lazy")
-- noremap("bd", ":bd<CR>")
vim.keymap.set("n", "x", '"_x')

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
vim.api.nvim_set_keymap("n", "s", ":update<CR>", { noremap = true, silent = false })
-- vim.cmd("autocmd! BufWritePost $MYVIMRC source $MYVIMRC")
local group = vim.api.nvim_create_augroup("kdog3682", { clear = true })

function lua_bufwrite_callback()
    local bufname = vim.api.nvim_buf_get_name(0)
    -- local ft = get_filetype(bufname)
     -- print(bufname)
    execute("source", bufname)
end
vim.api.nvim_create_autocmd("BufWritePost", {group = group, callback = lua_bufwrite_callback, pattern = {"lua"}})
-- vim.api.nvim_create_autocmd("FileType", group = group, callback = filetype_callback)

-----------------------------
-----------------------------
-----------------------------

vim.o.termguicolors = true

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

-- Function to capture, filter (regex), and append output (case-insensitive)
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
local person = Person:new("John", 30)

-- Access properties and call methods
-- print(person:getName()) -- Output: John
-- print(person:getAge()) -- Output: 30
-- person:introduce() -- Output: Hi, my name is John and I am 30 years old.

vim.api.nvim_set_keymap("n", "[", ":normal! 10k<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "]", ":normal! 10j<CR>", { noremap = true, silent = true })

-- Get all key mappings
-- local mappings = vim.api.nvim_get_keymap('')
-- print(mappings)
-- Iterate over mappings

-- Function to list mappings that start with '[' for the current buffer
local function list_mappings_starting_with_left_bracket()
	local bufnr = vim.fn.bufnr() -- Get the buffer number of the current buffer
	local mappings = vim.api.nvim_get_keymap("n")
	print("Mappings starting with '[' for current buffer:")
	for _, mapping in ipairs(mappings) do
		print(mapping.lhs, mapping.rhs)
		if mapping.lhs:sub(1, 1) == "[" then
			print(mapping.lhs .. "\t" .. mapping.rhs)
		end
	end
end

-- Call the function to list mappings starting with '[' for the current buffer
-- list_mappings_starting_with_left_bracket()

-- Function to scan the line above the current line for variable names and print them
vim.api.nvim_set_keymap("n", "lp", ":lua print_variables_above_line()<CR>", { noremap = true, silent = true })

-- Function to toggle comments for the current line
local function toggle_comments()
	-- Get the current line number
	local line_number = vim.fn.line(".")
	-- Get the comment string for the current filetype
	local commentstring = vim.bo.commentstring or ""
	-- Check if the current line is commented
	local is_commented = vim.fn.match(vim.fn.getline(line_number), "^%s*" .. commentstring) >= 0
	-- If the line is commented, remove the comment; otherwise, add it
	if is_commented then
		vim.fn.setline(
			line_number,
			vim.fn.substitute(vim.fn.getline(line_number), "^%s*" .. vim.pesc(commentstring), "", "")
		)
	else
		vim.fn.setline(line_number, commentstring .. vim.fn.getline(line_number))
	end
end

-- Create a normal mode mapping for the "c" key to toggle comments
vim.api.nvim_set_keymap("n", "c", ":lua toggle_comments()<CR>", { noremap = true, silent = true })

local comment_delimiters = {
	lua = "--",
	python = "#",
	javascript = "//",
	-- Add more filetypes and their respective comment delimiters as needed
}

-- Function to print all contents of a table
local function print_table_contents(tbl)
	for key, value in pairs(tbl) do
		print(key, ': ', value)
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
-- vim.ui.input({ prompt = 'Enter value for shiftwidth: ' }, function(input)
--   vim.o.shiftwidth = tonumber(input)
--  end)
-- end

vim.api.nvim_set_keymap("n", "<Leader>rx", ':lua select_item({"a", "b", "bb"})<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>r", ":lua foo()<CR>", { noremap = true })

vim.g.your_cmp_disable_enable_toggle = 1

local s = [[

vim.g.your_cmp_disable_enable_toggle =


]]

-- Define a function to evaluate and execute the current line
local function eval_and_execute_current_line()
	-- Get the current line under the cursor
	local current_line = vim.api.nvim_get_current_line()

	-- Evaluate the Lua code in the current line
	local success, result = pcall(load(current_line))

	-- If evaluation was successful, execute the result
	if success then
		if type(result) == "function" then
			result()
		else
			print("Result:", result)
		end
	else
		print("Error:", result)
	end
end

-- Map a key to trigger the eval_and_execute_current_line function
-- vim.api.nvim_set_keymap('n', '<Leader>e', '<cmd>lua eval_and_execute_current_line()<CR>', { noremap = true, silent = true })

local api = vim.api

vim.g.funcs = "aaa"

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

vim.cmd("autocmd! BufWritePost $MYVIMRC source $MYVIMRC")
require("config")



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

vim.o.numberwidth = 2  -- Adjust to your preference





-- Function to write the current TreeSitter tree to a JSON file
local function ExportTreeAsJSON2()
    local filePath = "tree-sitter.json"
    local parser = vim.treesitter.get_parser(0, vim.bo.filetype)
    local tree = parser:parse()[1]
    local root = tree:root()
    print(root)

    -- Convert the TreeSitter tree to a Lua table
    local function convertNode(node)
        local t = {
            type = node:type(),
            range = { node:range() },
            rows = { node:source() },
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

    local treeData = convertNode(root)

    -- Write the TreeSitter tree to a JSON file
    local jsonData = vim.json.encode(treeData)
    vim.fn.writefile({jsonData}, filePath)
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
    return 'todo!'
  end
end
function prettier()
    local e = get_filetype()
    vim.fn.system(cmd)
end
function reloader()
    vim.cmd("Lazy reload " .. vim.g.plugin)
end
vim.keymap.set("n", "<c-p>", ":FzfLua oldfiles resume = true<CR>", { silent = true })
vim.keymap.set("n", "P", prettier, { silent = true })
vim.keymap.set("n", "<leader><leader>r", reloader, { silent = true })
local function anything_handler(s)
    local fn = get_filetype()
    print(fn())
end


vim.keymap.set("n", ";", ":lua anything_handler('')<LEFT><LEFT>")


M = require("stdlib.meta")

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
   local fpath = vim.fn.fnamemodify(vim.fn.expand "%", ":~")
  if fpath == "" or fpath == "." then
      return " "
  end
  return string.format(" %%<%s", fpath)
  -- Refer to :h filename-modifiers for more.
end
function statusline()
    -- Get current file name
    local filename = vim.fn.expand('%:t')
    local filetype = vim.bo.filetype
    local line = vim.fn.line('.')
    local current_mode = vim.api.nvim_get_mode().mode

    -- Get total number of lines in the buffer
    local total_lines = vim.fn.line('$')
    return string.format("File: %s | Type: %s | Line: %d/%d", filename, filetype, line, total_lines)
end
function statusline()
    local current_mode = vim.api.nvim_get_mode().mode
    return filepath() .. '     ' .. (current_mode == 'i' and "-- INSERT --"  or '')
end

-- Set the statusline option to use the Lua function
vim.o.statusline = '%!v:lua.statusline()'
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
vim.keymap.set("n", "\\", function()
	local line = vim.fn.getline(".")
    local col = vim.fn.col(".")
    -- require("fzf-lua").commands()
    require("fzf-lua").fzf_exec({"a", "b"})
end, {noremap = true})

function execute(cmd)
    print('CMD:', cmd)
    vim.api.nvim_command(cmd)
end
function resourcer()
    execute("source", vim.g.source_file)
end
vim.api.nvim_create_user_command(
    'Upper',
    function(opts)
        print(string.upper(opts.args))
    end,
    { nargs = 1 }
)


noremap('<leader><leader>e', ExportTreeAsJSON2)
noremap('f', 'dd')
noremap('r', '<c-r>')
noremap('\\', open_buffer)
noremap('=', open_prev_buffer)
noremap('3', "#")
noremap('b', "<c-o>")
noremap('h', "<c-i>")
noremap("q", ":q<cr>")
noremap("<leader><leader>r", resourcer)

vim.g.plugin = 'fzf-lua'
vim.g.dir = '~/.config/nvim/lua'
vim.g.source_file = '~/.config/nvim/lua/config/snippets/test.lua'
vim.g.source_file = '~/.config/nvim/lua/config/init.lua'
vim.g.source_file = '~/.config/nvim/lua/config/options.lua'
vim.g.source_file = '~/.config/nvim/lua/config/more/lua.lua'
vim.g.vim_file = '~/.config/nvim/init.lua'
vim.g.typst_file = '~/abc.typ'
vim.g.plugin = 'nvim-grey'
vim.g.plugin = 'nvim-treesitter'

local function count_params(fn)
    local info = debug.getinfo(fn, "u")
    return info.nparams
end


local function fast_command(key, cmd)
    noremap("<leader><leader>" .. key, ':' .. cmd .. '<CR>')
end
local function fastfile(key, file)
    local function func()
        open_buffer(file)
    end
    noremap(key, func)
end


vim.g.ts_file = '~/my-vitesse-app/src/main.ts'
vim.g.vue_file = '~/my-vitesse-app/src/main.ts'
vim.g.clip_file = '~/2023/clip.js'
fastfile('esf', vim.g.source_file)
fastfile('evf', vim.g.vim_file)
fastfile('evu', vim.g.vue_file)
fastfile('evc', vim.g.clip_file)
fastfile('etf', vim.g.typst_file)
function inoremap(key, expr)
    vim.keymap.set('i', key, expr, { expr = true, noremap = true, silent = true})
end

function get_current_buffer()
    return vim.fn.expand('%')
end
function get_prev_buffer()
    return vim.fn.expand('#')
end

function get_current_buffer_directory()
    return vim.fn.fnamemodify(vim.fn.expand("%"), ":h")
end
function get_prev_buffer_directory()
    return vim.fn.fnamemodify(vim.fn.expand("%"), ":h")
end
inoremap('qg3', get_prev_buffer)
inoremap('qgd3', get_prev_buffer_directory)
inoremap('qgd4', get_current_buffer_directory)
inoremap('qg4', get_current_buffer)


vim.filetype.add({
  pattern = {
    ["%.typ$"] = "typst", -- Associate files with .abc.def.js extension with the typst filetype
    ["%.xyz%.js$"] = "typst", -- Associate files with .xyz.js extension with the typst filetype
  },
  extension = {
    typ = "typst", -- Associate .typ files with the typst filetype
  },
})


function prompt_for_input()
    prompt = "prompting for input"
    function callback(answer)
        return answer
    end
    local input = vim.ui.input({prompt = prompt}, callback)
end

fast_command("t", "InspectTree")
fast_command("m", "messages")

function eval(s)
    return vim.fn.eval(s)
end


function isfile(x)
    return vim.fn.isfile(x)
end
function isdir(x)
    return vim.fn.isdirectory(x)
end
function git_push_directory(dir)
    vim.fn.chdir(dir)
    vim.fn.system('git', 'add .')
    vim.fn.system('git', 'commit', '-m pushing"')
    vim.fn.system('git', 'push')
    -- execute '!open ' . shellescape(expand('<cfile>'), 1
end
-- git_push_directory("/home/kdog3682/.config/nvim")


function run_python_function(key, arg)
  vim.fn.system({'python3', '~/PYTHON/run.py', key, arg})
end
function open_file(file)
    local file = file or vim.fn.expand("%")
    print(file)
    run_python_function("ofile", file)
end
vim.keymap.set('n', '<leader>o', open_file)
