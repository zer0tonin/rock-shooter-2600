local Ship = {}

--[[
    Constructor :
    newImage : the ship's image
]]--
function Ship:new(newImage)
    local newShip = {
        x = 300,
        y = 400,
        r = 0,
        width = 53,
        height = 63,
        speed = 200,
        image = newImage
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

return Ship
