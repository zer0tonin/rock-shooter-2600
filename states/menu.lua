local menu = {}
local Gamestate = require "hump.gamestate"
local game = require "states.game"

local font
local r = 0
local direction = true
local ship = {}

function menu:enter()
    font = love.graphics.newFont("assets/Squareo.ttf", 25)
    love.graphics.setFont(font)

    ship.image = love.graphics.newImage("assets/ship.png")
    ship.x = 0
    ship.direction = true
end

-- make the title rotate a bit
function menu:update()

    if (r < 0.05 and direction == true) then
        r = r + 0.00005
    elseif (r >= 0.05 and direction == true) then
        direction = false
    elseif (r > -0.05 and direction == false) then
        r = r - 0.00005
    elseif (r <= -0.05 and direction == false) then
        direction = true
    end

    if (ship.x < 900 and ship.direction == true) then
        ship.x = ship.x + 0.2
    elseif (ship.x >= 900 and ship.direction == true) then
        ship.direction = false
    elseif (ship.x > -100 and ship.direction == false) then
        ship.x = ship.x - 0.2
    elseif (ship.x <= -100 and ship.direction == false) then
        ship.direction = true
    end

end

function menu:draw()
    love.graphics.print("Rock Shooter2600", 250, 200, r, 3, 3, 50, 25)
    love.graphics.print("Play", 350, 300, 0, 2, 2)

    if(ship.direction) then
        love.graphics.draw(ship.image, ship.x, 450, 1.57)
    else
        love.graphics.draw(ship.image, ship.x, 450, -1.57)
    end
end

function menu:mousepressed(x, y, button)
    if (button == "l") then
        if(x >= 350 and y >= 300 and x < 500 and y < 350) then
            Gamestate.switch(game)
        end
    end
end

return menu
