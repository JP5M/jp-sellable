local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('jp-pawnshop:openMenu')
AddEventHandler('jp-pawnshop:openMenu', function()
    local src = source
    if Config.Debug then print("[DEBUG] Pawnshop menu requested by:", src) end

    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then
        print("Error: Player not found!")
        return
    end

    local items = {}

    for itemName, data in pairs(Config.SellableItems) do
        if Config.Debug then print("[DEBUG] Checking item:", itemName) end
        local itemCount = Player.Functions.GetItemByName(itemName)
        if itemCount then
            if Config.Debug then print("[DEBUG] Item exists:", itemName, "Amount:", itemCount.amount) end
        end

        if itemCount and itemCount.amount > 0 then
            table.insert(items, {
                name = itemName,
                label = QBCore.Shared.Items[itemName].label,
                count = itemCount.amount,
                price = data.price
            })
        end
    end

    if Config.Debug then print("[DEBUG] Final item list:", json.encode(items)) end

    if #items == 0 then
        TriggerClientEvent('QBCore:Notify', src, "You have no sellable items!", "error")
        return
    end

    TriggerClientEvent('jp-pawnshop:showMenu', src, items)
end)

RegisterServerEvent('jp-pawnshop:sellItem')
AddEventHandler('jp-pawnshop:sellItem', function(item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local itemData = Config.SellableItems[item]

    if itemData then
        local itemCount = Player.Functions.GetItemByName(item)?.amount or 0
        if itemCount > 0 then
            local price = itemData.price * itemCount
            Player.Functions.RemoveItem(item, itemCount)
            Player.Functions.AddMoney('cash', price)
            TriggerClientEvent('QBCore:Notify', src, "You sold " .. itemCount .. "x " .. item .. " for $" .. price, "success")
        else
            TriggerClientEvent('QBCore:Notify', src, "You don't have this item!", "error")
        end
    else
        TriggerClientEvent('QBCore:Notify', src, "This item cannot be sold!", "error")
    end
end)

RegisterServerEvent('jp-pawnshop:sellAll')
AddEventHandler('jp-pawnshop:sellAll', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local totalEarnings = 0

    for item, data in pairs(Config.SellableItems) do
        local itemCount = Player.Functions.GetItemByName(item)?.amount or 0
        if itemCount > 0 then
            local price = data.price * itemCount
            Player.Functions.RemoveItem(item, itemCount)
            Player.Functions.AddMoney('cash', price)
            totalEarnings = totalEarnings + price
        end
    end

    if totalEarnings > 0 then
        TriggerClientEvent('QBCore:Notify', src, "You sold all sellable items for $" .. totalEarnings, "success")
    else
        TriggerClientEvent('QBCore:Notify', src, "No items to sell!", "error")
    end
end)
