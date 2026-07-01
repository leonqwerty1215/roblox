local BetterTween = {}
local event = script.PlayTween

function BetterTween:Tween(instance, tweenInfo: TweenInfo, goal)
	local tweendata = {
		tweenInfo.Time,
		tweenInfo.EasingStyle,
		tweenInfo.EasingDirection,
		tweenInfo.RepeatCount,
		tweenInfo.Reverses,
		tweenInfo.DelayTime
		
		
	}
	TweenInfo.new()
	event:FireAllClients(instance, tweendata, goal)
end
return BetterTween
