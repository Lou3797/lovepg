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
    love.graphics.setBackgroundColor(50, 50, 50)
    love.graphics.setColor(255, 255, 255)
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
        Gamestate.push(battle,
        newEncounter({
        newEnemy("TEST1", 3, 8, 0, 40, 32, 32), 
        newEnemy("TEST2", 8, 8, 0, 72, 32, 32), 
        newEnemy("TEST3", 13, 8, 0, 104, 32, 32)
    }))
    end
end

return overworld