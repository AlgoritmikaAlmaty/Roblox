local parent = script.Parent
local isReady = true
local waitTime = 2 -- Задержка между следующим изменением размера
local value = 0.5 -- Значение изменения размера (меньше 1 для уменьшения)
local isOnce = true -- Поставьте false, если хотите бесконечно менять размер

-- Всё что ниже, не менять!
parent.Touched:Connect(function(hit)
	if isReady == false then
		return nil
	end
	if isOnce then
		if hit.Parent:FindFirstChild("Humanoid").HeadScale.Value == value then
			return nil
		end
	end

	isReady = false
	local Humanoid = hit.Parent:FindFirstChild("Humanoid")
	if Humanoid then
		local HS = Humanoid.HeadScale
		local BDS = Humanoid.BodyDepthScale
		local BWS = Humanoid.BodyWidthScale
		local BHS = Humanoid.BodyHeightScale

		HS.Value = HS.Value * value
		BDS.Value = BDS.Value * value
		BWS.Value = BWS.Value * value
		BHS.Value = BHS.Value * value
		print(HS.Value)
	end
	wait(waitTime)
	isReady = true
end)
