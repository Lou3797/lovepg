local classes = {}
classes["KNIGHT"] = {}
classes["ROGUE"] =  {}

function newPartyMember(name, full, desc, class, imgX1, imgY1, imgX2, imgY2, stats, moveset)
    local member = {}
    member.name = name
    member.full = full
    member.desc = desc
    member.img = love.graphics.newQuad(imgX1, imgY1, 32, 32, tiles:getDimensions())
    member.portrait = love.graphics.newQuad(imgX2, imgY2, 48, 48, tiles:getDimensions())
    member.class = classes[class]
    member.stats = stats
    member.moveset = moveset
    member.mods = {{}, {}} --{{"AGI", 10}, {"ATK", 15}}


    function member:changeStat(stat, num)
        member.stats[stat] = member.stats[stat] + num
    end

    return member
end

partyMembers = {
    newPartyMember("JUDY", "JUDY HOPPS", "CARROT FARMER TURNED KNIGHT", "KNIGHT", 0, 56, 0, 19*8,
    {["LV"]=12, ["MHP"]=70, ["HP"]=59, ["MMP"]=16, ["MP"]=3, ["TB"]=95, ["SB"]=75,
    ["ATK"]=18, ["DEF"]=13, ["MGA"]=6, ["MGD"]=5, ["INT"]=7, ["CON"]=10, ["AGI"]=15}), 
    newPartyMember("NICK", "NICHOLAS WILDE", "SHIFTY CHARLATAN FOX", "ROGUE", 0, 88, 48, 19*8,
    {["LV"]=10, ["MHP"]=36, ["HP"]=11, ["MMP"]=34, ["MP"]=0, ["TB"]=110, ["SB"]=200,
    ["ATK"]=11, ["DEF"]=10, ["MGA"]=11, ["MGD"]=9, ["INT"]=17, ["CON"]=11, ["AGI"]=23}),
    newPartyMember("BOGO", "CHIEF BOGO", "HEAD OF THE ZOOTOPIAN GUARD", "ENFORCER", 0, 120, 96, 19*8,
    {["LV"]=15, ["MHP"]=122, ["HP"]=107, ["MMP"]=25, ["MP"]=22, ["TB"]=90, ["SB"]=60,
    ["ATK"]=20, ["DEF"]=18, ["MGA"]=8, ["MGD"]=15, ["INT"]=9, ["CON"]=14, ["AGI"]=9})
}

function newMove(name, desc, type, mod)
    local move = {}

    move.name = name
    move.desc = desc
    move.type = type
    move.mod = mod

    return move
end

moves = {
    newMove(),
    newMove("ROYAL SHLD", "INCREASE DEF 15% TO ALLY.")
}

function createPartyBars()
    local partyBars = {}
    for i,v in ipairs(party) do 
        local memberBars = {}
        local stats = party[i].stats
        if Gamestate.current() == battle then
            memberBars["HP"] = newBar(stats["MHP"], stats["HP"], 7, 0) --HP
            memberBars["MP"] = newBar(stats["MMP"], stats["MP"], 7, 1) --MP
            memberBars["TB"] = newBar(stats["TB"], math.floor(stats["TB"]/2), 7, 3) --TB
            memberBars["SB"] = newBar(stats["SB"], 0, 7, 4) --SB
        elseif Gamestate.current() == pausemenu then
            memberBars["HP"] = newBar(stats["MHP"], stats["HP"], 11, 0) --HP
            memberBars["MP"] = newBar(stats["MMP"], stats["MP"], 11, 1) --MP
        end
        partyBars[i] = memberBars
    end
    return partyBars
end

function drawPartyMemberInfo(partyBars, i, yShift)
    local yShift = yShift or ((i-1)*9)
    if Gamestate.current() == battle then
        love.graphics.draw(tiles, party[i].img, 20*8, (5+yShift)*8)
        love.graphics.print("HP:"..partyBars[i]["HP"].current, 24*8, (5+yShift)*8)
        partyBars[i]["HP"]:draw(24*8, (6+yShift)*8)
        love.graphics.print("MP:"..partyBars[i]["MP"].current, 24*8, (7+yShift)*8)
        partyBars[i]["MP"]:draw(24*8, (8+yShift)*8)
        love.graphics.print((partyBars[i]["TB"]:getPercent()+partyBars[i]["SB"]:getPercent()), 20*8, (4+yShift)*8)
        love.graphics.print("%", 23*8, (4+yShift)*8)
        partyBars[i]["TB"]:draw(24*8, (4+yShift)*8)
        partyBars[i]["SB"]:draw(24*8, (4+yShift)*8)
    elseif Gamestate.current() == pausemenu then
        love.graphics.print("~"..party[i].name.."~", 14*8, (4+yShift)*8)
        love.graphics.print("LV."..party[i].stats["LV"], 26*8, (4+yShift)*8)
        love.graphics.draw(tiles, party[i].portrait, 14*8, (5+yShift)*8)
        love.graphics.print("HP:"..partyBars[i]["HP"].current, 20*8, (6+yShift)*8)
        love.graphics.print("/"..partyBars[i]["HP"].max, 26*8, (6+yShift)*8)
        partyBars[i]["HP"]:draw(20*8, (7+yShift)*8)
        love.graphics.print("MP:"..partyBars[i]["MP"].current, 20*8, (8+yShift)*8)
        love.graphics.print("/"..partyBars[i]["MP"].max, 26*8, (8+yShift)*8)
        partyBars[i]["MP"]:draw(20*8, (9+yShift)*8)
        love.graphics.print("NEXT: 99999", 20*8, (10+yShift)*8)
    end
    
end

function displayPartyMemberStat(partyMember)
    love.graphics.print(partyMember.full, 12*8, 5*8)


    --love.graphics.draw()
    love.graphics.print("BACK", 2*8, 27*8)
end