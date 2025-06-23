-- set <space> as the leader key
-- see ':help mapleader' NOTE
-- Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- runs mason in a virtual enviroment
vim.g.python3_host_prog = "~/.venvs/mason/bin/python"

------- import the options -----------
require("kaleb.core")

require("kaleb.lazy")
