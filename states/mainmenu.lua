local mainmenu = {}

function mainmenu:init()

end

function mainmenu:enter()

end

function mainmenu:resume()

end

function mainmenu:leave()

end

function mainmenu:update(dt)

end

function mainmenu:draw()
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.print("ZOOTOPIA\n\nTHE NIGHTHOWLER STONE\n\n" ..
    "\n\n\n\n>PRESS \'Z\' TO START", 16, 16)
end

function mainmenu:keypressed(key)
    if key == 'z' then
        Gamestate.switch(overworld)
    end
end

return mainmenu