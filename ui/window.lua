local menuQuads = {}
menuQuads.tl = love.graphics.newQuad(0, 0, 8, 8, tiles:getDimensions())
menuQuads.tc = love.graphics.newQuad(8, 0, 8, 8, tiles:getDimensions())
menuQuads.tr = love.graphics.newQuad(16, 0, 8, 8, tiles:getDimensions())
menuQuads.cl = love.graphics.newQuad(0, 8, 8, 8, tiles:getDimensions())
menuQuads.cc = love.graphics.newQuad(8, 8, 8, 8, tiles:getDimensions())
menuQuads.cr = love.graphics.newQuad(16, 8, 8, 8, tiles:getDimensions())
menuQuads.bl = love.graphics.newQuad(0, 16, 8, 8, tiles:getDimensions())
menuQuads.bc = love.graphics.newQuad(8, 16, 8, 8, tiles:getDimensions())
menuQuads.br = love.graphics.newQuad(16, 16, 8, 8, tiles:getDimensions())

local pointerQuad = love.graphics.newQuad(8, 24, 16, 16, tiles:getDimensions())

function adjustForName(yo, name)
    if name == nil then return yo
    else return yo+1, name end
end

function calculateDisplaySize(h, yo)
    return math.floor((h-2-yo)/2)
end

function newMenuItem(string, desc, windowStack, execute, objectRef)
    local item = {}

    item.string = string
    item.desc = desc
    item.stack = windowStack
    item.execute = execute
    item.objectRef = objectRef

    return item
end

function newListPointer(x, y, yo, length, dy)
    local pointer = {}

    pointer.current = 1
    pointer.length = length
    pointer.x = x
    pointer.y = y
    pointer.yo = yo
    pointer.dy = dy
    pointer.isVisible = true
    pointer.isFocused = true
    pointer.timer = 0.30

    function pointer:moveDown()
        if pointer.isFocused and pointer.current+1 <= pointer.length then
            pointer.current = pointer.current+1
            return true
        end
        return false
    end

    function pointer:moveUp()
        if pointer.isFocused and pointer.current-1 > 0 then
            pointer.current = pointer.current-1
            return true
        end
        return false
    end

    function pointer:reset()
        pointer.current = 1
    end

    function pointer:setFocused(bool)
        pointer.isFocused = bool
    end

    function pointer:changeSize(len)
        pointer:reset()
        pointer.size = len
    end

    function pointer:execute(currentMenuItem, ...)
        return currentMenuItem:execute(currentMenuItem, ...)  or "NO_RET"
    end

    function pointer:update(dt)
        if not pointer.isFocused then
            pointer.timer = pointer.timer-dt
            if pointer.timer <= 0 then
                pointer.timer = 0.30
                pointer.isVisible = not pointer.isVisible
            end
        else
            pointer.isVisible = true
        end
    end

    function pointer:draw(viewShift)
        if pointer.isVisible then
            love.graphics.draw(tiles, pointerQuad, (pointer.x)*8, ((1+pointer.y+pointer.yo)+(pointer.dy*(pointer.current-1-viewShift)))*8)
        end
    end

    return pointer
end

function newWindow(x, y, w, h)
    local menubox = {}
    menubox.x = x --Multiply by 8 for actual coordinates
    menubox.y = y --Multiply by 8 for actual coordinates
    menubox.w = w --Multiply by 8 for actual width
    menubox.h = h --Multiply by 8 for actual height

    function menubox:draw()
        --Draw the left tiles
        love.graphics.draw(tiles, menuQuads.tl, (menubox.x*8), (menubox.y*8))
        for i=1,menubox.h-2 do
            love.graphics.draw(tiles, menuQuads.cl, (menubox.x*8), ((menubox.y+i)*8))
        end
        love.graphics.draw(tiles, menuQuads.bl, (menubox.x*8), ((menubox.y+menubox.h-1)*8))
        --Draw the center tiles
        for i=1,menubox.w-2 do
            love.graphics.draw(tiles, menuQuads.tc, ((menubox.x+i)*8), (menubox.y*8))
            for j=1,menubox.h-2 do
                love.graphics.draw(tiles, menuQuads.cc, ((menubox.x+i)*8), ((menubox.y+j)*8))
            end
            love.graphics.draw(tiles, menuQuads.bc, ((menubox.x+i)*8), ((menubox.y+menubox.h-1)*8))
        end
        --Draw the right tiles
        love.graphics.draw(tiles, menuQuads.tr, ((menubox.x+menubox.w-1)*8), (menubox.y*8))
        for i=1,menubox.h-2 do
            love.graphics.draw(tiles, menuQuads.cr, ((menubox.x+menubox.w-1)*8), ((menubox.y+i)*8))
        end
        love.graphics.draw(tiles, menuQuads.br, ((menubox.x+menubox.w-1)*8), ((menubox.y+menubox.h-1)*8))
    end

    return menubox
