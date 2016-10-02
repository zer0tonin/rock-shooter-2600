local Gamestate = require "hump.gamestate"
--can't be loaded from gameOver if local
menu = require "states.menu"

function love.load()
    Gamestate.registerEvents()
    Gamestate.switch(menu)
end
