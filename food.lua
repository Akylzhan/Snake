Food = Object:extend()

function Food:new()
	self.tile_y = math.floor(love.math.random(1,21))
	self.tile_x = math.floor(love.math.random(1,38))
	self.radius = width/4
end

function Food:update(dt)
	
	if food:checkCollision2() then
		score = score + 1
		player:ateFood()
		self.tile_y = math.floor(love.math.random(1,21)) 
		self.tile_x = math.floor(love.math.random(1,38)) 
	end

end

function Food:checkCollision2()
	if self.tile_x == player.bodyParts[1]['tile_x']
		and self.tile_y == player.bodyParts[1]['tile_y'] then
			return true
	end
end
function Food:draw()
	
	love.graphics.setColor(1,170/255,80/255)
	love.graphics.circle('fill', self.tile_x * width + self.radius*2, 
		self.tile_y * height + self.radius*2, self.radius, 8)
	love.graphics.setColor(0,0,0)

end