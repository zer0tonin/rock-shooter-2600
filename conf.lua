if love.filesystem then
	require 'rocks' ()
end

function love.conf(t)
    t.version = "0.9.1"
    t.window.title = "ROCK SHOOTER 3000"
    t.window.width = 800
    t.window.height = 600
    t.console = true
    t.vsync = false
	t.dependencies = {
	}
end
