Listener = {}
Listener.__index = Listener

local elements = {}

function Listener.onScrollPositionChanged(args)
	print("Listener.onScrollPositionChanged")
	local window = CEGUI.toWindowEventArgs(args).window

	if elements[window] then
		local value = window:getProperty("ScrollPosition")
		local unpack = unpack or table.unpack
		local model, key = unpack(elements[window])
		model:setProperty(key, value)
	end
end

function Listener.registerEventHandler(window, model, key)
	if not window then
		error("Listener.registerEventHandler error, window is nil")
	end

	if not model then
		error("Listener.registerEventHandler error, model is nil")
	end

	if not key then
		error("Listener.registerEventHandler error, key is nil")
	end

	elements[window] = { model, key }
end

function Listener.unRegisterEventHandler(window)
	print("Listener.unRegisterEventHandler")

	if not window then
		error("Listener.unRegisterEventHandler error, window is nil")
	end
	
	elements[window] = nil
end
