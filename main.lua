local Ship = require "ship"
local Asteroid = require "asteroid"

function love.load()
    player = Ship:new(love.graphics.newImage("assets/ship.png"))
    asteroids = {}
    asteroids[1] = Asteroid:new(love.graphics.newImage("assets/asteroid50.png"), 100, 100, 50)
end

function love.update(dt)
    --moves the player around
    if love.keyboard.isDown("right") or love.keyboard.isDown("d") then
        player:move(player.speed * dt, 0)
    end
    if love.keyboard.isDown("left") or love.keyboard.isDown("q") then
        player:move(-player.speed * dt, 0)
    end

    if love.keyboard.isDown("down") or love.keyboard.isDown("s") then
        player:move(0, player.speed * dt)
    end
    if love.keyboard.isDown("up") or love.keyboard.isDown("z") then
        player:move(0, -player.speed * dt)
    end

    --the player is oriented towards the mouse's cursor
    local mouse = {}
    mouse.x, mouse.y = love.mouse.getPosition()
    player:rotate(math.atan2(mouse.y - player.y, mouse.x - player.x) + math.pi/2)

    asteroids[1]:move(dt)
end

function love.draw()
    love.graphics.draw(player.image, player.x, player.y, player.r, 1, 1, player.width/2, player.height/2)
    love.graphics.draw(asteroids[1].image, asteroids[1].x, asteroids[1].y)
end
