love.graphics.setBackgroundColor(88/255,88/255,88/255)

Object = require 'classic'
tick = require 'tick'
require 'player'
require 'food'

function love.load()

	counter = 797
	width = 32
	height = 32
	score = 0
	
	food = Food()
	player = Player()

end


function love.keypressed(key)
	player:keyPressed(key)
end

function love.update(dt)
	tick.update(dt)
	player:update(dt)
	food:update(dt)
	-- collision with borders
	if player:checkCollision() then
		love.load()
	end
end

function love.draw()
	--map draw
	love.graphics.setColor(255/255,116/255,177/255)
	
	--draw horizontal borders
	love.graphics.rectangle('fill',0, 0, 40*width, height)
	love.graphics.rectangle('fill',0, 22*height, 40*width, height)
	--draw vertical borders
	love.graphics.rectangle('fill',0, height, width, 21*height)
	love.graphics.rectangle('fill',39*width, height, width, 21*height)
	love.graphics.setColor(0,0,0)
	--
	--
	food:draw()
	player:draw()
	love.graphics.print('Score: ' .. tostring(score), 10, 10)
end