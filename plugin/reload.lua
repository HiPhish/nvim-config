---Given an existing old table and a new one, make the two tables equal by
---value.  The old table will contain exactly the same keys as the new table.
---The subversion runs deeply, i.e. if the old table contains a table that
---table will not be replaced by also subverted."
---
---@param old table The old table
---@param new table The new table
---@return table old  The reloaded old table.
local function reload_table(old, new)
	-- Drop keys that don't exist in the new table
	for k in pairs(old) do
		if new[k] == nil then
			old[k] = nil
		end
	end

	for k, v in pairs(new) do
		if type(v) == 'table' then reload_table(old[k], v) end
		old[k] = v
	end

	return old
end

---Reload a Lua module and return the result.  Does not reload a Lua script
---file.
---
---@param modname string  Name of the module
---@return any module  The reloaded module
function reload(modname)
	local old = require(modname)
	package.loaded[modname] = nil
	local success, new = pcall(require, modname)

	if success then
		if type(new) == 'table' then
			reload_table(old, new)
		end
	end

	package.loaded[modname] = old
	return old
end
