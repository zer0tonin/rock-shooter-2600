local HC = require "HC"
local Ship = require "ship"
local Asteroid = require "asteroid"

function love.load()
    timer = love.timer.getTime()

    love.physics.setMeter(100)
    love.physics.newWorld(0)

    player = Ship:new()

    --images for the asteroids
    image = {}
    image[50] = love.graphics.newImage("assets/asteroid50.png")
    image[100] = love.graphics.newImage("assets/asteroid100.png")
    image[150] = love.graphics.newImage("assets/asteroid100.png")
    image[200] = love.graphics.newImage("assets/asteroid200.png")
    image["bullet"] = love.graphics.newImage("assets/bullet.png")

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
    --should be a revamped Constructor
    if #asteroids < 3 or love.timer.getTime() - timer > 30 then


        asteroids[#asteroids+1] = Asteroid:new(image)
    end

    for key, val in ipairs(asteroids) do
        val:move(dt)
    end

    for key, val in ipairs(bullets) do
        val:move(dt)
    end

end

function love.mousepressed(x, y, button)
    if button == "l" then
        bullets[#bullets+1] = player:shoot(x, y, image["bullet"])
    end
end

function love.draw()
    love.graphics.draw(player.image, player.x, player.y, player.r, 1, 1, player.width/2, player.height/2)

    for key, val in ipairs(asteroids) do
        love.graphics.draw(val.image, val.x, val.y)
    end

    for key, val in ipairs(bullets) do
        love.graphics.draw(val.image, val.x, val.y)
    end
end
