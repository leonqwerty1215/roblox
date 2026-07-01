local part = script.Parent

part:SetAttribute("TouchedAmount", 0)
part.Touched:Connect(function()
	local touchamount = part:GetAttribute("TouchedAmount") or 0
	touchamount +=1
	part:SetAttribute("TouchedAmount", touchamount)
end)

while true do
	task.wait(2)
	print(part:GetAttribute("TouchedAmount"))
end
