local Bullet = require "bullet"

local Ship = {}

--[[
    Constructor :
    newImage : the ship's image
]]--
function Ship:new(world)
    local newShip = {
        x = 300,
        y = 400,
        r = 0,
        width = 53,
        height = 63,
        speed = 200,
        body = newBody,
        shape = newShape,
        fixture = newFixture
    }

    self.__index = self
    return setmetatable(newShip, self)
end

function Ship:move(dx, dy)
    if self.x + dx < 600 and self.x + dx > 0 then
        self.x = self.x + dx
    end
    if self.y + dy < 800 and self.y + dy > 0 then
        self.y = self.y + dy
    end
end

function Ship:rotate(r)
    self.r = r
end

function Ship:shoot(x, y, image)
    local start = {
        x = self.x,
        y = self.y
    }
    local angle = math.atan2(x - start.x, y - start.y)
    return Bullet:new(start, angle, image)
end

return Ship
