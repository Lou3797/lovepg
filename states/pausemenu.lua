local pausemenu = {}

local partyBars = {}
local windowStack = {}
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

    table.insert(windowStack, newListWindow(1, 4, 11, 16,
    {
        newMenuItem("ITEMS", "VIEW/USE ITEMS IN INVENTORY", windowStack, openItemWindow),
        newMenuItem("K. ITEMS", "VIEW KEY ITEMS IN INVENTORY", windowStack, test),
        newMenuItem("SPELLS", "CHECK/USE A SPELL", windowStack, tempSpells),
        newMenuItem("EQUIP", nil, windowStack, test),
        newMenuItem("STATUS", "CHECK STATUS OF PARTY MEMBERS", windowStack, statusPointer),
        newMenuItem("CONFIG", "CHANGE GAME SETTINGS", windowStack, openConfig)
    }, 1, 1))


end

function pausemenu:resume()

end

function pausemenu:leave()
    windowStack = {}
    headerStr = ""
    headerTempStr = ""
end

function pausemenu:update(dt)
    if #windowStack == 0 then
        return Gamestate.pop()
    end

    for i,v in ipairs(windowStack) do
        windowStack[i]:update(dt)
    end

    for i,v in ipairs(partyBars) do
        partyBars[i]["HP"]:update(dt)
        partyBars[i]["MP"]:update(dt)
    end

    headerStr = windowStack[#windowStack]:getCurrentMenuItemDesc() or ""

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
    for i,v in ipairs(windowStack) do
        windowStack[i]:draw()
    end
    --DRAW THE HEADER
    love.graphics.print(headerStr..headerTempStr, 8, 8)
end

function pausemenu:keypressed(key)
    local currentWindow = windowStack[#windowStack]
    if key == 'return' then
        return Gamestate.pop()
    elseif key == 'x' then
        currentWindow:cancel(windowStack)
    elseif key == 'down' then
        currentWindow:moveDown()
    elseif key == 'up' then
        currentWindow:moveUp()
    elseif key == 'z' then
        currentWindow:execute()
    end
end

return pausemenu