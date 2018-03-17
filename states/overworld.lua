local overworld = {}

function overworld:init()

end

function overworld:enter()

end

function overworld:resume()

end

function overworld:leave()

end

function overworld:update(dt)

end

function overworld:draw()
    love.graphics.setColor(200, 80, 150, 255)
    love.graphics.print("THIS IS A TEST OF MY CUSTOM\n\nNES-STYLED FONT.\n\n"..
    "HOPEFULLY IT LOOKS GOOD!\n\n"..
    "COST 3 MP\n\n" ..
    "REGAINS MP BY ATTACKING.\n\n" ..
    "40 / 69 HP", 8, 8)
end

function overworld:keypressed(key)
    if key == 'return' then
        Gamestate.push(pausemenu)
    end
    if key == 'b' then
        Gamestate.push(battle)
    end
end

return overworld