end

function newListWindow(x, y, w, h, list, xo, yo, name)
    local popup = {}

    popup.x = x
    popup.y = y
    popup.w = w
    popup.h = h
    popup.list = list
    popup.xo = xo
    popup.yo, popup.name = adjustForName(yo, name)
    popup.pointer = newListPointer(x, y, popup.yo, #list, 2)
    popup.window = newWindow(x, y, w, h)
    popup.viewShift = 0
    popup.viewSize = calculateDisplaySize(popup.h, popup.yo)

    function popup:setList(list)
        popup.list = list
        popup.viewSize = calculateDisplaySize(popup.h, popup.yo)
    end

    function popup:getCurrentMenuItem()
        return popup.list[popup.pointer.current]
    end

    function popup:execute(...)
        local arg = {...}
        local currentMenuItem = popup:getCurrentMenuItem()
        return popup.pointer:execute(currentMenuItem, ...)
    end

    function popup:reset()
        popup.pointer:reset()
    end

    function popup:moveDown()
        if popup.pointer:moveDown() then
            if popup.pointer.current - popup.viewShift > popup.viewSize then
                popup.viewShift = popup.viewShift+1
            end
        end
    end

    function popup:moveUp()
        if popup.pointer:moveUp() then
            if popup.pointer.current <= popup.viewShift then
                popup.viewShift = popup.viewShift-1
            end
        end
       
    end

    function popup:update(dt)
        popup.pointer:update(dt)
    end

    function popup:draw()
        popup.window:draw()

        --PRINTING THE LIST NAME
        if popup.name ~= nil then
            love.graphics.print("~"..popup.name.."~", (x+xo)*8, (y+yo)*8)
        end

        --PRINTING THE LIST ITEMS
        local limit = popup.viewShift+popup.viewSize
        if limit > #popup.list then
            limit = #popup.list
        end
        for i=1+popup.viewShift,limit do
            love.graphics.print(popup.list[i].string, (1+popup.x+popup.xo)*8, (1+((i-1)*2)+popup.y+popup.yo-(popup.viewShift*2))*8)
        end

        --DRAWING THE CURSOR
        popup.pointer:draw(popup.viewShift)

        --DRAW LIST ARROWS
        if popup.viewShift > 0 then
            love.graphics.print("^", (popup.x+popup.w-2)*8, (popup.y+popup.yo)*8)
        end
        if popup.viewShift + popup.viewSize < #popup.list then
            love.graphics.print("v", (popup.x+popup.w-2)*8, (popup.y+popup.h-2)*8)
        end

    end

    return popup
end

function newClearWindow(x, y, list, yo, dy)
    local popup = {}

    popup.x = x
    popup.y = y
    popup.list = list
    popup.yo = yo
    popup.pointer = newListPointer(x, y, popup.yo, #list, dy)

    function popup:setList(list)
        popup.list = list
    end

    function popup:getCurrentMenuItem()
        return popup.list[popup.pointer.current]
    end

    function popup:execute(...)
        local arg = {...}
        local currentMenuItem = popup:getCurrentMenuItem()
        return popup.pointer:execute(currentMenuItem, ...)
    end

    function popup:reset()
        popup.pointer:reset()
    end

    function popup:moveDown()
        popup.pointer:moveDown()
    end

    function popup:moveUp()
        popup.pointer:moveUp()
       
    end

    function popup:update(dt)
        popup.pointer:update(dt)
    end

    function popup:draw()
        --DRAWING THE CURSOR
        popup.pointer:draw(0)
    end

    return popup
end

function newStatsWindow(partyMember, windowStack)
    local popup = {}
    popup.window = newWindow(0, 3, 32, 27)
    popup.partyMember = partyMember
    popup.stack = windowStack

    function popup:execute(...)
        closeTopWindow(popup.stack)
    end

    function popup:moveDown()
    end

    function popup:moveUp()       
    end

    function popup:update(dt)

    end

    function popup:getCurrentMenuItem()
        temp = {}
        temp.desc = partyMember.desc
        return temp
    end

    function popup:draw()
        popup.window:draw()
        displayPartyMemberStat(popup.partyMember)
        love.graphics.draw(tiles, pointerQuad, 0, 27*8)
    end

    return popup
end
