local battle = {}
local stats = party[1]["stats"]
local swapTimer = 0.33
local currentEncounter = {}

local pointer = {
    [1]=newPointer(18, 6, table.getn(party), 9),
    [2]=newPointer(20, 15, 6, 2),
    [3]=newPointer(19, 15, 10, 2),
    ["current"]=1, ["picked"]=1, ["action"]=1
}

local messageBox = newMenuBox(0, 21, 19, 9)
local tipBox = newMenuBox(0, 0, 32, 3)
local messageStr = ""
local tipStr = ""
local tempTipStr = ""

local commandBox = newMenuBox(20, 13, 11, 16)
local subActionBox = newMenuBox(19, 12, 13, 18)
local pickedBox = newMenuBox(19, 3, 13, 9)

local partyBoxes = {}
for i=0,2 do
    partyBoxes[i+1] = newMenuBox(19, 3+(i*9), 13, 9)
end

partyBars = {}
function createPartyBars()
    for i,v in ipairs(party) do 
        local memberBars = {}
        local stats = party[i].stats
        memberBars["HP"] = newBar(stats["MHP"], stats["HP"], 7, 0) --HP
        memberBars["MP"] = newBar(stats["MMP"], stats["MP"], 7, 1) --MP
        memberBars["TB"] = newBar(stats["TB"], 100, 7, 3) --TB
        memberBars["SB"] = newBar(stats["SB"], 0, 7, 4) --SB
        partyBars[i] = memberBars
    end
end

function drawPartyMemberInfo(i, yShift)
    local yShift = yShift or ((i-1)*9)
    love.graphics.draw(tiles, party[i].img, 20*8, (5+yShift)*8)
    love.graphics.print("HP:"..partyBars[i]["HP"].current, 24*8, (5+yShift)*8)
    partyBars[i]["HP"]:draw(24*8, (6+yShift)*8)
    love.graphics.print("MP:"..partyBars[i]["MP"].current, 24*8, (7+yShift)*8)
    partyBars[i]["MP"]:draw(24*8, (8+yShift)*8)
    love.graphics.print((partyBars[i]["TB"]:getPercent()+partyBars[i]["SB"]:getPercent()), 20*8, (4+yShift)*8)
    love.graphics.print("%", 23*8, (4+yShift)*8)
    partyBars[i]["TB"]:draw(24*8, (4+yShift)*8)
    partyBars[i]["SB"]:draw(24*8, (4+yShift)*8)
end

function executeCommand()

end

function battle:init()
    
end

function battle:enter(prevState, encounter)
    createPartyBars()
    currentEncounter = encounter
    pointer[4]=newEncounterPointer(encounter)
end

function battle:resume()

end

function battle:leave()

end

function battle:update(dt)
    --Increment TB and SB
    for i,v in ipairs(party) do
        local timeFactor = party[i].stats["AGI"]/2
        local specialFactor = party[i].stats["AGI"]/2.5
        if partyBars[i]["TB"].current+(dt*timeFactor) < partyBars[i]["TB"].max then --and current bar does not equal max value
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

    --Update tooltip
    local curPoint = pointer[pointer.current]
    if pointer.current == 1 then
        local curSelect = curPoint.current
        tipStr = party[curSelect].name..">"
        if partyBars[curSelect]["TB"].getPercent() < 100 then
            tempTipStr = "NOT READY!"
        else 
            tempTipStr = "READY!"
        end
    elseif pointer.current == 2 then
        tipStr = party[pointer.picked].name
        local curSelect = curPoint.current
        if curSelect == 1 then tempTipStr = ">ATTACK"
        elseif curSelect == 2 then tempTipStr = ">SPELL"
        elseif curSelect == 3 then tempTipStr = ">DEFEND"
        elseif curSelect == 4 then tempTipStr = ">ITEM"
        elseif curSelect == 5 then tempTipStr = ">CHECK"
        elseif curSelect == 6 then tempTipStr = ">RUN"
        end
    elseif pointer.current == 4 then
        tempTipStr = ">"..currentEncounter.enemies[pointer[pointer.current].current].name
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
        drawPartyMemberInfo(i)
    end

    love.graphics.print(tipStr..tempTipStr, 8, 8)
    love.graphics.print(messageStr, 8, 22*8)
    --love.graphics.print("+AGI", 21*8, 9*8)
    --love.graphics.print("+LCK", 26*8, 9*8)

    --Draw enemy sprites
    currentEncounter:draw()

    --Display action menu
    if pointer.current == 2 then
        pickedBox:draw()
        drawPartyMemberInfo(pointer.picked, 0)
        commandBox:draw()
        love.graphics.print("ATTACK\n\nSPELL\n\nDEFEND\n\nITEM\n\nCHECK\n\nRUN", 22*8, 15*8)

    end

    --Display sub-action menu
    if pointer.current == 3 then
        subActionBox:draw()
        love.graphics.print("~SPELLS~", 20*8, 13*8)
        love.graphics.print("QUICK DRAW\n\nROYAL SHLD", 21*8, 15*8)
    end

    pointer[pointer.current]:draw()
   
end

function battle:keypressed(key)
    if key == 'up' then
        pointer[pointer.current]:moveUp()
    elseif key == 'down' then
        pointer[pointer.current]:moveDown()
    --Choose Action
    elseif key == 'z' then
        if pointer.current == 1 then
            if partyBars[pointer[pointer.current].current]["TB"].getPercent() < 100 then

            else
                pointer.picked = pointer[pointer.current].current
                pointer.current = 2
            end
            
        elseif pointer.current == 2 then
            pointer.action = pointer[pointer.current].current
            pointer.current = 3
            tipStr = tipStr..tempTipStr
        end
    --Cancel Action
    elseif key == 'x' then
        if pointer.current == 2 then
            pointer[pointer.current]:reset()
            pointer.current = 1
        elseif pointer.current == 4 then
            pointer[pointer.current]:reset()
            pointer.current = 2

        end


    elseif key == 'return' then
        Gamestate.push(battlepause)
    end

    
    if key == 'right' then
        if pointer.current == 4 then
            pointer[pointer.current]:moveRight()
        end
        --party[2]:changeStat("MP", 5)
        --partyBars[2][2]:update(party[2].stats.MP)
    end
    if key == 'left' then
        if pointer.current == 4 then
            pointer[pointer.current]:moveLeft()
        end
        --party[2]:changeStat("MP", -5)
        --partyBars[2][2]:update(party[2].stats.MP)
    end
    
    
end

return battle