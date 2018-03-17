function newPointer(xo, yo, items, dy, menuName)
    local pointer = {}

    pointer.quad = love.graphics.newQuad(8, 24, 16, 16, tiles:getDimensions())
    pointer.current = 1
    pointer.items = items
    pointer.xo = xo
    pointer.yo = yo
    pointer.dy = dy
    pointer.isVisible = true
    pointer.isFocused = true

    function pointer:moveDown()
        if pointer.isFocused and pointer.current+1 <= items then
            pointer.current = pointer.current+1
        end
    end

    function pointer:moveUp()
        if pointer.isFocused and pointer.current-1 > 0 then
            pointer.current = pointer.current-1
        end
    end

    function pointer:draw()
        if pointer.isVisible then
            love.graphics.draw(tiles, pointer.quad, pointer.xo*8, (pointer.yo+(dy*(pointer.current-1)))*8)
        end
    end

    function pointer:select()
        return pointer.current
    end

    function pointer:reset()
        pointer.current = 1
    end

    function pointer:toggle()
        pointer.isVisible = not pointer.isVisible
        pointer.isFocused = not pointer.isFocused
    end

    return pointer
end