-- this will be our tween for making a pillar pop up on click
local BetterTween = require(game:GetService("ReplicatedStorage").BetterTween)
local pillar = script.Parent
local event = game.ReplicatedStorage:WaitForChild("PillarEvent")
local tagservice = game:GetService("CollectionService")
local ActivePillars = {}

event.OnServerEvent:Connect(function(player, x, y, z) --player is first parameter always, the x value will return player name if the player parameter is missing
	print("reciieed")
	print(x, y, z)
end) --test if function properly passed from local to this script

event.OnServerEvent:Connect(function(player, x, y, z)
	
	
	pillar.Material = "Neon" 
	local tweenInfo = TweenInfo.new(2) -- make the tween now that we know it can work, the 2 = 2 seconds it will take to go from start to goal
	local sizey = pillar.Size + Vector3.new(0, 50, 0) --pillar will go from default to 50 studs taller
	local NewPillar = Instance.new("Part")
	NewPillar.Name = "NewPillar"
	NewPillar.Parent = game.Workspace
	NewPillar.Position = Vector3.new(x, y, z)
	NewPillar.Material = "Neon"
	NewPillar.Anchored = true
	local goal = {
		Size = sizey
	}

	BetterTween:Tween(NewPillar, tweenInfo, goal)
	local tag = "pillar"
	tagservice:AddTag(NewPillar, tag)
	local tagged = tagservice:GetTagged(tag) --get all tagged items
	local function touch(other)
		local humanoid = other.Parent:FindFirstChildWhichIsA("Humanoid")
		if humanoid then
			humanoid.Health = 0
		end
		
	end
	for _, pillar in tagged do
		ActivePillars[pillar] = pillar.Touched:Connect(touch)
	end --for every pillar with the tag connect to the touch function
	
	task.wait(3)
	if tagservice:GetInstanceRemovedSignal(tag) then
		ActivePillars[pillar] = nil
	end
	tagservice:RemoveTag(NewPillar, tag) --remove tag after 3 seconds
	BetterTween:Tween(NewPillar, tweenInfo, {Size = Vector3.new(0, 0, 0)})
	NewPillar:Destroy()
	
	
end)
