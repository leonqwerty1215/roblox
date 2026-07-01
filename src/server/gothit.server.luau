local player = game:GetService("Players")
local hitevent = game:GetService("ReplicatedStorage").HitEvent
hitevent.OnServerEvent:Connect(function(player, hoid)
	if hoid then
		print("weshotthem")
		hoid:TakeDamage(100)
	end
end) --i think i gotta use this with real players
