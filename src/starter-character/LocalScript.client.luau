local storage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local event = storage.BetterTween.PlayTween

event.OnClientEvent:Connect(function(instance, tweendata, goal)
	print(instance, tweendata, goal)
	local tweenInfo = TweenInfo.new(table.unpack(tweendata))
	if not instance then
		-- instance not yet replicated to client
		return
	end
	local hih = TweenService:Create(instance, tweenInfo, goal)
	hih:Play()
	
end)
