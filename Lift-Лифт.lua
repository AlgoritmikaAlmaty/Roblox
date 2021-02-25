local motor = script.Parent.Parent
local upperPos = script.Parent.Position.Y - motor.Position.Y

local UP = false
local isReady = true

local waitTime = upperPos * 0.053 + 3

local touch = false

script.Parent.TouchEnded:Connect(function(hit)
	touch = false
end)

script.Parent.Touched:Connect(function(hit) -- GoUp
	touch = true
	if isReady == false or not hit.Parent:FindFirstChild("Humanoid") then
		return nil
	end
	
	isReady = false
	
	wait(2)
	
	if touch == false then
		isReady = true
		return nil
	end
	
	if UP == false then
		
		motor.CylindricalConstraint.TargetPosition = upperPos
		UP = true
		wait(waitTime)
		isReady = true
	else
		
		motor.CylindricalConstraint.TargetPosition = 0
		UP = false
		wait(waitTime)
		isReady = true
	end
	
	
	
end)
motor.Touched:Connect(function(hit) -- GoDown
	if isReady == false or not hit.Parent:FindFirstChild("Humanoid")  then
		return nil
	end

	if UP == true then
		isReady = false
		motor.CylindricalConstraint.TargetPosition = 0
		UP = false
		wait(waitTime)
		isReady = true
	end

end)
