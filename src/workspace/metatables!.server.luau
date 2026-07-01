local myTable = {1, 2, 3}
print(myTable)
local MyMetaTable
MyMetaTable = {
	__sub = function(table, value)
		local result = {} -- the result of the subtraction is a new table
		for i, v in ipairs(table, value) do
			result[i] = v - value --v is the value in table, value is value of the argument thats subtracting
		end
		setmetatable(result, MyMetaTable) -- essentially, result is a new table with the same metatable as the original
		return result
		
	end,
}
MyMetaTable.__index = MyMetaTable -- declare outside because the metatablke is now initialized

setmetatable(myTable, MyMetaTable)

local other = myTable - 3 -- since mytable and metatable are reference e/a, subtracting 3 makes it run the metatable func\
--i think this works because of setmetatable linking them

print(myTable)
table.clear(myTable)
print(other) -- this is the one with the sub function ran

print(myTable["__sub"]) -- searches for this metamethod in metatable
--[[print(other["__sub"]) -- searches for this metamethod in metatable after referenced subtraction
]]
