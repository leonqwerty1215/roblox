local function repeats(word)
	local repeated = ""
	while true do
		repeated = repeated..word
		coroutine.yield(repeated)
	end
end

local thread = coroutine.create(repeats)
print(coroutine.resume(thread, "es")) 
for i = 1, 50 do
	print(coroutine.resume(thread)) -- no need for the word argument because already has it
end






--[[local hi = coroutine.wrap(function()
	error("error") 
	return "bob"
end)
--whjen this is run without an error, it doesnt give true boolean because its not protectedd
print(hi())




--[[local current = coroutine.running()


local wrapped = coroutine.wrap(function() the wrapped is NOT protected from errors because it just returns function
	task.wait(3)
	coroutine.resume(current, "hi ")
end)
wrapped()

local message = coroutine.yield()

print("coroutine was resumesd: ", message)














--[[local thread = coroutine.create(function()
	for i = 1, 5 do
		coroutine.yield(i)
	end
	return "Finished"
end)

repeat 
	print(coroutine.status(thread))
	print(coroutine.resume(thread)) 
until coroutine.status(thread) == "dead"

print("coroutine is dead because the for loop finished so its purpose is served")




--[[local thread = coroutine.create(function() -- creates coroutine
	while true do
		print("while loop doing stuff")
		task.wait()
	end
end)
coroutine.resume(thread) -- tells the coroutine to run
print("SIXZ SEVN")


-- 4 statses
-- suspended - right when its created
-- running - when its running
-- dead - when it ends
-- normal - when its not suspended or running]]
