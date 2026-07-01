local part = script.Parent

part.Touched:Connect(function(other)
	local humanoid = other.Parent:FindFirstChild("Humanoid")
	if humanoid then
		humanoid.Health = 0
	end
end)
