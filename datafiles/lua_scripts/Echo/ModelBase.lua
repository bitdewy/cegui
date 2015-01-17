local _M = {}
_M.__index = _M

function _M:_init(init)
	local self = setmetatable({}, _M)
	self.value = init
	self.event = {}
	self.removed = {}
	return self
end

function _M:subscribeEvent(name, window, property)
	if not name then
		error("ModelBase.subscribeEvent error, name is nil")
	end

	if not window then
		error("ModelBase.subscribeEvent error, window is nil")
	end

	if not property then
		error("ModelBase.subscribeEvent error, property is nil")
	end
	if not self.event[name] then
		self.event[name] = {}
	end
	table.insert(self.event[name], { window, property })
end

function _M:unSubscribeEvent(window)
	if not window then
		error("ModelBase.unSubscribeEvent error, window is nil")
	end
	self.removed[window] = true
end

function _M:setProperty(name, value)
	if not self.value then
		error("not initialize")
	end

	if not self.value[name] then
		error("no property" .. name)
	end

	if self.value[name] == value then
		return
	end

	print("property: "..name.." value: "..value)
	self.value[name] = value

	if not self.event[name] then
		print("no "..name.." changed event bind.")	
	end

	local unpack = unpack or table.unpack
	for i, v in ipairs(self.event[name]) do
		local window, property = unpack(v)
		if not self.removed[window] and window:getProperty(property) ~= value then
			window:setProperty(property, value)
		end
	end
end

function _M:getProperty(name)
	if not self.value then
		error("not initialize")
	end

	if not self.value[name] then
		error("no property" .. name)
	end

	return self.value[name]
end

return _M
