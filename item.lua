function newItem(name, desc, stat, effect)
    local item = {}
    
    item.name = name
    item.desc = desc
    item.stat = stat
    item.effect = effect

    return item
end

items = {
    newItem("POTION", "RESTORE 30 HP\n\nTO ALLY", "HP", 30),
    newItem("ETHER", "RESTORE 15 MP\n\nTO ALLY", "MP", 15)
}