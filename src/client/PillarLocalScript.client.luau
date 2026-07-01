local event = game.ReplicatedStorage:WaitForChild("PillarEvent")
local coordinate = game.ReplicatedStorage:WaitForChild("CoordEvent")
--so this is gonna be userinput exampesl

local hello = game:GetService("ContextActionService") -- get service
local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local function FindMousePosition(actionName: IntValue, inputState: Enum.UserInputState, inputObject: InputObject)
	if inputState == Enum.UserInputState.Begin then
		--[[local mouse = inputObject.Position
		local mouseX = mouse.X
		local mouseY = mouse.Y
		local mouseZ = mouse.Z
	
	]]
		local x = mouse.Hit.X
		local y = mouse.Hit.Y
		local z = mouse.Hit.Z
		
		event:FireServer(x, y, z)
	end
end

hello:BindAction("FindMousePosition", FindMousePosition, false, Enum.KeyCode.F)
