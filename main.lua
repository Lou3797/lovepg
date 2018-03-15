Gamestate = require "libs.gamestate"
mainmenu = require "states.mainmenu"
overworld = require "states.overworld"
battle = require "states.battle"
pausemenu = require "states.pausemenu"

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