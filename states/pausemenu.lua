local pausemenu = {}

local headerStr = ""
local pauseWindows = {
    newWindow(0, 0, 32, 3),
    newWindow(0, 21, 13, 9),
    newWindow(13, 3, 19, 9),
    newWindow(13, 12, 19, 9),
    newWindow(13, 21, 19, 9),
    newWindow(0, 3, 13, 18)
}

local winodwStack = {}

function pausemenu:init()

end

function pausemenu:enter()
    love.graphics.setBackgroundColor(120, 120, 120)
    love.graphics.setColor(255, 255, 255)
    table.insert(winodwStack, newListWindow(1, 4, 11, 16, {"SPELL","ITEM","EQUIP","STATUS"}, 1, 1))
end

function pausemenu:resume()

end

function pausemenu:leave()

end

function pausemenu:update(dt)
    if table.getn(winodwStack) == 0 then
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
    if key == 'return' then
        return Gamestate.pop()
    elseif key == 'x' then
        table.remove(winodwStack, table.getn(winodwStack))
    elseif key == 'down' then
        winodwStack[table.getn(winodwStack)]:moveDown()
    elseif key == 'up' then
        winodwStack[table.getn(winodwStack)]:moveUp()
    elseif key == 'z' then
       headerStr = winodwStack[table.getn(winodwStack)]:select()
       table.insert(winodwStack, newListWindow(0, 3, 13, 18, {"LOLWAT"}, 1, 1))
    end
end

return pausemenu