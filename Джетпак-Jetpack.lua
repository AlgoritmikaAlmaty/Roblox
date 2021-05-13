local uis = game:GetService("UserInputService")
local rs = game:GetService("RunService")

local myPlayer = script.Parent.Parent
local myChar = myPlayer
local myHRP = myChar:WaitForChild("HumanoidRootPart")
local camera = game.Workspace.CurrentCamera

local flying = false
local speed = 0.5

local gun = script.Parent
local canFly = true
local forward = false

local bp = Instance.new("BodyPosition", myHRP)
bp.MaxForce = Vector3.new()
bp.D = 10
bp.P = 10000

local bg = Instance.new("BodyGyro", myHRP)
bg.MaxTorque = Vector3.new()
bg.D = 10

function fly()
	flying = true
	bp.MaxForce = Vector3.new(400000,400000,400000)
	bg.MaxTorque = Vector3.new(400000,400000,400000)
	while flying do

		rs.RenderStepped:wait()
		bp.Position = myHRP.Position +((myHRP.Position - camera.CFrame.p).unit * speed)
		bg.CFrame = CFrame.new(camera.CFrame.p, myHRP.Position)

	end
end

function endFlying()
	bp.MaxForce = Vector3.new()
	bg.MaxTorque = Vector3.new()
	flying = false
end

uis.InputBegan:connect(function(input)
	if input.KeyCode == Enum.KeyCode.F then
		if canFly then
			if not flying then
				fly()
			else
				endFlying()
			end
		end

	end
end)

gun.Equipped:Connect(function()
	
	canFly = true
end)

gun.Unequipped:Connect(function()
	canFly = false
	endFlying()
end)
