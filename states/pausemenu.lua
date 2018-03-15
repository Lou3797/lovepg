Gamestate = require "libs.gamestate"
local battle = require "states.battle"
local overworld = require "states.overworld"
local pausemenu = {}

function pausemenu:init()

end

function pausemenu:enter()

end

function pausemenu:leave()

end

function pausemenu:update(dt)

end

function pausemenu:draw()
    love.graphics.setColor(30, 220, 200, 255)
    love.graphics.print("Overworld", 15, 10)
end

return pausemenu