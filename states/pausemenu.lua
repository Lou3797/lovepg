local pausemenu = {}

local winodwStack = {}
local headerStr = ""
local pauseWindows = {
    newWindow(0, 0, 32, 3),
    --newWindow(0, 21, 13, 9),
    newWindow(0, 3, 13, 27),
    newWindow(13, 3, 19, 9),
    newWindow(13, 12, 19, 9),
    newWindow(13, 21, 19, 9),
    --newWindow(0, 3, 13, 18)
}

function test()
    return "TESTING THIS MENU ITEM"
end

function pausemenu:init()

end

function pausemenu:enter()
    love.graphics.setBackgroundColor(0, 0, 0)
    love.graphics.setColor(255, 255, 255)
    --table.insert(winodwStack, newListWindow(1, 4, 11, 16, {"SPELL","ITEM","EQUIP","STATUS"}, 1, 1))
    table.insert(winodwStack, newListWindow(1, 4, 11, 16,
    {
        newMenuItem("SPELL", winodwStack, test),
        newMenuItem("ITEM", winodwStack, openItemWindow),
        newMenuItem("EQUIP", winodwStack, test),
        newMenuItem("STATUS", winodwStack, test),
        newMenuItem("PARTY", winodwStack, test)
    }, 1, 1))
end

function pausemenu:resume()

end

function pausemenu:leave()
    winodwStack = {}
    headerStr = ""
end

function pausemenu:update(dt)
    if #winodwStack == 0 then
        return Gamestate.pop()
    end

end

function pausemenu:draw()
    for i,v in ipairs(pauseWindows) do
        pauseWindows[i]:draw()
    end
    for i,v in ipairs(winodwStack) do
        winodwStack[i]:draw()
    end

    love.graphics.print(headerStr, 8, 8)
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
        --currentWindow:execute()
        headerStr = currentWindow:execute()
        --table.insert(winodwStack, newListWindow(0, 3, 13, 18, {"LOLWAT"}, 1, 1))
    end
end

return pausemenu