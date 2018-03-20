local scale = 3
love.graphics.setDefaultFilter("nearest", "nearest", 1)
tiles = love.graphics.newImage("img/tiles.png")

bar = require "ui.bar"
partymember = require "partymember"
item = require "item"
party = {
    newPartyMember("JUDY", "KNIGHT", 0, 56, 0, 19*8,
    {["LV"]=12, ["MHP"]=70, ["HP"]=19, ["MMP"]=16, ["MP"]=3, ["TB"]=95, ["SB"]=75, ["AGI"]=15}), 
    newPartyMember("NICK", "ROGUE", 0, 88, 48, 19*8,
    {["LV"]=10, ["MHP"]=36, ["HP"]=11, ["MMP"]=34, ["MP"]=0, ["TB"]=110, ["SB"]=200, ["AGI"]=22})--[[,
    newPartyMember("BOGO", "ENFORCER", 0, 120, 96, 19*8,
    {["LV"]=15, ["MHP"]=122, ["HP"]=107, ["MMP"]=25, ["MP"]=22, ["TB"]=90, ["SB"]=60, ["AGI"]=9})]]--
}
partyItems = {
    {items[1], 4}, {items[2], 2}, {items[4], 1}
}

battleEncounter = require "battleEncounter"
pointer = require "ui.pointer"
menusystem = require "ui.menusystem"
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