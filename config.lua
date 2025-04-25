Config = {}

Config.Shops = {
    ["sandyshop"] = { -- unique shop id
        npc = {
            model = "a_m_m_farmer_01", -- npc model
            position = vector4(1368.2352, 3645.5327, 32.8526, 110.9689) -- npc position
        },
        blip = {
            enabled = true, -- wheter or not to show the blip
            sprite = 52, -- https://docs.fivem.net/docs/game-references/blips/#blip-sprite
            scale = 0.8, -- blip scale
            color = 5, -- https://docs.fivem.net/docs/game-references/blips/#blip-colors
            label = "Sandy Pawnshop" -- blip label
        },
        sellableItems = {
            ["goldchain"] = { price = 500 }, -- item spawn name and its price
            ["rolex"] = { price = 1000, maxprice = 1500 }, -- optional maxprice for random price between minprice and maxprice
            ["laptop"] = { price = 750 },
            ["phone"] = { price = 300 }
        }
    },
    -- more shops
}

Config.Debug = true
