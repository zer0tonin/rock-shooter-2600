local Bullet = {}
local HC = require "HC"

--[[
    Constructor :
    start : x and y coordinates (of the ship)
    newAngle : angle between the ship and the mouse
--]]
function Bullet:new(start, newAngle)
    local newBullet = {
        x = start.x,
        y = start.y,
        angle = newAngle,
        speed = 250,
        shape = HC.circle(start.x + 11/2, start.y + 11/2, 11/2)
    }

    self.__index = self
    return setmetatable(newBullet, self)
end

--moves the bullet
--bullets are supposed to go toward the mouseclick position
function Bullet:move(dt)
    local dy = math.cos(self.angle) * (dt * self.speed)
    local dx = math.sin(self.angle) * (dt * self.speed)

    self.x = self.x + dx
    self.y = self.y + dy

    self.shape:move(dx, dy)
end

return Bullet
