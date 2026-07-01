local textchat = game:GetService("TextChatService")
local player = game:GetService("Players")

textchat.OnIncomingMessage = function(msg)
	if not msg.TextSource then
		return
	end
	local props = Instance.new("TextChatMessageProperties")
	local player = player:GetPlayerByUserId(msg.TextSource.UserId)
	local vip = player:GetAttributes("HasVIP")
	local goyim = player:GetAttributes("e")
	
	if goyim then
		props.PrefixText = "[hi] " ..msg.PrefixText
	end
	if vip then
		props.PrefixText = "[VIP] " ..msg.PrefixText
	end
	return props
end
