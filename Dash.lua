local UserInputService = game:GetService("UserInputService")
local player = game.Players.LocalPlayer



local key = Enum.KeyCode.F -- Клавиша, по нажатию которой вы будете совершать дэш
local velocity = 24000 -- Сила дэша
local cooldown = 0 -- Перезарядка 
local duration = 0.3 -- Длительность дэша


local debounce = false 


--

local function Dash()
	local character = player.Character
	if character and not debounce then
		debounce = true

		local humanoid = character.Humanoid
		local HRP = character.HumanoidRootPart 


		local dashDirection = nil
		local moveDirection = humanoid.MoveDirection
		local lookVector = HRP.CFrame.LookVector
		local minusVelocity = -velocity 

		local isOnGround = true
		if isOnGround then


			if moveDirection == Vector3.new(0,0,0) then
				dashDirection = HRP.Position + Vector3.new(lookVector.X, 0, lookVector.Z)
			else 
				dashDirection = HRP.Position + Vector3.new(moveDirection.X, 0, moveDirection.Z)
			end

			local bodyGyro = Instance.new("BodyGyro")
			bodyGyro.Parent = HRP
			bodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
			bodyGyro.D = 0 
			bodyGyro.P = 500000 
			bodyGyro.CFrame = CFrame.lookAt(HRP.Position, dashDirection)

			local attachment = Instance.new("Attachment")
			attachment.Parent = HRP

			local vectorForce = Instance.new("VectorForce")
			vectorForce.Parent = HRP
			
			vectorForce.Attachment0 = attachment
			vectorForce.Force = Vector3.new(0,0,minusVelocity) 
			
			humanoid.AutoRotate = false 
			
			

			wait(duration)
			
			vectorForce.Force = Vector3.new(0,0,0)
			
			wait(0.1)
			humanoid.AutoRotate = true

			vectorForce:Destroy()
			bodyGyro:Destroy()
			attachment:Destroy()

			
			
		end

		wait(cooldown)
		debounce = false
	end
end

UserInputService.InputBegan:Connect(function(input)
	if input.KeyCode == key then
		Dash()
	end
end)
