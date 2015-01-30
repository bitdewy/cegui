local _M = {}
_M.__index = _M

local function parseWindow(window, table)
	for i = 0, window:getChildCount() - 1 do
		local wnd = window:getChildAtIdx(i)
		if wnd:isUserStringDefined("WindowName") then
			local name = wnd:getUserString("WindowName")
			if wnd:isUserStringDefined("DownCast") then
				local func = wnd:getUserString("DownCast")
				table[name] = CEGUI[func](wnd)
			else
				table[name] = wnd
			end
		end
		parseWindow(wnd, table)
	end
	return table
end

function _M.loadLayout(layout)
	if not layout then
		error("layout must not be nil")
	end

	if type(layout) ~= "string" then
		error("layout must be String type")
	end

	local windows = {}
	local winMgr = CEGUI.WindowManager:getSingleton()
	windows.root = winMgr:loadLayoutFromFile(layout)

	return parseWindow(windows.root, windows)
end

return _M