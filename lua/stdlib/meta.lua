local M = {}
local function iterate_over_mappings(callback, mode)
  mode = mode or "n"
  local mappings = vim.api.nvim_get_keymap(mode)

  for _, mapping in ipairs(mappings) do
    callback(mapping)
  end
end
function test(s, r)
    return string.match(s, r) ~= nil
end

local function printTable(tbl)
    for key, value in ipairs(tbl) do
        print(key, value)
    end
end
local function joinTable(tbl)
    local list = {}
    for _, value in ipairs(tbl) do
        table.insert(list, tostring(value))
    end
    return print(table.concat(list, "|"))
end


local function remove_bracket_mappings(mode)
    local function callback(mapping)
        lhs = mapping.lhs
        local pattern = "^[[%]{}]%%"
        if test(lhs, pattern) then
            vim.api.nvim_del_keymap('n', lhs)
        end
    end
    iterate_over_mappings(callback)
end
local function view_mappings(mode)
    iterate_over_mappings(joinTable)
end

M.test = test
M.remove_bracket_mappings = remove_bracket_mappings
M.view_mappings = view_mappings

return M







