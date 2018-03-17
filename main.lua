tiles = love.graphics.newImage("img/tiles.png")

partymember = require "partymember"
party = {
    newPartyMember("JUDY", "knight", 0, 56,
    {["MHP"]=70, ["HP"]=19, ["MMP"]=16, ["MP"]=3, ["TB"]=100, ["SB"]=75, ["AGI"]=14}), 
    newPartyMember("NICK", "rogue", 0, 88,
    {["MHP"]=36, ["HP"]=11, ["MMP"]=34, ["MP"]=0, ["TB"]=80, ["SB"]=160, ["AGI"]=22})
}

pointer = require "pointer"
menubox = require "menubox"
bar = require "bar"
Gamestate = require "libs.gamestate"
mainmenu = require "states.mainmenu"
overworld = require "states.overworld"
battle = require "states.battle"
pausemenu = require "states.pausemenu"

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
    Gamestate.switch(battle)
end


function love.update(dt)

end

function love.draw()
    
end


function love.keypressed(key)

end