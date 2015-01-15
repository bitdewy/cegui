require("Echo.Listener")
local Utils = require("Echo.Utils")
local Event = require("Echo.Event")

local _M = {}
_M.__index = _M

function _M.dataContext(window)
	if not window then
		error("Binding.dataContext error, window is nil")
	end
	local window = window
	while window do
		if window:isUserStringDefined("DataContext") then
			return require(window:getUserString("DataContext"))
		end
		window = window:getParent()
	end
	error("not found UserString DataContext")
end

function _M.bindProperties(window)
	if not window then
		error("Binding.bindProperties error, window is nil")
	end
	if window:isUserStringDefined("Binding") then
		local value = Utils.splitString(window:getUserString("Binding"), " ")
		local model = _M.dataContext(window)
		local modelKey = value[2]
		local windowProperty = value[1]
		local event = Event[value[1]]
		model:subscribeEvent(modelKey, function(args) window:setProperty(windowProperty, args) end)
		if event and not window:isEventPresent(event) then
			window:subscribeEvent(event, "Listener.on"..event)
			Listener.registerEventHandler(window, function(args) model:setProperty(modelKey, args) end)
		end
	end

	for i = 0, window:getChildCount() - 1 do
		local window = window:getChildAtIdx(i)
		_M.bindProperties(window)
	end
end

function windowLayoutLoadedHandler(args)
	local root = CEGUI.toWindowEventArgs(args).window
	_M.bindProperties(root)
end
