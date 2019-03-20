
local _M = {}

_M.AppBase  = import(".AppBase")
_M.ViewBase = import(".ViewBase")
_M.test = {
	testA = require("packages.mvc.test.testA"),	
} 

return _M
