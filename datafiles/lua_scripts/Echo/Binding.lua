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
		local key = value[2]
		local property = value[1]
		local event = Event[value[1]]
		model:subscribeEvent(key, window, property)

		if event then
			window:subscribeEvent(event, "Listener.on"..event)
			Listener.registerEventHandler(window, model, key)
		end
	end

	for i = 0, window:getChildCount() - 1 do
		local window = window:getChildAtIdx(i)
		_M.bindProperties(window)
	end
end

function onWindowLayoutLoaded(args)
	local root = CEGUI.toWindowEventArgs(args).window
	_M.bindProperties(root)
end

function onWindowDestroyed(args)
	local err, msg = pcall(function()
		local window = CEGUI.toWindowEventArgs(args).window
		Listener.unRegisterEventHandler(window)
	end)
	
	if err then
		print(msg)
	end
end
