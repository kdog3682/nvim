local nightfox = {}

-- Define the color palette
nightfox.palette = {
  bg = "#1e2030",
  fg = "#c8d1e0",
  red = "#e27878",
  green = "#b4be82",
  yellow = "#e2a478",
  blue = "#78a6e8",
  purple = "#957fb8",
  cyan = "#78d6e8",
  orange = "#e2a985",
  white = "#c8d1e0",
  black = "#1e2030",
  comment = "#7a88cf"
}

local highlight = function(group, color)
  vim.api.nvim_set_hl(0, group, color)
end

highlight("Normal", { fg = nightfox.palette.fg, bg = nightfox.palette.bg })
highlight("Cursor", { fg = nightfox.palette.bg, bg = nightfox.palette.fg })
highlight("CursorLine", { bg = nightfox.palette.black })
highlight("Comment", { fg = nightfox.palette.comment })
highlight("String", { fg = nightfox.palette.green })
highlight("Number", { fg = nightfox.palette.purple })
highlight("Keyword", { fg = nightfox.palette.red })
highlight("Function", { fg = nightfox.palette.yellow })
highlight("Identifier", { fg = nightfox.palette.fg })
highlight("Statement", { fg = nightfox.palette.blue })
highlight("Constant", { fg = nightfox.palette.cyan })
highlight("Type", { fg = nightfox.palette.orange })
highlight("Operator", { fg = nightfox.palette.fg })
highlight("PreProc", { fg = nightfox.palette.purple })

-- Add more highlight groups as needed

-- Set the colorscheme
vim.cmd("hi clear")
if vim.fn.exists("syntax_on") then
  vim.cmd("syntax reset")
end
vim.o.termguicolors = true
vim.g.colors_name = "nightfox"

print("HI")
return nightfox
