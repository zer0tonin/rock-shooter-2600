local Asteroid = {}
local HC = require "HC"

--[[
    Constructor :
    randomly generates data for :
    newX : the starting x coordinate
    newY: the starting y coordinate
    newSize: the size of the asteroid (must be equal to the image's size)
--]]
function Asteroid:new()
    math.randomseed(os.time())

    math.randomseed(os.time() * #asteroids)
    local newSize = math.random()

    --picks the size
    if newSize < 0.20 then
        newSize = 50
    elseif newSize < 0.60 then
        newSize = 100
    elseif newSize < 0.90 then
        newSize = 150
    else
        newSize = 200
    end

    --picks if it will come from the top or the bottom of the screen
    math.randomseed(os.time() * #asteroids)
    local location = math.random()
    local newX = math.random(0, 800)
    local newY = math.random(-100, 0)

   if location < 0.25 then
        newX = math.random(800, 900)
        newY = math.random(0, 600)
    elseif location < 0.50 then
        newX = math.random(0, 800)
        newY = math.random(600, 700)
    elseif location < 0.75 then
        newX = math.random(-100, 0)
        newY = math.random(0, 600)
    end

    local newAsteroid = {
        x = newX,
        y = newY,
        r = 0,
        size = newSize,
        speed = 50,
        wayPoint = {
            x = math.random(0, 800),
            y = math.random(0, 600)
        },
        shape = HC.circle(newX + newSize/2, newY + newSize/2, newSize/2)
    }

    self.__index = self
    return setmetatable(newAsteroid, self)
end


--keep the asteroid moving when it reaches it's objective
function Asteroid:newWayPoint()
    local wayPoint = {}
    math.randomseed(os.time() * self.x)
    wayPoint.x = math.random(0, 800)
    wayPoint.y = math.random(0, 600)
    return wayPoint
end

--makes the asteroid move in the direction of the wayPoint
--dt is the time difference passed to update
function Asteroid:move(dt)

    --generates a new waypoint if the asteroid as reached the current
    if self.x == self.wayPoint.x and self.y == self.wayPoint.y then

        self.wayPoint = self:newWayPoint()

    else

        local angle = math.atan2(self.wayPoint.y - self.y, self.wayPoint.x - self.x)
        local dx = math.cos(angle) * (dt * self.speed)
        local dy = math.sin(angle) * (dt * self.speed)

        --avoids going too far
        if self.x < self.wayPoint.x then
            if dx > self.wayPoint.x - self.x then
                dx = self.wayPoint.x - self.x
            end
        else
            if dx < self.wayPoint.x - self.x then
                dx = self.wayPoint.x - self.x
            end
        end

        if self.y < self.wayPoint.y then
            if dy > self.wayPoint.y - self.y then
                dy = self.wayPoint.y - self.y
            end
        else
            if dy < self.wayPoint.y - self.y then
                dy = self.wayPoint.y - self.y
            end
        end

        self.x = self.x + dx

        self.y = self.y + dy

        self.shape:move(dx, dy)
    end
end

function Asteroid:shot()
    if size == 200 then
        --2 new 100
    end
    if size == 150 then
        --3 new 50
    end
    if size == 100 then
        --2 new 50
    end
    if size == 50 then
        --DEAD!
    end
end

return Asteroid
