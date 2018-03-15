Gamestate = require "libs.gamestate"
local overworld = require "states.overworld"
local mainmenu = {}

function mainmenu:init()

end

function mainmenu:enter()

end

function mainmenu:leave()

end

function mainmenu:update(dt)

end

function mainmenu:draw()
    love.graphics.setColor(110, 105, 120, 255)
    love.graphics.print("Main Menu", 10, 10)
end

function mainmenu:keypressed(key)
    if key == 'z' then
        Gamestate.switch(overworld)
    end
end

return mainmenu