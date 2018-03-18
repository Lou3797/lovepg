function test()
    return "TESTING THIS MENU ITEM"
end

function openItemWindow(menuItem, ...)
    local arg = {...}
    table.insert(menuItem.stack, newListWindow(0, 3, 13, 18, {newMenuItem("TEST", menuItem.stack, test)}, 1, 1))
    return "???"
end