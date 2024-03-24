
vim.g.mapleader = ","

function endsWith(str, ending)
    return ending == "" or str:sub(-#ending) == ending
end

function noremap(key, value)
    cmd = ''
    if endsWith(value, ')') then
        cmd = ':lua ' .. value
    else
        cmd = ':' .. value
    end
    cmd = cmd .. '<CR>'

    vim.api.nvim_set_keymap('n', key, cmd, {noremap = true, silent = true})
end


-----------------------------
-----------------------------
-----------------------------

noremap('kl', 'ToggleSyntax()')
noremap('la', 'Lazy')
noremap('bd', 'bd')
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
vim.api.nvim_set_keymap('n', 's', ':w<CR>', { noremap = true })
vim.cmd('autocmd! BufWritePost $MYVIMRC source $MYVIMRC')



-----------------------------
-----------------------------
-----------------------------



vim.o.termguicolors = true

vim.g.loaded_python3_provider = 0
vim.cmd("syntax on")
-- vim.cmd('highlight Cursor guifg=gray')
vim.cmd('highlight MatchParen guifg=black')

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

local blue = "#00BFFF"  -- You can adjust this hex code to your desired shade of blue

-- Change the color of icons, bullets, and labels
-- vim.api.nvim_set_hl(0, "IconBullet", { fg = black })
-- vim.api.nvim_set_hl(0, "LabelIconBullet", { fg = black })


-- Function to scan the line above the current line for variable names and print them
local function print_variables_above_line()
    -- Get the line number of the line above the current line
    local line_above = vim.fn.line('.') - 1
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
    local indent = vim.fn.matchstr(line_content, '^%s*')
    -- Append the print statement with proper indentation to the current line
    vim.fn.append('.', indent .. print_statement)
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
        age = 30
    }
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
    end
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


vim.api.nvim_set_keymap('n', '[', ':normal! 10k<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', ']', ':normal! 10j<CR>', { noremap = true, silent = true })


-- Get all key mappings
-- local mappings = vim.api.nvim_get_keymap('')
-- print(mappings)
-- Iterate over mappings


-- Function to list mappings that start with '[' for the current buffer
local function list_mappings_starting_with_left_bracket()
    local bufnr = vim.fn.bufnr()  -- Get the buffer number of the current buffer
    local mappings = vim.api.nvim_get_keymap('n')
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
vim.api.nvim_set_keymap('n', 'lp', ':lua print_variables_above_line()<CR>', { noremap = true, silent = true })

-- Function to toggle comments for the current line
local function toggle_comments()
    -- Get the current line number
    local line_number = vim.fn.line('.')
    -- Get the comment string for the current filetype
    local commentstring = vim.bo.commentstring or ""
    -- Check if the current line is commented
    local is_commented = vim.fn.match(vim.fn.getline(line_number), '^%s*' .. commentstring) >= 0
    -- If the line is commented, remove the comment; otherwise, add it
    if is_commented then
        vim.fn.setline(line_number, vim.fn.substitute(vim.fn.getline(line_number), '^%s*' .. vim.pesc(commentstring), '', ''))
    else
        vim.fn.setline(line_number, commentstring .. vim.fn.getline(line_number))
    end
end


-- Create a normal mode mapping for the "c" key to toggle comments
vim.api.nvim_set_keymap('n', 'c', ':lua toggle_comments()<CR>', { noremap = true, silent = true })

local comment_delimiters = {
    lua = "--",
    python = "#",
    javascript = "//",
    -- Add more filetypes and their respective comment delimiters as needed
}

-- Function to print all contents of a table
local function print_table_contents(tbl)
    for key, value in pairs(tbl) do
        print(key, value)
    end
end


-- Function to reload Neovim configuration
local function reload_neovim()
    -- Reload the init.vim or init.lua file
    vim.cmd('luafile $MYVIMRC')
end
vim.api.nvim_set_keymap('n', '<Leader>rr', ':lua reload_neovim()<CR>', { noremap = true, silent = true })

-- require("~/.config/nvim/lua/kdog3682/locals/grayscale/init.lua")

-- Call the reload_neovim function to restart Neovim

-- reload_neovim()
--




-- Define a function to prompt the user to select an item from a list
function select_item(items)
    local selected_index = vim.ui.select(items)
    print(selected_index)
