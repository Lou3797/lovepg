function newItem(name, desc, stat, effect)
    local item = {}
    
    item.name = name
    item.desc = desc
    item.stat = stat
    item.effect = effect

    return item
end

items = {
    newItem("POTION", "RESTORE 30 HP TO ALLY.", "HP", 30),
    newItem("ETHER", "RESTORE 15 MP TO ALLY.", "MP", 15),
    newItem("B.BERRY", "REMOVE ALL MODIFIERS TO ALLY.", "ALL", 0),
    newItem("SERUM", "REVIVE FALLEN ALLY W/ 50% HP.", "MP", 15)
}