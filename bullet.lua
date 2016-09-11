local Bullet = {}
local HC = require "HC"

function Bullet:new(start, newAngle, newImage)
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

function Bullet:move(dt)
    local dy = math.cos(self.angle) * (dt * self.speed)
    local dx = math.sin(self.angle) * (dt * self.speed)

    self.x = self.x + dx
    self.y = self.y + dy

    self.shape:move(dx, dy)
end

return Bullet
