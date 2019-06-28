Player = Object:extend()
local timer = 0   

function Player:new()

    self.tile_x = math.floor(love.math.random(3,36.9))	
    self.tile_y = math.floor(love.math.random(3,19.9))

    local moves = {'left','down','right','up'}
    self.lastMove = moves[math.floor(love.math.random(1,4.9))]

    self.bodyParts= {
    	{['tile_x'] = self.tile_x, ['tile_y'] = self.tile_y}
    }

    --movement
    tick.recur(function()		
    	local x = self.bodyParts[1]['tile_x']
    	local y = self.bodyParts[1]['tile_y']
		
		if self.lastMove == 'left' then
	    	x = x - 1
		elseif self.lastMove == 'right' then
	    	x = x + 1
	    elseif self.lastMove == 'down' then
    		y = y + 1
    	elseif self.lastMove == 'up' then
	    	y = y - 1
	    end
	    
	    self.bodyParts[1]['tile_y'] = y
	    self.bodyParts[1]['tile_x'] = x
		end, 0.1)


    tick.recur(function()
    	if #self.bodyParts > 1 then
			for i=#self.bodyParts,2,-1 do
				local x = self.bodyParts[i-1]['tile_x']
				local y = self.bodyParts[i-1]['tile_y']

				self.bodyParts[i] = {['tile_x'] = x, ['tile_y'] = y} 	
			end
		end
		end,0.1)
end


function Player:keyPressed(key)
    if love.keyboard.isDown('left') then
        self.lastMove = 'left'
    elseif love.keyboard.isDown('right') then
        self.lastMove = 'right'
    elseif love.keyboard.isDown('up') then
        self.lastMove = 'up'
    elseif love.keyboard.isDown('down') then
        self.lastMove = 'down'
    end
end

function Player:update(dt)
end

-- TO-DO
function Player:checkCollision()
	if self.bodyParts[1]['tile_y'] > 21 or self.bodyParts[1]['tile_y'] < 1 
		or self.bodyParts[1]['tile_x'] > 38 or self.bodyParts[1]['tile_x'] < 1 then
			return true
	end 

end

function Player:ateFood()
	local last = self.bodyParts[#self.bodyParts]
	value = {['tile_x'] = last['tile_x'],['tile_y'] = last['tile_y']}
	table.insert(self.bodyParts, value)
end

function Player:draw()

	love.graphics.setColor(0,167/255,252/255)
	for i, bodies in ipairs(self.bodyParts) do
		love.graphics.rectangle('fill', bodies['tile_x'] * width, 
				bodies['tile_y'] * height, width, height)
		if i == 1 then
			love.graphics.setColor(155,167/255,252/255)
			love.graphics.circle('fill', bodies['tile_x'] * width + width/2, 
				bodies['tile_y'] * height + width/2, width/4, 8)
			love.graphics.setColor(0,167/255,252/255)
		end
	end
	love.graphics.setColor(0,0,0)
	
end