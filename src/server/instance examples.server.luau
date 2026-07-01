local collectionservice = game:GetService("CollectionService")

local v = collectionservice:GetTagged("example")
local connections = {} --set a table that tracks all things with the tag

local function touch(other)
	local humanoid = other.Parent:FindFirstChildWhichIsA("Humanoid")
	if humanoid then
		humanoid.Health = 0
	end
end --killbrick script

for _, brick in v do
	connections[brick] = brick.Touched:Connect(touch)
	
end --for every brick with the tag connect to the touch function

collectionservice:GetInstanceAddedSignal("example").Connect(function(brick)
	brick.Touched:Connect(touch)
end) --new killbricks also do it
collectionservice:GetInstanceRemovedSignal("example").Connect(function(brick)
	if connections[brick] then
	connections[brick]:Disconnect()
	connections[brick] = nil
end
end) --when we remove the tag, we disconnect the function
