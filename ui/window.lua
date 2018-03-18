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

function newMenuItem(string, windowStack, execute, objectRef)
    local item = {}

    item.string = string
    item.stack = windowStack
    item.execute = execute
    item.objectRef = objectRef

    return item
end

function newListPointer(x, y, yo, length, dy)
    local pointer = {}

    pointer.quad = love.graphics.newQuad(8, 24, 16, 16, tiles:getDimensions())
    pointer.current = 1
    pointer.length = length
    pointer.x = x
    pointer.y = y
    pointer.yo = yo
    pointer.dy = dy
    pointer.isVisible = true
    pointer.isFocused = true
    pointer.timer = 0.25

    function pointer:moveDown()
        if pointer.isFocused and pointer.current+1 <= pointer.length then
            pointer.current = pointer.current+1
        end
    end

    function pointer:moveUp()
        if pointer.isFocused and pointer.current-1 > 0 then
            pointer.current = pointer.current-1
        end
    end

    function pointer:reset()
        pointer.current = 1
    end

    function pointer:toggle()
        pointer.isVisible = not pointer.isVisible
        pointer.isFocused = not pointer.isFocused
    end

    function pointer:changeSize(len)
        pointer:reset()
        pointer.size = len
    end

    function pointer:update(dt)

    end

    function pointer:draw()
        if pointer.isVisible then
            love.graphics.draw(tiles, pointer.quad, (pointer.x)*8, ((1+pointer.y+pointer.yo)+(dy*(pointer.current-1)))*8)
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
    popup.cursorOnly = cursorOnly
    popup.xo = xo
    popup.yo = yo
    popup.name = name
    popup.pointer = newListPointer(x, y, yo, #list, 2)
    popup.window = newWindow(x, y, w, h)

    function popup:setList(list)
        popup.list = list
    end

    function popup:getCurrentMenuItem(n)
        return popup.list[popup.pointer.current]
    end

    function popup:execute(param)
        local currentMenuItem = popup:getCurrentMenuItem()
        if param == nil then
            return currentMenuItem:execute(currentMenuItem) or "NO_PARAM+RETURN"
        else
            return currentMenuItem:execute(param) or "NO_RETURN"
        end
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
        popup.window:draw()

        --PRINTING THE LIST
        for i,v in ipairs(popup.list) do
            love.graphics.print(popup.list[i].string, (1+popup.x+popup.xo)*8, (1+((i-1)*2)+popup.y+popup.yo)*8)
        end

        --DRAWING THE CURSOR
        popup.pointer:draw()
    end

    return popup
end

function newStringListWindow()

end