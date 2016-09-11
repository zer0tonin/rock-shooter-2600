local gameOver = {}

local score

function gameOver:enter(previous, newScore)
    score = newScore
end

--there are better ways to line that up
function gameOver:draw()
    love.graphics.print("Your score : " .. score, 300, 200)
    love.graphics.print("Retry", 350, 300)
    love.graphics.print("Menu", 355, 400)
end


return gameOver
