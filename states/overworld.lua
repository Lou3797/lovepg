local overworld = {}

function overworld:init()

end

function overworld:enter()

end

function overworld:leave()

end

function overworld:update(dt)

end

function overworld:draw()
    love.graphics.setColor(200, 80, 150, 255)
    love.graphics.print("Overworld", 0, 0)
end

function overworld:keypressed(key)
    if key == 'c' then
        Gamestate.switch(pausemenu)
    end
end

return overworld