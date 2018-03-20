function test()
    return "TESTING THIS MENU ITEM"
end

function testItem()
    return "USING THIS ITEM"
end

function createItemsList(windowStack)
    local menuItems = {}

    for i,v in ipairs(partyItems) do
        local item = partyItems[i]
        local displayString = item[1].name
        local spacing = 7 - string.len(displayString)
        for j=1,spacing do
            displayString = displayString.." "
        end
        displayString = displayString.."x"..item[2]
        table.insert(menuItems, newMenuItem(
            displayString, item[1].desc, windowStack, testItem, item[1]
        ))
    end

    return menuItems
end

function openItemWindow(menuItem, ...)
    local arg = {...}
    table.insert(menuItem.stack, newListWindow(0, 3, 13, 18, createItemsList(menuItem.stack), 1, 1, menuItem.string))
    return "???"
end

function tempSpells(menuItem, ...)
    table.insert(menuItem.stack, newListWindow(0, 3, 13, 18,
    {
        newMenuItem("ITEM1", "ITEM1", menuItem.stack, test),
        newMenuItem("ITEM2", "ITEM2", menuItem.stack, test),
        newMenuItem("ITEM3", "ITEM3", menuItem.stack, test),
        newMenuItem("ITEM4", "ITEM4", menuItem.stack, test),
        newMenuItem("ITEM5", "ITEM5", menuItem.stack, test),
        newMenuItem("ITEM6", "ITEM6", menuItem.stack, test),
        newMenuItem("ITEM7", "ITEM7", menuItem.stack, test),
        newMenuItem("ITEM8", "ITEM8", menuItem.stack, test),
        newMenuItem("ITEM9", "ITEM9", menuItem.stack, test),
        newMenuItem("ITEM0", "ITEM0", menuItem.stack, test)
    }, 1, 1, menuItem.string))

end