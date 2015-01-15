Listener = {}
Listener.__index = Listener

local elements = {}

function Listener.onScrollPositionChanged(args)
	print("Listener.onScrollPositionChanged")
	local window = CEGUI.toWindowEventArgs(args).window
	if elements[window] then
		local value = window:getProperty("ScrollPosition")
		elements[window](value)
	end
end

function Listener.registerEventHandler(window, handler)
	if not window then
		error("Listener.registerEventHandler error, window is nil")
	end
	if type(handler) ~= "function" then
		error("Listener.registerEventHandler error, handler is not a lua function")
	end
	elements[window] = handler
end