local _M = {}
_M.__index = _M

function _M.splitString(str, pat)
	local t = {}  -- NOTE: use {n = 0} in Lua-5.0
	local fpat = "(.-)" .. pat
	local last = 1
	local s, e, cap = str:find(fpat, 1)
	while s do
		if s ~= 1 or cap ~= "" then
			table.insert(t, cap)
		end
		last = e + 1
		s, e, cap = str:find(fpat, last)
	end
	if last <= #str then
		cap = str:sub(last)
		table.insert(t, cap)
	end
	return t
end

return _M