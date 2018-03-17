tiles = love.graphics.newImage("img/tiles.png")

partymember = require "partymember"
item = require "item"
party = {
    newPartyMember("JUDY", "knight", 0, 56,
    {["MHP"]=70, ["HP"]=19, ["MMP"]=16, ["MP"]=3, ["TB"]=95, ["SB"]=75, ["AGI"]=15}), 
    newPartyMember("NICK", "rogue", 0, 88,
    {["MHP"]=36, ["HP"]=11, ["MMP"]=34, ["MP"]=0, ["TB"]=110, ["SB"]=200, ["AGI"]=22}),
    newPartyMember("BOGO", "paladin", 0, 120,
    {["MHP"]=122, ["HP"]=107, ["MMP"]=25, ["MP"]=22, ["TB"]=90, ["SB"]=60, ["AGI"]=9})
}
partyItems = {
    {items[1], 4}, {items[2], 2}
}

battleEncounter = require "battleEncounter"
pointer = require "pointer"
menubox = require "menubox"
bar = require "bar"
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
    {resizable=true, vsync=true, minwidth=window.width, minheight=window.height})
    love.window.setTitle("ZC:tNHS")

    font = love.graphics.newImageFont("img/font.png", 
    " ABCDEFGHIJKLMNOPQRSTUVWXYZ,.:;!?[]-+/%\"\'1234567890=_~`*>()")
    love.graphics.setFont(font)

    love.graphics.setBackgroundColor( 166, 166, 166)

    Gamestate.registerEvents()
    Gamestate.switch(battle, newEncounter({
        newEnemy("TEST1", 3, 8, 0, 40, 32, 32), 
        newEnemy("TEST2", 8, 8, 0, 72, 32, 32), 
        newEnemy("TEST3", 13, 8, 0, 104, 32, 32)
    }))
end


function love.update(dt)

end

function love.draw()
    
end


function love.keypressed(key)

end