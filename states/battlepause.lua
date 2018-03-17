local battlepause = {}

function battlepause:init()

end

function battlepause:enter()

end

function battlepause:resume()

end

function battlepause:leave()

end

function battlepause:update(dt)

end

function battlepause:draw()
    love.graphics.setBackgroundColor(0, 0, 0)
    love.graphics.setColor(225, 225, 225)
    love.graphics.print("~PAUSED~", 12*8, 14*8)
end

function battlepause:keypressed(key)
    if key == 'x' or key == 'return' then
        return Gamestate.pop()
    end
end

return battlepause