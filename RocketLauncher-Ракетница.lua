-- У ракеты поставьте CanCollide = false, если она взрывается сразу, после взрыва
Gun = script.Parent
Bomb = Gun.Bomb

--При запуске игры появляется ещё одна зелёная ракета
--Ракетница будет стрелять из зелёной ракеты в сторону основной (на ракетнице)

rocket_speed = 150 -- Определяет скорость ракеты
explosion_delay = 0.2 -- Определяет задержку взрыва ракеты
--чем выше скорость, тем меньше должна быть задержка, может быть xD

prevBomb = Bomb:Clone()
prevBomb.Parent = Gun
prevBomb.BrickColor = BrickColor.new("Lime green")
prevBomb.Position = Bomb.Position - Vector3.new(0,0,-1) 

--Координаты сверху отвечают за спавн зелёной ракеты
--Поставьте -1/1 только в одной из координат, если зелёная ракета появляется не там, где надо


reload = false
function bam()
	if reload == false then
		reload = true
		local Bullet = Bomb:Clone()
		Bullet.Position = Bomb.Position
		Bullet.CanCollide = true
		Bullet.Parent = Gun
		Bullet.Name = "BombFired"

		local Thrust = Instance.new('BodyThrust', Bullet)
		Bullet.WeldConstraint:Destroy()
		Instance.new('Fire',Bullet)
		Bullet.BrickColor = BrickColor.Red()

		local velocity = Instance.new('BodyVelocity')
		velocity.Parent = Bullet
		velocity.Velocity =  (Bomb.Position - prevBomb.Position) * rocket_speed
		velocity.MaxForce = Vector3.new('inf','inf', 'inf')
		wait(explosion_delay)
		Bullet.Touched:Connect(function(hit)
			if hit ~= Bomb and hit ~= Gun then 
				local explosion = Instance.new('Explosion')
				explosion.Parent = workspace
				explosion.Position = Bullet.Position
				Bullet:Destroy()
			end
		end)

		wait(2)
		if Bullet ~= nil then
			Bullet:Destroy()
		end
		reload = false
	end
end
Gun.Activated:Connect(bam)
