local QBCore = exports['qb-core']:GetCoreObject()

CreateThread(function()
    for shopId, shop in pairs(Config.Shops) do
        lib.requestModel(shop.npc.model)

        local npc = CreatePed(4, shop.npc.model, shop.npc.position.xyz, shop.npc.position.w, false, true)
        SetEntityInvincible(npc, true)
        SetBlockingOfNonTemporaryEvents(npc, true)
        FreezeEntityPosition(npc, true)

        if shop.blip.enabled then
            local blip = AddBlipForCoord(shop.npc.position.x, shop.npc.position.y, shop.npc.position.z)
            SetBlipSprite(blip, shop.blip.sprite)
            SetBlipDisplay(blip, 4)
            SetBlipScale(blip, shop.blip.scale)
            SetBlipColour(blip, shop.blip.color)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentSubstringPlayerName(shop.blip.label)
            EndTextCommandSetBlipName(blip)
        end

        Wait(500)
        exports.ox_target:addLocalEntity(npc, {
            {
                label = "Sell Items",
                icon = "fa-solid fa-hand-holding-dollar",
                onSelect = function()
                    TriggerServerEvent('jp-sellable:openMenu', shopId)
                end
            }
        })
    end
end)

RegisterNetEvent('jp-sellable:showMenu', function(items, shopId)
    local options = {}

    table.insert(options, {
        title = "Sell All Items",
        description = "Sell all sellable items in your inventory",
        icon = "fa-solid fa-boxes-packing",
        onSelect = function()
            TriggerServerEvent('jp-sellable:sellAll', shopId)
        end
    })

    for _, item in ipairs(items) do
        table.insert(options, {
            title = item.label .. " (" .. item.count .. "x)",
            description = "Sell for $" .. (item.price * item.count),
            icon = "fa-solid fa-hand-holding-dollar",
            onSelect = function()
                TriggerServerEvent('jp-sellable:sellItem', item.name, shopId)
            end
        })
    end

    lib.registerContext({
        id = 'pawnshop_menu_' .. shopId,
        title = Config.Shops[shopId].blip.label or "Pawnshop",
        options = options
    })

    lib.showContext('pawnshop_menu_' .. shopId)
end)
