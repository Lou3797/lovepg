--[[
    THIS FILE IS TO BE DEPRECATED
]]--
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

function newMenuBox(x, y, w, h)
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