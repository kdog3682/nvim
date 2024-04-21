local re = {
    func = "^%(local +)?function \\zs(\\w+)"
}
function match(s, r)
     return vim.fn.matchstr(s, "\\v" .. r)
end
function findall(s, r)
     local matches = {}
     function callback(s)
         local a = s[2]
         table.insert(matches, a)
     end
     local regex = "\\v"
     if string.sub(r, 1, 1) == "^" then regex = regex .. "%(^|\n)" .. string.sub(r, 2) 
         else
            regex = regex .. r
     end
     vim.fn.substitute(s, regex, callback, "g")
     return matches
end

-- print(len(findall("hi bye", "%a+")))

function get_function_identifier(s)
    return match(s, re.func)
end

function get_function_identifiers(s)
    local r = re.func
    return findall(s, r)
end
-- print(#get_function_identifiers("local function bar\nlocal function aa"))

function fli(query, opts)
    if not opts then opts = {} end
    local start = opts.start or vim.fn.line('.')
    local dir = opts.dir or -1
    local threshold = opts.threshold or 50
    if opts.dontIncludeStart then start = start + dir end
    local count = 0
    while true do
        local s = vim.fn.getline(start)
        local m = match(s, query)
        if exists(m) then  
            return m
        end
        if start == 0 then return end
        if count > threshold then return end
        start = start + dir
        count = count + 1
    end
end
-- print(#get_function_identifiers("function foo\nlocal function boo"))

local function empty(value)
	if value == "xxxxxs" then
		return true
	elseif value == nil then
		return true
	elseif type(value) == "table" then
		return false
	elseif type(value) == "string" then
		if #value == 0 then
			return true
		end
		return value == ""
	else
		return false
	end
end

function exists(x)
	return not empty(x)
end
-- print(fli(re.func))
-- print(get_function_identifier("local function foo"))
-- print(#get_function_identifiers("function foo bar\nlocal function boo"))


function choose(s)
    for i, item in ipairs(s) do
        print(i, item)
    end
    n = ask("choose a 1 based item index")
    return s[tonumber(n)]
end
function ask(s)
    return vim.fn.input(s)
end

function organizer()
    local nodes = get_top_level_nodes()
    local destinations = glob("~/nvim/lua/kdog3682")
    local base = get_current_buffer()
    local storage = Storage.new()

    function callback(node)
        local t = node:type()
        if t == "function_declaration" then
            local s = get_node_text(node)
            answer = choose(destinations)
            if empty(answer) then
                answer = base
            end
            storage.add(answer, s)
        elseif t == "call" then

        end
    end
    partition(nodes, callback)
end

alphabet = {"foo", "bar"}
-- print(choose(alphabet))

Account = {}
function Account:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    if not self.balance then self.balance = 0 end
    return o
end

function Account:deposit (v)
    self.balance = self.balance + v
end

a = Account:new()
a:deposit(10)
a:deposit(10)
a:deposit(10)
print(a.balance)

