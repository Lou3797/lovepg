local pausemenu = {}

local partyBars = {}
local winodwStack = {}
local headerStr = ""
local headerTempStr = ""
local pauseWindows = {
    newWindow(0, 0, 32, 3),
    newWindow(0, 3, 13, 27),
    newWindow(13, 3, 19, 9),
    newWindow(13, 12, 19, 9),
    newWindow(13, 21, 19, 9),
}

function pausemenu:init()

end

function pausemenu:enter()
    love.graphics.setBackgroundColor(0, 0, 0)
    love.graphics.setColor(255, 255, 255)

    partyBars = createPartyBars()

    table.insert(winodwStack, newListWindow(1, 4, 11, 16,
    {
        newMenuItem("ITEM", "VIEW ITEMS IN INVENTORY", winodwStack, openItemWindow),
        newMenuItem("SPELL", "USE/CHECK A SPELL", winodwStack, tempSpells),
        newMenuItem("EQUIP", "", winodwStack, test),
        newMenuItem("STATUS", "CHECK PARTY STATUS", winodwStack, test),
        newMenuItem("PARTY", "", winodwStack, test)
    }, 1, 1))


end

function pausemenu:resume()

end

function pausemenu:leave()
    winodwStack = {}
    headerStr = ""
    headerTempStr = ""
end

function pausemenu:update(dt)
    if #winodwStack == 0 then
        return Gamestate.pop()
    end

    headerStr = winodwStack[#winodwStack]:getCurrentMenuItem().desc

end

function pausemenu:draw()
    --DRAW ALL BASE THE WINDOWS
    for i,v in ipairs(pauseWindows) do
        pauseWindows[i]:draw()
    end
    --DRAW PARTY INFO
    for i,v in ipairs(party) do
        drawPartyMemberInfo(partyBars, i)
    end
    --DRAW THE CURRENT WINDOW STACK
    for i,v in ipairs(winodwStack) do
        winodwStack[i]:draw()
    end
    --DRAW THE HEADER
    love.graphics.print(headerStr..headerTempStr, 8, 8)
end

function pausemenu:keypressed(key)
    local currentWindow = winodwStack[#winodwStack]
    if key == 'return' then
        return Gamestate.pop()
    elseif key == 'x' then
        table.remove(winodwStack, #winodwStack)
    elseif key == 'down' then
        currentWindow:moveDown()
    elseif key == 'up' then
        currentWindow:moveUp()
    elseif key == 'z' then
        currentWindow:execute()
        --headerStr = currentWindow:execute()
    end
end

return pausemenu