--- Utility functions for functional programming.
local M = {}


--- Apply a function to successive tuples of list elements.
---
--- For every list take the first element each, apply the function to those
--- elements and add the result to the final result. The final result will be a
--- list of all the individual results. Terminates as soon as one of the lists
--- is exhausted.
---
--- @param f function
---   Function to apply, arity should math the number of lists.
--- @param ...
---   The lists to map over.
---
--- @return table
---   A list of mapping results. The order is preserved. The items are copied
---   shallowly.
function M.map(f, ...)
	local lists = {...}
	local result = {}

	for i = 1, math.huge do
		local args = {}
		for _, list in ipairs(lists) do
			local arg = list[i]
			if arg == nil then
				goto finish
			end
			args[#args+1] = arg
		end
		result[i] = f(unpack(args))
	end

::finish::
	return result
end

-- Apply `f` to each element of `items` in order, mutating the contents of
-- `items` in-place.
function M.imap(f, items)
	for i, item in ipairs(items) do
		items[i] = f(item)
	end
	return items
end

---	Filter a list based on a predicate, only keep items matching the predicate.
--
-- @param p
--   The predicate function.
-- @param items
--   The list to filter.
--
-- @return
--   A new list containing only the items for which the predicate returns true.
--   Performs a shallow assignment of items.
function M.filter(p, items)
	local result = {}
	for _, item in ipairs(items) do
		if p(item) then result[#result+1] = item end
	end
	return result
end

--- Perform a left-folding on the elements of a list.
function M.reduce(f, initial, items)
	local result = initial
	for _, item in ipairs(items) do result = f(result, item) end
	return result
end

--- Compose sever several functions into one function by successive
--- application.
---
--- @param ...
---   The functions to compose.
---
--- @return function
---   A new function which applies any number of arguments to the first
---   component, then passes its results to the second component, and so on
---   until the last component. The final result of the call chain is returned.
function M.compose(...)
	local fs = {...}
	return function(...)
		local results = {...}
		for _, f in ipairs(fs) do results = {f(unpack(results))} end
		return unpack(results)
	end
end

--- Curries a function into a function of one argument which returns another
--- function.
---
--- @param f function
---   The function to curry
---
--- @return function
---   A new function of any amount of arguments; the arguments are the first
---   arguments to the curried function. Consider the function `f: (x, y,
---   z) -> - w`, its curried form is a function `c(f): (x) -> ((y, z) ->
---   f(x, y, z))`.
---
---   Thus `f(x, y, z)` = c(f)(x)(y, z) = c(c(f)(x))(y)(z) = w`.
function M.curry(f)
	return function(...)
		local xs = {...}
		return function(...) return f(unpack(xs), ...) end
	end
end


-------------------------------------------------------------------------------
return M
