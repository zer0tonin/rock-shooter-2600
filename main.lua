local Ship = require "ship"
local Asteroid = require "asteroid"

function love.load()
    player = Ship:new(love.graphics.newImage("assets/ship.png"))
    asteroids = {}
    timer = love.timer.getTime()
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
        math.randomseed(os.time() * #asteroids)
        local size = math.random()
        local image = love.graphics.newImage("assets/asteroid200.png")

        --picks the size
        if size < 0.20 then
            size = 50
            image = love.graphics.newImage("assets/asteroid50.png")
        elseif size < 0.60 then
            size = 100
            image = love.graphics.newImage("assets/asteroid100.png")
        elseif size < 0.90 then
            size = 150
            image = love.graphics.newImage("assets/asteroid150.png")
        else
            size = 200
        end

        --picks if it will come from the top or the bottom of the screen
        math.randomseed(os.time() * #asteroids)
        local location = math.random()
        local x = math.random(0, 800)
        local y = math.random(-100, 0)

       if location < 0.25 then
            x = math.random(800, 900)
            y = math.random(0, 600)
        elseif location < 0.50 then
            x = math.random(0, 800)
            y = math.random(600, 700)
        elseif location < 0.75 then
            x = math.random(-100, 0)
            y = math.random(0, 600)
        else
        end

        asteroids[#asteroids+1] = Asteroid:new(image, x, y, size)
    end

    for key, val in ipairs(asteroids) do
        val:move(dt)
    end

end

function love.draw()
    love.graphics.draw(player.image, player.x, player.y, player.r, 1, 1, player.width/2, player.height/2)
    for key, val in ipairs(asteroids) do
        love.graphics.draw(val.image, val.x, val.y)
    end
end
