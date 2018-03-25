function newItem(name, desc, stat, effect, func)
    local item = {}
    
    item.name = name
    item.desc = desc
    item.stat = stat
    item.effect = effect
    item.execute = func

    return item
end

--EXECUTE MENU ITEM: POTION:execute()
--pick party memeber
--party member menu item:execute()
--apply item effect to party member

function increaseStat(menuItem, ...) --menuItem, partyMember, item(?)
    --If gamestate == battle or pausemenu
    --Pick a party member to apply effect to
    --partyMember:modifyStat(stat, num)
    
end

function usePotion(menuItem, ...) --menuItem, partyMember, item(?)
    --local arg = {...}
    menuItem.objectRef.stats["HP"] = menuItem.objectRef.stats["HP"] + 30
    closeTopWindow(menuItem.stack)
    --If gamestate == battle or pausemenu
    --Pick a party member to apply effect to
    --partyMember:modifyStat(stat, num)
    
end

items = {
    newItem("POTION", "RESTORE 30 HP TO ALLY.", "HP", 30, usePotion),
    newItem("ETHER", "RESTORE 15 MP TO ALLY.", "MP", 15),
    newItem("B.BERRY", "REMOVE ALL MODIFIERS TO ALLY.", "ALL", 0),
    newItem("SERUM", "REVIVE FALLEN ALLY W/ 50% HP.", "MP", 15)
}