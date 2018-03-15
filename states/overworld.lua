Gamestate = require "libs.gamestate"
local battle = require "states.battle"
local pausemenu = require "states.pausemenu"
local overworld = {}

function overworld:init()

end

function overworld:enter()

end

function overworld:leave()

end

function overworld:update(dt)

end

function overworld:draw()
    love.graphics.setColor(200, 80, 150, 255)
    love.graphics.print("Overworld", 0, 0)
end

return overworld