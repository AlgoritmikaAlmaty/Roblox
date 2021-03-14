local StartPoint = script.Parent
local EndPoint = script.Parent.Parent.TP1 
--После script.Parent.Parent. 
--поставьте название блока, к которому телепортируемся

--Оба блока должны быть в одной папке (или в workspace)

function TouchedFunc(touched)
	if touched.Parent:FindFirstChild("Humanoid") then
		local human = touched.Parent.HumanoidRootPart
		human.Position = EndPoint.Position + Vector3.new(0,10,0)
	end
end
StartPoint.Touched:Connect(TouchedFunc)
