--{  {ID, x}, {ID, x}, {ID, x}  }
function initInventory()
    local inv = {}

    function inv:add(item, num)
        if inv:getIndex(item) == 0 then
            table.insert(inv, {item, num})
        else
            inv[inv:getIndex(item)][2] = inv[inv:getIndex(item)][2] + num
        end
    end

    function inv:sub(item, num)
        if inv:getIndex(item) ~= 0 then
            if inv[inv:getIndex(item)][2] - num < 0 then
                return false
            elseif inv[inv:getIndex(item)][2] - num == 0 then
                table.remove(inv, inv:getIndex(item))
                return true
            else
                inv[inv:getIndex(item)][2] = inv[inv:getIndex(item)][2] - num
                return true
            end            
        end
        return false
    end

    function inv:getIndex(item)
        for i,v in ipairs(inv) do
            if inv[i] ~= nil then
                if inv[i][1] == item then
                    return i
                end
            end
        end
        return 0
    end

    return inv
end

function newItem(name, desc, stat, effect, func)
    local item = {}
    
    item.name = name
    item.desc = desc
    item.stat = stat
    item.effect = effect
    item.execute = func
    --item.type = battle, menu, or both

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
    menuItem.objectRef:restoreStat("HP", "MHP", 30)
    partyItems:sub(items[1], 1)
    refreshItemWindow(menuItem)
end

function useEther(menuItem, ...) --menuItem, partyMember, item(?)
    menuItem.objectRef:restoreStat("MP", "MMP", 15)
    partyItems:sub(items[2], 1)
    refreshItemWindow(menuItem)
end

items = {
    --1
    newItem("POTION", "RESTORE 30 HP TO ALLY", "HP", 30, usePotion),
    --2
    newItem("ETHER", "RESTORE 15 MP TO ALLY", "MP", 15, useEther),
    --3
    newItem("B.BERRY", "REMOVE ALL MODIFIERS TO ALLY", "ALL", 0, test),
    --4
    newItem("SERUM", "REVIVE FALLEN ALLY W/ 50% HP", "MP", 15, test),
    --5
    newItem("SERUM", "REVIVE FALLEN ALLY W/ 50% HP", "MP", 15, test)
}