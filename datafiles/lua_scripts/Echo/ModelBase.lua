local _M = {}
_M.__index = _M

function _M:_init(init)
	local self = setmetatable({}, _M)
	self.value = init
	self.event = {}
	return self
end

function _M:subscribeEvent(name, action)
	if not name then
		error("ModelBase.subscribeEvent error, name is nil")
	end
	if type(action) ~= "function" then
		error("ModelBase.subscribeEvent error, action is not a lua function")
	end
	self.event[name] = action
end

function _M:setProperty(name, value)
	if not self.value then
		error("not initialize")
	end

	if not self.value[name] then
		error("no property" .. name)
	end

	if self.value[name] ~= value then
		print("property: "..name.." value: "..value)
		self.value[name] = value

		if self.event[name] then
			self.event[name](value)
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
