local classes = {}
classes["knight"] = {}
classes["rogue"] =  {}

function newPartyMember(name, class, imgX, imgY, stats, moveset)
    local member = {}
    member.name = name
    member.img = love.graphics.newQuad(imgX, imgY, 32, 32, tiles:getDimensions())
    member.class = classes[class]
    member.stats = stats
    member.moveset = moveset
    member.mods = {{}, {}} --{{"AGI", 10}, {"ATK", 15}}


    function member:changeStat(stat, num)
        member.stats[stat] = member.stats[stat] + num
    end

    return member
end