local battle = {}
local stats = party[1]["stats"]
local swapTimer = 0.33

--local pointer = newPointer(20, 15, 6, 2)
local pointer = newPointer(18, 6, table.getn(party), 9)

local messageBox = newMenuBox(0, 21, 19, 9)
local tipBox = newMenuBox(0, 0, 32, 3)
local messageStr = "SORC. BELLWETHER\n\nPREPARES TO\n\nATTACK!"
local tipStr = "JUDY>NOT READY!"

local commandBox = newMenuBox(20, 13, 11, 16)
local contextBox = newMenuBox(19, 12, 13, 18)

local partyBoxes = {}
for i=0,2 do
    partyBoxes[i+1] = newMenuBox(19, 3+(i*9), 13, 9)
end

partyBars = {}
function createPartyBars()
    for i,v in ipairs(party) do 
        local memberBars = {}
        local stats = party[i].stats
        memberBars["HP"] = newBar(24*8, (6+((i-1)*9))*8, stats["MHP"], stats["HP"], 7, 0) --HP
        memberBars["MP"] = newBar(24*8, (8+((i-1)*9))*8, stats["MMP"], stats["MP"], 7, 1) --MP
        memberBars["TB"] = newBar(24*8, (4+((i-1)*9))*8, stats["TB"], 0, 4, 3) --TB
        memberBars["SB"] = newBar(24*8, (4+((i-1)*9))*8, stats["SB"], 0, 4, 4) --SB
        partyBars[i] = memberBars
    end
end


function battle:init()
    
end

function battle:enter()
    createPartyBars()
end

function battle:resume()

end

function battle:leave()

end

function battle:update(dt)
    --Increment TB and SB
    for i,v in ipairs(party) do
        local timeFactor = 8
        local specialFactor = 4.5
        if partyBars[i]["TB"].current+(dt*timeFactor) < partyBars[i]["TB"].max then
            partyBars[i]["TB"]:update(partyBars[i]["TB"].current+(dt*timeFactor))
        else
            partyBars[i]["TB"]:update(partyBars[i]["TB"].max)
            if partyBars[i]["SB"].current+(dt*specialFactor) < partyBars[i]["SB"].max then
                partyBars[i]["SB"]:update(partyBars[i]["SB"].current+(dt*specialFactor))
            else
                partyBars[i]["SB"]:update(partyBars[i]["SB"].max)
            end
        end
    end
    --Swap SB colors
    swapTimer = swapTimer-dt
    if swapTimer <= 0 then
        for i,v in ipairs(party) do
            partyBars[i]["SB"]:swapRow()
            swapTimer = 0.33
        end
    end
end

function battle:draw()
    love.graphics.setBackgroundColor( 166, 166, 166 )
    love.graphics.setColor(255, 255, 255, 255)
    
    messageBox:draw()
    tipBox:draw()
    --Draw party boxes
    for i,v in ipairs(partyBoxes) do 
        partyBoxes[i]:draw()
    end
    --Draw party info
    for i,v in ipairs(partyBars) do
        local yShift = (i-1)*9
        love.graphics.draw(tiles, party[i].picture, 20*8, (5+yShift)*8)
        love.graphics.print("HP:"..partyBars[i]["HP"].current, 24*8, (5+yShift)*8)
        partyBars[i]["HP"]:draw()
        love.graphics.print("MP:"..partyBars[i]["MP"].current, 24*8, (7+yShift)*8)
        partyBars[i]["MP"]:draw()
        love.graphics.print((partyBars[i]["TB"]:getPercent()+partyBars[i]["SB"]:getPercent()) .."%", 20*8, (4+yShift)*8)
        partyBars[i]["TB"]:draw()
        partyBars[i]["SB"]:draw()
    end

    love.graphics.print(tipStr, 8, 8)
    love.graphics.print(messageStr, 8, 22*8)
    --love.graphics.print("~POULTICE~\n\n+10% AGI\n\nTO SELF", 19*8, 20*8)
    --love.graphics.print("+AGI", 21*8, 9*8)
    --love.graphics.print("+LCK", 26*8, 9*8)

    --commandBox:draw()
    --love.graphics.print("ATTACK\n\nSPELL\n\nDEFEND\n\nITEM\n\nCHECK\n\nRUN", 22*8, 15*8)
    --contextBox:draw()
    --love.graphics.print("~SPELLS~", 20*8, 13*8)
    --love.graphics.print("QUICK DRAW\n\nROYAL SHLD", 21*8, 15*8)

    pointer:draw()
   
end

function battle:keypressed(key)
    if key == 'up' then
        pointer:moveUp()
    end
    if key == 'down' then
        pointer:moveDown()
    end
    --[[
    if key == 'right' then
        party[2]:changeStat("MP", 5)
        partyBars[2][2]:update(party[2].stats.MP)
    end
    if key == 'left' then
        party[2]:changeStat("MP", -5)
        partyBars[2][2]:update(party[2].stats.MP)
    end
    ]]--
    
end

return battle