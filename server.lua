local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('jp-sellable:openMenu')
AddEventHandler('jp-sellable:openMenu', function(shopId)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    local shop = Config.Shops[shopId]
    if not shop then return end

    local items = {}

    for itemName, data in pairs(shop.sellableItems) do
        local itemCount = Player.Functions.GetItemByName(itemName)
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

    TriggerClientEvent('jp-sellable:showMenu', src, items, shopId)
end)

RegisterServerEvent('jp-sellable:sellItem')
AddEventHandler('jp-sellable:sellItem', function(item, shopId)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local shop = Config.Shops[shopId]
    if not shop then return end

    local itemData = shop.sellableItems[item]
    if itemData then
        local count = Player.Functions.GetItemByName(item)?.amount or 0
        if count > 0 then
            local unitPrice = itemData.price
            if itemData.maxprice then
                unitPrice = math.min(unitPrice, itemData.maxprice)
            end
            local price = unitPrice * count
            Player.Functions.RemoveItem(item, count)
            Player.Functions.AddMoney('cash', price)
            TriggerClientEvent('QBCore:Notify', src, "You sold " .. count .. "x " .. item .. " for $" .. price, "success")
        else
            TriggerClientEvent('QBCore:Notify', src, "You don't have this item!", "error")
        end
    else
        TriggerClientEvent('QBCore:Notify', src, "This item cannot be sold!", "error")
    end
end)

RegisterServerEvent('jp-sellable:sellAll')
AddEventHandler('jp-sellable:sellAll', function(shopId)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local shop = Config.Shops[shopId]
    if not shop then return end

    local total = 0

    for item, data in pairs(shop.sellableItems) do
        local count = Player.Functions.GetItemByName(item)?.amount or 0
        if count > 0 then
            local unitPrice = data.price
            if data.maxprice then
                unitPrice = math.min(unitPrice, data.maxprice)
            end
            local price = unitPrice * count
            Player.Functions.RemoveItem(item, count)
            Player.Functions.AddMoney('cash', price)
            total = total + price
        end
    end

    if total > 0 then
        TriggerClientEvent('QBCore:Notify', src, "You sold all items for $" .. total, "success")
    else
        TriggerClientEvent('QBCore:Notify', src, "No items to sell!", "error")
    end
end)
