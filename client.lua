local QBCore = exports['qb-core']:GetCoreObject()


CreateThread(function()
    local model = Config.NPC.model
    lib.requestModel(model)

    local npc = CreatePed(4, model, Config.NPC.position.xyz, Config.NPC.position.w, false, true)
    SetEntityInvincible(npc, true)
    SetBlockingOfNonTemporaryEvents(npc, true)
    FreezeEntityPosition(npc, true)

    if Config.EnableBlip then
        local blip = AddBlipForCoord(Config.NPC.position.x, Config.NPC.position.y, Config.NPC.position.z)
        SetBlipSprite(blip, Config.PawnshopBlip.sprite)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, Config.PawnshopBlip.scale)
        SetBlipColour(blip, Config.PawnshopBlip.color)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName(Config.PawnshopBlip.label)
        EndTextCommandSetBlipName(blip)
    end

    Wait(500)
    exports.ox_target:addLocalEntity(npc, {
        {
            label = "Sell Items",
            icon = "fa-solid fa-hand-holding-dollar",
            onSelect = function()
                TriggerServerEvent('jp-pawnshop:openMenu')
            end
        }
    })
end)

RegisterNetEvent('jp-pawnshop:showMenu', function(items)
    local options = {}

    table.insert(options, {
        title = "Sell All Items",
        description = "Sell all sellable items in your inventory",
        icon = "fa-solid fa-boxes-packing",
        onSelect = function()
            TriggerServerEvent('jp-pawnshop:sellAll')
        end
    })

    for _, item in ipairs(items) do
        table.insert(options, {
            title = item.label .. " (" .. item.count .. "x)",
            description = "Sell for $" .. (item.price * item.count),
            icon = "fa-solid fa-hand-holding-dollar",
            onSelect = function()
                TriggerServerEvent('jp-pawnshop:sellItem', item.name)
            end
        })
    end

    lib.registerContext({
        id = 'pawnshop_menu',
        title = "Pawnshop",
        options = options
    })

    lib.showContext('pawnshop_menu')
end)