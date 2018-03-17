function newEnemy(name, xo, yo, imgX, imgY, imgW, imgH, stats, moveset)
    local enemy = {}

    enemy.name = name
    enemy.xo = xo
    enemy.yo = yo
    enemy.img = love.graphics.newQuad(imgX, imgY, imgW, imgH, tiles:getDimensions())
    enemy.stats = stats
    enemy.moveset = moveset
    enemy.mods = {{}, {}}

    return enemy
end

function newEncounter(enemies)
    local encounter = {}
    
    encounter.enemies = enemies

    function encounter:draw()
        for i,v in ipairs(encounter.enemies) do
            local enemy = encounter.enemies[i]
            love.graphics.draw(tiles, enemy.img, 8*enemy.xo, 8*enemy.yo)
        end
    end

    return encounter
end