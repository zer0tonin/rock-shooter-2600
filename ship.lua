local Bullet = require "bullet"
local HC = require "HC"

local Ship = {}

--[[
    Constructor :
    newImage : the ship's image
]]--
function Ship:new()
    local newShip = {
        x = 300,
        y = 400,
        r = 0,
        width = 53,
        height = 63,
        speed = 200,
        body = newBody,
        shape = newShape,
        fixture = newFixture,
        shape = HC.rectangle(300 - (53/2), 400 - (63/2), 53, 63)
    }

    self.__index = self
    return setmetatable(newShip, self)
end

--moves the ship by dx and dy
--stops it from goint out of the window
function Ship:move(dx, dy)
    if self.x + dx < 800 and self.x + dx > 0 then
        self.x = self.x + dx
        self.shape:move(dx, 0)
    end
    if self.y + dy < 600 and self.y + dy > 0 then
        self.y = self.y + dy
        self.shape:move(0, dy)
    end
end

--basically a setter for r
function Ship:rotate(r)
    local dr = r - self.r
    self.r = r
    self.shape:rotate(dr)
end

--generates bullets
function Ship:shoot(x, y, image)
    local start = {
        x = self.x,
        y = self.y
    }
    local angle = math.atan2(x - start.x, y - start.y)
    return Bullet:new(start, angle, image)
end

return Ship
