function unfocusPointer(menuItem)
    menuItem.stack[#menuItem.stack].pointer:setFocused(false)
end

function closeTopWindow(windowStack)
    if #windowStack-1>0 then
        windowStack[#windowStack-1].pointer:setFocused(true)
    end
    table.remove(windowStack, #windowStack)
end

function test()
    return "TESTING THIS MENU ITEM"
end

function testItem()
    return "USING THIS ITEM"
end

function changeScaleOne(menuItem, ...)
    scale = 1
    love.window.setMode(window.width, window.height, 
    {resizable=false, vsync=true, minwidth=window.width*scale, minheight=window.height*scale})
    --closeTopWindow(menuItem.stack)
end

function changeScaleTwo(menuItem, ...)
    scale = 2
    love.window.setMode(window.width, window.height, 
    {resizable=false, vsync=true, minwidth=window.width*scale, minheight=window.height*scale})
    --closeTopWindow(menuItem.stack)
end

function changeScaleThree(menuItem, ...)
    scale = 3
    love.window.setMode(window.width, window.height, 
    {resizable=false, vsync=true, minwidth=window.width*scale, minheight=window.height*scale})
    --closeTopWindow(menuItem.stack)
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

function statusPointer(menuItem, ...)
    unfocusPointer(menuItem)
    local menuItems = {}
    for i,v in ipairs(party) do
        menuItems[i] = newMenuItem(party[i].name, "STATUS>"..party[i].name, menuItem.stack, openStatusWindow, party[i])
    end

    table.insert(menuItem.stack, newClearWindow(13, 3,
    menuItems, 3, 9))
end

function openConfig(menuItem, ...)
    unfocusPointer(menuItem)
    table.insert(menuItem.stack, newListWindow(13, 3, 19, 27,
    {
        newMenuItem("WINDOW SIZE", "CHANGE WINDOW SIZE", menuItem.stack, openWindowScaling)
    }, 1, 1, menuItem.string))
end

function openWindowScaling(menuItem, ...)
    unfocusPointer(menuItem)
    table.insert(menuItem.stack, newListWindow(15, 8, 11, 10,
    {
        newMenuItem("256x240", "SCALE WINDOW x1", menuItem.stack, changeScaleOne),
        newMenuItem("512x480", "SCALE WINDOW x2", menuItem.stack, changeScaleTwo),
        newMenuItem("768x720", "SCALE WINDOW x3", menuItem.stack, changeScaleThree)
    }, 1, 1))
end

function openStatusWindow(menuItem, ...)
    table.insert(menuItem.stack, newStatsWindow(menuItem.objectRef))
end