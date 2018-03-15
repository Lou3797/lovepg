local pausemenu = {}

function pausemenu:init()

end

function pausemenu:enter()

end

function pausemenu:leave()

end

function pausemenu:update(dt)

end

function pausemenu:draw()
    love.graphics.setColor(30, 220, 200, 255)
    love.graphics.print("Paused", 100, 220)
end

function pausemenu:keypressed(key)
    if key == 'x' or key == 'c' then
        Gamestate.switch(overworld)

    end
end

return pausemenu