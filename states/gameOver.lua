local gameOver = {}
local Gamestate = require "hump.gamestate"
local game

local score
local debug

function gameOver:enter(previous, newScore)
    score = newScore
    game = previous
end

--there are better ways to line that up
function gameOver:draw()
    love.graphics.print("Your score : " .. score, 300, 200)
    love.graphics.print("Retry", 350, 300)
    love.graphics.print("Menu", 355, 400)
end

function gameOver:mousepressed(x, y, button)
    if button == "l" then
        if(x >= 350 and y >= 300 and x < 425 and y < 325) then
            Gamestate.switch(game)
        end
        if(x >= 355 and y >= 400 and x < 425 and y < 425) then
            Gamestate.switch(menu)
        end
    end
end

return gameOver
