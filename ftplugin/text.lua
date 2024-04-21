-- eliminate sources for text files
-- no completion
local cmp = require('cmp')
cmp.setup.buffer({ sources = {} })
