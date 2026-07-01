
local Players = game:GetService("Players")
local tool = script.Parent
local handle = tool.Handle
local parameter = RaycastParams.new()
parameter.FilterType = Enum.RaycastFilterType.Exclude
local hitevent = game:GetService("ReplicatedStorage").HitEvent
local coordinate = game:GetService("ReplicatedStorage").CoordEvent
local mouse = Players.LocalPlayer:GetMouse()


tool.Activated:Connect(function()
	
	parameter.FilterDescendantsInstances = {tool.Parent} --setting what we want to exclude from activating ray
	local origin = handle.Position
	local direction = mouse.Hit.LookVector
	local result = workspace:Raycast(origin, direction * 1000, parameter) -- direction is 1 stud length so we mult by 1k for range
	
	if result then
		print("hit", result.Instance.Name, "at position:", result.Position)
		local part = Instance.new("Part")
		part.Size = Vector3.new(0.05, 0.05, result.Distance) --length of ray is from origin to result
		part.Color = Color3.fromRGB(0, 0, 0)
		part.Anchored = true
		part.CanCollide = false
		part.CFrame = CFrame.lookAt(origin, result.Position) * CFrame.new(0, 0, -result.Distance/2) --multiply cframe to override with another cframe, add a vector3 to overr. w v3
		part.Parent = workspace
		--starts at origin and looks at position
		
		local hit = result.Instance
		local char = hit
		while char and not char:FindFirstChild("Humanoid") and char.Parent ~= workspace do --if the thing that got hit isnt a humanoid, keep going up the ancestry until we find a humanoid
			char = char.Parent
		end
		
		if char then
			local hoid = char:FindFirstChild("Humanoid")
			local gothit = Players:GetPlayerFromCharacter(char)
			hitevent:FireServer(hoid, gothit) --fire the event to the server with the info of the humanoid
		end
		task.wait(0.3)
		part:Destroy()
	else
		print("hit nothing")
	end
end)
