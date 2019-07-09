Player = Object:extend()
local timer = 0   

function Player:new()

    self.tile_x = math.floor(love.math.random(4,35.9))	
    self.tile_y = math.floor(love.math.random(4,18.9))

	self.directionQueue = {'right'}

   
    self.bodyParts= {
    	{x = self.tile_x, y = self.tile_y},
    	{x = self.tile_x - 1, y = self.tile_y},
    }

end


function Player:keyPressed(key)
	local n = #self.directionQueue
    if key == 'right'
    and self.directionQueue[n] ~= 'right'
    and self.directionQueue[n] ~= 'left' then
        table.insert(self.directionQueue, 'right')

    elseif key == 'left'
    and self.directionQueue[n] ~= 'left'
    and self.directionQueue[n] ~= 'right' then
        table.insert(self.directionQueue, 'left')

    elseif key == 'up'
    and self.directionQueue[n] ~= 'up'
    and self.directionQueue[n] ~= 'down' then
        table.insert(self.directionQueue, 'up')

    elseif key == 'down'
    and self.directionQueue[n] ~= 'down'
    and self.directionQueue[n] ~= 'up' then
        table.insert(self.directionQueue, 'down')
    end
end


function Player:update(dt)
	timer = timer + dt
    local timerLimit = 0.15
    if timer >= timerLimit then
        timer = timer - timerLimit

        if #self.directionQueue > 1 then
            table.remove(self.directionQueue, 1)
        end

        local nextXPosition = self.bodyParts[1].x
        local nextYPosition = self.bodyParts[1].y

        if self.directionQueue[1] == 'right' then
            nextXPosition = nextXPosition + 1
        elseif self.directionQueue[1] == 'left' then
            nextXPosition = nextXPosition - 1
        elseif self.directionQueue[1] == 'down' then
            nextYPosition = nextYPosition + 1
        elseif self.directionQueue[1] == 'up' then
            nextYPosition = nextYPosition - 1
        end

        table.insert(self.bodyParts, 1, {x = nextXPosition, y = nextYPosition})
        table.remove(self.bodyParts)
    end
end


-- TO-DO
function Player:checkCollision()
	if self.bodyParts[1].y > 21 or self.bodyParts[1].y < 1 
		or self.bodyParts[1].x > 38 or self.bodyParts[1].x < 1 then
			return true
	end

	for i = 2, #self.bodyParts do
		if self.bodyParts[1].y == self.bodyParts[i].y
			and self.bodyParts[1].x == self.bodyParts[i].x
			then
				return true
			end
	end

end

function Player:ateFood()
	local last = self.bodyParts[#self.bodyParts]
	value = {x = last.x, y = last.y}
	table.insert(self.bodyParts, value)
end

function Player:draw()

	love.graphics.setColor(0,167/255,252/255)

	for i, bodies in ipairs(self.bodyParts) do

		love.graphics.rectangle('fill', bodies.x * width, 
				bodies.y * height, width, height)
		if i == 1 then
			love.graphics.setColor(0,0,0)
			love.graphics.rectangle('line', bodies.x * width, 
				bodies.y * height, width, height)
			love.graphics.setColor(0,167/255,252/255)
		end
	end
	
	love.graphics.setColor(0,0,0)
	
end