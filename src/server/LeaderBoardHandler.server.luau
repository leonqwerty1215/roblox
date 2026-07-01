
local Players = game:GetService("Players")
local Data = game:GetService("DataStoreService")
local ordered = Data:GetOrderedDataStore("PlayerMoney") --data in other datastore wont be available here because this is a new one
local errored = {}
-- references to services

local function getmoneydata(player) -- loads player data
	if player.UserId < 1 then
		warn("asdflkajsdfkl;j")
		return 0
	end
	print("[LOAD] Attempting to load data for:", player.Name, player.UserId)
	local success, result = pcall(function()
		--protected call so if roblox dies its fine
		return ordered:GetAsync(player.UserId) --get async gets data
		
	end)
	if success then
		print("[LOAD] Success! Loaded value:", result)
		--[[if result >= 1000 then
			Players:SetAttribute("HasVIP", true)
			Players:SetAttribute("e", false) --elite
		end
		if result < 1000 then
			Players:SetAttribute("e", true)
			Players:SetAttributes("HasVIP", false)
		end]]
	
	
		if not result then
			result = 0
			print("[LOAD] No data found, defaulting to 0") 
		end
		
		return result
	end
	warn("[LOAD] FAILED for player:", player.UserId, "Error:", result) --if the above if statement is "success", then this part which is out of the if statement is not success
	errored[player.UserId] = true
	return 0
	
end


local function savemoneyfor(player, amt)
	if player.UserId < 1 then
		warn("cant save data for temp player")
			
	end
	if errored[player.UserId] then -- if player is in errored table then it doesnt save
		warn("cannot save data for erroredd")
		return
	end
	print("[SAVE] Attempting to save", amt, "for", player.Name)
	local success, err = pcall(function()
		ordered:UpdateAsync(player.UserId, function(olddata) -- olddata is set to new amount then returned and the cycle repeats, so if u get errored u dont lose everything
			olddata = amt
			return olddata
		end)
	end)
	
	if success then
		print("[SAVE] Success! Saved", amt, "for", player.Name)
	else
		warn("[SAVE] FAILED for player:", player.UserId, "Error:", err)
	end
end

local function saveforall() --no paramater here because all is all
	for _, player in Players:GetPlayers() do
		task.spawn(function()
			savemoneyfor(player, player.leaderstats.motion.Value)
		end)
	end
end

local function topmoney()
	local success, result = pcall(function() 
		return ordered:GetSortedAsync(false, 5)
	end)
	if not success then
		warn("Failed to fetch top players") 
		return
	end
	local top5 = result:GetCurrentPage()
	return top5
end

local function setboard(player) -- creates leaderstats and motion
	local leaderstats = Instance.new("Folder")
	leaderstats.Name = "leaderstats"
	leaderstats.Parent = player	
	
	local money = Instance.new("NumberValue")
	money.Name = "motion"
	money.Value = getmoneydata(player) --uses getmoneydata function to retrieve player money
	money.Parent = leaderstats
end

Players.PlayerAdded:Connect(function(player) -- when player joins
	setboard(player)
end)

Players.PlayerRemoving:Connect(function(player) --when player leaves
	local leaderstats = player:FindFirstChild("leaderstats")
	if leaderstats then
		local motion = leaderstats:FindFirstChild("motion")
		if motion then
			savemoneyfor(player, motion.Value)
		end
	end
end)

-- save all player data when the server shuts down
game:BindToClose(function()
	for _, player in Players:GetPlayers() do
		local leaderstats = player:FindFirstChild("leaderstats")
		if leaderstats then
			local motion = leaderstats:FindFirstChild("motion")
			if motion then
				savemoneyfor(player, motion.Value)
			end
		end
	end
end)

for _, player in Players:GetPlayers() do
	setboard(player)
end
-- i v pairs but we dont care about index, so basically for every player it makes the thing so everyone in server can see

-- dw index i care abt u <3

while true do
	task.wait(300)
	saveforall()
end

task.wait(5)
local result = topmoney()
for rank, data in result do --in ordered data stores the variables rank and data are predefined
	print(data.key, "is rank", rank, "with", data.value) --key is the players user, value is the value of their points
end --for some reason it doesnt work, proably same reason why setting my money through xplorer didnt activate datastoire; i would have to join the live game to properly test but i gotta do some survey and i dont wanna

while true do
	task.wait(3)
	for _, player in Players:Getplayers() do
		local leaderstats  = player:FindFirstChild("leaderstats")
		if leaderstats then
			local motion = leaderstats:FindFirstChild("motion")
			if motion < 1000 then
				Players:SetAttribute("e", true)
				Players:SetAttribute("HasVIP", false)
			end
			if motion >= 1000 then
			Players:SetAttribute("e", false)
			Players:SetAttribute("HasVIP", true)
			end
		end
	end
end
