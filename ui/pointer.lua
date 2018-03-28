--[[
    THIS FILE IS TO BE DEPRECATED
]]--

function newPointer(xo, yo, items, dy, menuName)
    local pointer = {}

    pointer.quad = love.graphics.newQuad(8, 24, 16, 16, tiles:getDimensions())
    pointer.current = 1
    pointer.size = items
    pointer.xo = xo
    pointer.yo = yo
    pointer.dy = dy
    pointer.isVisible = true
    pointer.isFocused = true

    function pointer:moveDown()
        if pointer.isFocused and pointer.current+1 <= pointer.size then
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

    return pointer
end

function newEncounterPointer(encounter)
    local pointer = newPointer(0, 0, #encounter.enemies, 1)
    pointer.encounter = encounter
    
    function pointer:moveLeft()
        pointer:moveUp()
    end

    function pointer:moveRight()
        pointer:moveDown()
    end

    function pointer:draw()
        if pointer.isVisible then
            local enemy = pointer.encounter.enemies[pointer.current]
            love.graphics.draw(tiles, pointer.quad, (enemy.xo-1)*8, ((enemy.yo)*8)+((enemy.imgH/2)-8) )
        end
    end

    return pointer
end