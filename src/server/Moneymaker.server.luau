local Players = game:GetService("Players")
local clicked = game:GetService("ReplicatedStorage"):WaitForChild("ClickEvent")

task.wait(1)
clicked.OnServerEvent:Connect(function(player)
	print("test")
	local leaderstats = player:FindFirstChild("leaderstats")
	if leaderstats then
		local cash = leaderstats:FindFirstChild("motion")
		if cash then
			cash.Value += 1
		end
	end
end)
