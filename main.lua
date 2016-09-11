local Gamestate = require "hump.gamestate"
local game = require "states.game"
local menu = require "states.menu"

function love.load()
    Gamestate.registerEvents()
    Gamestate.switch(game)
end