end

function foo()
     vim.ui.select({ 'tabs', 'spaces' }, {
         prompt = 'Select tabs or spaces:',
     }, function(choice)
         print(choice)
     end)
 end
     -- vim.ui.input({ prompt = 'Enter value for shiftwidth: ' }, function(input)
      --   vim.o.shiftwidth = tonumber(input)
    --  end)
    -- end

vim.api.nvim_set_keymap('n', '<Leader>rx', ':lua select_item({"a", "b", "bb"})<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>r', ':lua foo()<CR>', { noremap = true})

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
    return vim.fn.getline(vim.fn.line('.'))
end
local function add_keymap_and_append()

     vim.ui.input({ prompt = 'Enter key expr you would liek to use: ' }, function(input)
        _add_keymap_and_append(input, getline())
   end)
end
-- Function to add a new keymap if it doesn't exist and append the command to the current file
local function _add_keymap_and_append(key, mapping)
    -- Check if the keymap already exists
    local current_mapping = api.nvim_get_keymap('n', key)

    if not current_mapping then
        -- Keymap doesn't exist, so add it
        api.nvim_set_keymap('n', key, mapping, {noremap = true, silent = true})
        print('Keymap added:', key)
    else
        print('Keymap already exists:', key)
    end

    local mapping = "vim.api.nvim_set_keymap('n', key, mapping, { noremap = true, silent = true })"
    mapping = string.format(mapping, key, mapping)
    -- Append the command associated with the keymap to the current file
    api.nvim_buf_set_lines(0, -1, -1, true, {mapping})
    print('Command appended to file:', mapping)
end


-- require("luasnip.loaders.from_vscode").load({paths = '~/.config/nvim/lua/kdog3682/locals/friendly-snippets'})


-- Map "b" to jump backward in the jump list
vim.cmd('nnoremap <silent> h <C-i>')

-- Map "h" to jump forward in the jump list
vim.cmd('nnoremap <silent> b <C-o>')
--require('/mnt/chromeos/MyFiles/Downloads/snippets.lua')


-- require("kdog3682.luasnip-config")






function abc()
    vim.cmd("source ~/.config/nvim/init.lua")
    print("Reload")
end

if vim.fn.has('nvim-0.8') == 0 then
  error('Need Neovim 0.8+ in order to use this config')
end

for _, cmd in ipairs({ "git", "rg", { "fd", "fdfind" } }) do
  local name = type(cmd) == "string" and cmd or vim.inspect(cmd)
  local commands = type(cmd) == "string" and { cmd } or cmd
  ---@cast commands string[]
  local found = false

  for _, c in ipairs(commands) do
    if vim.fn.executable(c) == 1 then
      name = c
      found = true
    end
  end

  if not found then
    -- asdasdasasd
    error(("`%s` is not installed"):format(name))
  end
end

vim.cmd('autocmd! BufWritePost $MYVIMRC source $MYVIMRC')
vim.g.loaded_python3_provider = 0
vim.o.termguicolors = true
vim.opt.guicursor = "n:block"
-- Load main config
require("config")

local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node

-- Define a new snippet
local snippet = s("example", {
    t("This is an example snippet."),
})

-- Load the snippet
ls.add_snippets("all", {
    snippet,
})
require("config.more-snippets")
local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt

local get_recent_file = function(args)
    return "asdf"
end

local recent_file = s("recent_file", fmt([[
{}
]], {f(get_recent_file, {})}))

ls.add_snippets("all", {
    recent_file,
})

-- Set the background color to white


-- Set the color scheme

-- Override specific highlight groups for black font color
-- vim.api.nvim_set_hl(0, "Normal", { fg = "#000000" })
-- vim.api.nvim_set_hl(0, "NonText", { fg = "#000000" })

vim.cmd("colorscheme catppuccin")

vim.keymap.set({ "i", "s" }, "<C-l>", function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end)
vim.keymap.set({ "i", "s" }, "l", function()
  if ls.choice_active() then
 ls.change_choice(-1)
 end
end)

-- Define a function to source a file
local function source_file(file_path)
    -- Execute the commands in the file using :source
    vim.api.nvim_command('source ' .. file_path)
end

-- Define a custom command to source a file using LeaderF

-- noremap(',sf', 'source_fie')
