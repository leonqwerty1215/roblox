







--[[
game.Workspace.AttributePart:GetAttributeChangedSignal("hello"):Connect(function()
	print("hello att ch")
end)

while true do
	game.Workspace.AttributePart:SetAttribute("hello", true)
	task.wait(0.5)
	game.Workspace.AttributePart:SetAttribute("hello", false)
end





--[[game.Workspace.AttributePart.AttributeChanged:Connect(function(attribute)
	print(attribute)
end)


game.Workspace.AttributePart:SetAttribute("alsdfjkh", true)



--[[game.Workspace.AttributePart:SetAttribute("hello", true) --you can set the value to nil to delete

print(game.Workspace.AttributePart:GetAttribute("hello"))
task.wait(1)
print(game.Workspace.AttributePart:GetAttributes()) --no need to specify because it gets all of them]]
