scale = 3
love.graphics.setDefaultFilter("nearest", "nearest", 1)
tiles = love.graphics.newImage("img/tiles.png")

menucontrols = require "ui.menucontrols"
bar = require "ui.bar"
partymember = require "system.partymember"
item = require "system.item"

party = {
    partyMembers[1], partyMembers[3], partyMembers[2]
}

partyItems = initInventory()
partyItems:add(items[1], 2)
partyItems:add(items[2], 2)
partyItems:add(items[4], 1)
partyItems:add(items[1], 1)
partyItems:add(items[1], 1)

battleEncounter = require "system.battleEncounter"
pointer = require "ui.pointer"
menubox = require "ui.menubox"
window = require "ui.window"
Gamestate = require "libs.gamestate"
mainmenu = require "states.mainmenu"
overworld = require "states.overworld"
battle = require "states.battle"
pausemenu = require "states.pausemenu"
battlepause = require "states.battlepause"

function love.load()
    window = {}
    window.width = 256
    window.height = 240
    love.window.setMode(window.width, window.height, 
    {resizable=false, vsync=true, minwidth=window.width*scale, minheight=window.height*scale})
    love.window.setTitle("ZC:tNHS")
    
    font = love.graphics.newImageFont("img/font.png", 
    " ABCDEFGHIJKLMNOPQRSTUVWXYZ,.:;!?[]-+/%\"\'1234567890=_~`*>()x^v<")
    love.graphics.setFont(font)

    love.graphics.setBackgroundColor( 166, 166, 166)

    Gamestate.registerEvents()
    --[[
    Gamestate.switch(battle, newEncounter({
        newEnemy("TEST1", 3, 8, 0, 40, 32, 32), 
        newEnemy("TEST2", 8, 8, 0, 72, 32, 32), 
        newEnemy("TEST3", 13, 8, 0, 104, 32, 32)
    }))
    ]]--
    Gamestate.switch(overworld)
    Gamestate.push(pausemenu)
end


function love.update(dt)
    
end

function love.draw()
    love.graphics.scale(scale)
end


function love.keypressed(key)

end