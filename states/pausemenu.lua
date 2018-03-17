local pausemenu = {}

function pausemenu:init()

end

function pausemenu:enter()

end

function pausemenu:resume()

end

function pausemenu:leave()

end

function pausemenu:update(dt)

end

function pausemenu:draw()
    love.graphics.setColor(30, 220, 200, 255)
    love.graphics.print("PAUSED", 100, 220)
end

function pausemenu:keypressed(key)
    if key == 'x' or key == 'return' then
        return Gamestate.pop()
    end
end

return pausemenu