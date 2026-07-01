local button = script.Parent

button.MouseButton1Click:Connect(function()

		local playergui = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
	playergui.ScreenGui2.TextLabel.Visible = not playergui.ScreenGui2.TextLabel.Visible

end)
