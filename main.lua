local Ship = require "ship"
local Asteroid = require "asteroid"
local HC = require "HC"

function love.load()
    timer = love.timer.getTime()

    love.physics.setMeter(100)
    love.physics.newWorld(0)

    player = Ship:new()

    --images for the asteroids
    images = {}
    images[50] = love.graphics.newImage("assets/asteroid50.png")
    images[100] = love.graphics.newImage("assets/asteroid100.png")
    images[150] = love.graphics.newImage("assets/asteroid100.png")
    images[200] = love.graphics.newImage("assets/asteroid200.png")
    images["bullet"] = love.graphics.newImage("assets/bullet.png")
    images["player"] = love.graphics.newImage("assets/ship.png")

    asteroids = {}

    bullets = {}
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

    --generates new asteroids
    if #asteroids < 3 or love.timer.getTime() - timer > 30 then
        asteroids[#asteroids+1] = Asteroid:new()
    end

    --moves the asteroids
    for key, val in ipairs(asteroids) do
        val:move(dt)
    end

    --moves the bullets
    for key, val in ipairs(bullets) do
        val:move(dt)
    end

    --detects the collisions with each asteroids
    for key, val in ipairs(asteroids) do
        local collisions = HC.collisions(val.shape)
        for shape, vector in pairs(collisions) do
            if tableContainsShape(bullets, shape) then
                print("collision with a bullet")
            elseif tableContainsShape(asteroids, shape) then
                print("collision with an asteroid")
            elseif shape == player.shape then
                print("collision with the player")
            else
                print("collision with an unknown object")
            end
        end
    end

end

function love.mousepressed(x, y, button)
    if button == "l" then
        bullets[#bullets+1] = player:shoot(x, y)
    end
end

--used to check if the collisions come from a bullet or an asteroid
function tableContainsShape(table, shape)
    for key, value in ipairs(table) do
        if value.shape == shape then
            return true
        end
    end
    return false
end

function love.draw()
    love.graphics.draw(images["player"], player.x, player.y, player.r, 1, 1, player.width/2, player.height/2)

    for key, val in ipairs(asteroids) do
        love.graphics.draw(images[val.size], val.x, val.y)
    end

    for key, val in ipairs(bullets) do
        love.graphics.draw(images["bullet"], val.x, val.y)
    end
end
