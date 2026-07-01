local PathfindingService = game:GetService("PathfindingService")
local rig = script.Parent
local humanoid = rig.Humanoid
local goal = workspace.Goal

-- eventaully im gonna make it follow closest player 
local agentparams = { --rules our ai dude follows
	AgentRadius = rig.HumanoidRootPart.Size.X/2, --the possible size the path can be or something
	AgentHeight = 5,
	AgentCanJump = true,
	AgentCanClimb = false,
	WaypointSpacing = 4,   --the smaller number here the more detailed
	Costs = {
		CrackedLava = math.huge, --make it so expensive that ai never walk
		AvoidPart = math.huge
	}
	
}

local path: Path = PathfindingService:CreatePath(agentparams) --the type annotation forces path variable to be a path object
path:ComputeAsync(rig.HumanoidRootPart.Position, goal.Position)

if path.Status == Enum.PathStatus.Success then
	print(path.Status)
	for _, point in path:GetWaypoints() do -- for each point in the path
		local part = Instance.new("Part")
		part.Shape = Enum.PartType.Ball
		part.Size = Vector3.new(1,1,1)
		part.Material = Enum.Material.Neon
		part.CanCollide = false
		part.Anchored = true
		part.Position = point.Position
		part.Parent = workspace
	end
	for _, point: PathWaypoint in path:GetWaypoints() do
		humanoid:MoveTo(point.Position)
		if point.Action == Enum.PathWaypointAction.Jump then
			humanoid.Jump = true
		end
		humanoid.MoveToFinished:Wait()
	end
else
	warn("Path failed", path.Status)
end
