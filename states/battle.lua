--[[
This file is currently using code that will be deprecated and is in need of a massive refactor
]]--

local battle = {}
local stats = party[1]["stats"]
local swapTimer = 0.33
local currentEncounter = {}

local partyBars = {}

local pointer = {
    [1]=newPointer(19, 6, #party, 9),
    [2]=newPointer(20, 15, 6, 2),
    [3]=newPointer(19, 15, 7, 2),
    [5]=newPointer(19, 6, #party, 9),
    ["current"]=1, ["picked"]=1, ["action"]=1, ["subAction"]=1
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

function executeCommand()

end

function battle:init()
    
end

function battle:enter(prevState, encounter)
    partyBars = createPartyBars()
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
        local specialFactor = party[i].stats["AGI"]/2.75
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
    elseif pointer.current == 3 and pointer.action == 4 then
        --tempTipStr = ">"..partyItems[pointer[pointer.current].current][1].name
        tipStr = partyItems[pointer[pointer.current].current][1].desc
        tempTipStr = ""
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
    for i,v in ipairs(party) do
        drawPartyMemberInfo(partyBars, i)
    end

    love.graphics.print(tipStr..tempTipStr, 8, 8)
    love.graphics.print(messageStr, 8, 22*8)
    --love.graphics.print("+AGI", 21*8, 9*8)
    --love.graphics.print("+LCK", 26*8, 9*8)

    --Draw enemy sprites
    currentEncounter:draw()

    if pointer.current ~= 1 then
        pickedBox:draw()
        drawPartyMemberInfo(partyBars, pointer.picked, 0)
    end

    --Display action menu
    if pointer.current == 2 or pointer.current == 4 then
        commandBox:draw()
        love.graphics.print("ATTACK\n\nSPELL\n\nDEFEND\n\nITEM\n\nCHECK\n\nRUN", 22*8, 15*8)

    end

    --Display sub-action menu
    if pointer.current == 3 then
        subActionBox:draw()
        if pointer.action == 4 then
            love.graphics.print("~ITEM~", 20*8, 13*8)
            for i,v in ipairs(partyItems) do
                local item = partyItems[i][1]
                love.graphics.print(item.name, 21*8, ((i*2)+13)*8)
                love.graphics.print("x"..partyItems[i][2], 28*8, ((i*2)+13)*8)
                
            end
            love.graphics.print("1234567890", 21*8, (25)*8)
        elseif pointer.action == 2 then

        end
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
                --Do nothing if percent is less than 100%
            else
                pointer.picked = pointer[pointer.current].current
                pointer.current = 2
            end
            
        elseif pointer.current == 2 then
            pointer.action = pointer[pointer.current].current
            if pointer.action == 4 then
                pointer.current = 3
                pointer[pointer.current]:changeSize(#partyItems)
            elseif pointer.action == 2 then
                --pointer[pointer.current]:changeSize(#partyItems)
                pointer.current = 3
            elseif pointer.action == 1 or pointer.action == 5 then
                pointer.current = 4
                tipStr = tipStr..tempTipStr
            end
            
        end
    --Cancel Action
    elseif key == 'x' then
        if pointer.current == 2 then
            pointer[pointer.current]:reset()
            pointer.current = 1
        elseif pointer.current == 4 then
            pointer[pointer.current]:reset()
            pointer.current = 2
        elseif pointer.current == 3 then
            pointer[pointer.current]:reset()
            pointer.current = 2
        end

    --Pause battle
    elseif key == 'return' then
        Gamestate.push(battlepause)
    

    
    elseif key == 'right' then
        if pointer.current == 4 then
            pointer[pointer.current]:moveRight()
        end

    elseif key == 'left' then
        if pointer.current == 4 then
            pointer[pointer.current]:moveLeft()
        end
    end
    
    
end

return battle