local Gamestate = require "hump.gamestate"
local game = require "states.game"

function love.load()
    Gamestate.registerEvents()
    Gamestate.switch(game)
end
