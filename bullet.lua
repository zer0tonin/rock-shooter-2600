local Bullet = {}

function Bullet:new(start, newAngle, newImage)
    local newBullet = {
        x = start.x,
        y = start.y,
        angle = newAngle,
        image = newImage,
        speed = 200
    }

    self.__index = self
    return setmetatable(newBullet, self)
end

function Bullet:move(dt)
    local dy = math.cos(self.angle) * (dt * self.speed)
    local dx = math.sin(self.angle) * (dt * self.speed)

    self.x = self.x + dx
    self.y = self.y + dy
end

return Bullet
