Gamestate = require "libs.gamestate"
local mainmenu = require "states.mainmenu"
local overworld = require "states.overworld"
local battle = require "states.battle"
local pausemenu = require "states.pausemenu"

function love.load()
    window = {}
    window.width = 256
    window.height = 240
    love.window.setMode(window.width, window.height, {resizable=true, vsync=true, minwidth=window.width, minheight=window.height})
    love.window.setTitle("ZOOTOPIA: THE NIGHTHOWLER STONE")

    Gamestate.registerEvents()
    Gamestate.switch(mainmenu)
end


function love.update(dt)

end

function love.draw()
    
end


function love.keypressed(key)

end