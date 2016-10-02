--keeps the module path at the directory root
package.path = ";../"


local Ship = require "objects.ship"
local Asteroid = require "objects.asteroid"
local HC = require "HC"
local Gamestate = require "hump.gamestate"
local gameOver = require "states.gameOver"

local game = {}

--var init
local timer
local player
local images
local asteroids
local bullets
local score
local font

function game:enter()
    timer = love.timer.getTime()

    player = Ship:new()

    --images for the asteroids
    images = {}
    images[50] = love.graphics.newImage("assets/asteroid50.png")
    images[100] = love.graphics.newImage("assets/asteroid100.png")
    images[150] = love.graphics.newImage("assets/asteroid100.png")
    images[200] = love.graphics.newImage("assets/asteroid200.png")
    images["bullet"] = love.graphics.newImage("assets/bullet.png")
    images["player"] = love.graphics.newImage("assets/ship.png")

    score = 0

    asteroids = {}
    bullets = {}

    font = love.graphics.newFont("assets/Squareo.ttf", 25)
    love.graphics.setFont(font)
end

-- reset the state on retry
function game:resume()
    asteroids = nil
    bullets = nil
    asteroids = {}
    bullets = {}
    score = 0
end

function game:update(dt)

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

    --generates new asteroids
    if #asteroids < 3 or love.timer.getTime() - timer > 10 then
        asteroids[#asteroids+1] = Asteroid:newRandom(#asteroids)
        timer = love.timer.getTime()
    end

    --moves the asteroids
    for key, val in ipairs(asteroids) do
        val:move(dt)
    end

    --moves the bullets
    for key, val in ipairs(bullets) do
        val:move(dt)
    end

    detectCollisions()

end

--shoots bullets on mouse click
function game:mousepressed(x, y, button)
    if button == "l" then
        bullets[#bullets+1] = player:shoot(x, y)
    end
end

--used to check if the collisions come from a bullet or an asteroid
function tableContainsShape(table, shape)
    for key, value in ipairs(table) do
        if value.shape == shape then
            return {key, value}
        end
    end
    return false
end

--detects collisions
function detectCollisions()
    --detects the collisions with each asteroids
    for key, val in ipairs(asteroids) do
        local collisions = HC.collisions(val.shape)

        for shape, vector in pairs(collisions) do
            local bullet = tableContainsShape(bullets, shape)
            if bullet then

                --removes the bullet
                table.remove(bullets, bullet.key)
                bullet.value = nil

                --generates new asteroids and removes the destroyed one
                table.remove(asteroids, key)
                if val.size == 200 then
                    asteroids[#asteroids+1] = Asteroid:new(val.x + 30, val.y + 30, 100)
                    asteroids[#asteroids+1] = Asteroid:new(val.x - 30, val.y - 30, 100)
                elseif val.size == 150 then
                    asteroids[#asteroids+1] = Asteroid:new(val.x + 30, val.y + 30, 50)
                    asteroids[#asteroids+1] = Asteroid:new(val.x + 30, val.y - 30, 50)
                    asteroids[#asteroids+1] = Asteroid:new(val.x - 30, val.y - 30, 50)
                elseif val.size == 100 then
                    asteroids[#asteroids+1] = Asteroid:new(val.x + 30, val.y + 30, 50)
                    asteroids[#asteroids+1] = Asteroid:new(val.x - 30, val.y - 30, 50)
                end
                val = nil

                --increments the score
                score = score + 50
            end

            if tableContainsShape(asteroids, shape) then
                --print("collision with an asteroid")
            end

            if shape == player.shape then
                Gamestate.switch(gameOver, score)
            end
        end

    end
end

function game:draw()
    love.graphics.draw(images["player"], player.x, player.y, player.r, 1, 1, player.width/2, player.height/2)

    for key, val in ipairs(asteroids) do
        love.graphics.draw(images[val.size], val.x, val.y)
    end

    for key, val in ipairs(bullets) do
        love.graphics.draw(images["bullet"], val.x, val.y)
    end

    love.graphics.print(score, 50, 50)
end

return game
