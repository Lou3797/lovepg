function fillBarQuads(row)
    local bar = {}
    for i=0,8 do
        bar[i] = love.graphics.newQuad((4+i)*8, (7+row)*8, 8, 8, tiles:getDimensions())
    end
    return bar
end

local bars = {} --The different type of bars that can be used
bars[0] = fillBarQuads(0)
bars[1] = fillBarQuads(1)
bars[2] = fillBarQuads(2)
bars[3] = fillBarQuads(3)
bars[4] = fillBarQuads(4)
bars[5] = fillBarQuads(5)

function newBar(max, cur, len, row)
    local bar = {}
    bar.max = max
    bar.current = cur
    bar.length = len or 9
    bar.row = row or 0

    function bar:update(cur, max)
        bar.current = cur
        bar.max = max or bar.max
    end

    function bar:changeRow(row)
        bar.row = row
    end

    function bar:draw(x,y)
        local fill = math.ceil((bar.current/bar.max)*(9*bar.length))
        local i=0
        --Draw full bar segments
        while fill-9>=0 do
            love.graphics.draw(tiles, bars[bar.row][8], x+(i*8), y)
            fill = fill-9
            i=i+1
        end
        if fill~=0 then
            love.graphics.draw(tiles, bars[bar.row][fill], x+(i*8), y)
            i=i+1
        end
        for j=i,bar.length-1 do
            love.graphics.draw(tiles, bars[bar.row][0], x+(j*8), y)
        end
        
    end

    function bar:swapRow()
        if bar.row == 4 then
            bar.row = 5
        elseif bar.row == 5 then
            bar.row = 4
        end
    end

    function bar:getPercent()
        return math.ceil((bar.current/bar.max)*100)
    end

    return bar
end