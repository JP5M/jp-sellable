Config = {}

Config.Shops = {
    ["sandyshop"] = {
        npc = {
            model = "a_m_m_farmer_01",
            position = vector4(1368.2352, 3645.5327, 32.8526, 110.9689)
        },
        blip = {
            enabled = true,
            sprite = 52,
            scale = 0.8,
            color = 5,
            label = "Sandy Pawnshop"
        },
        sellableItems = {
            ["goldchain"] = { price = 500 },
            ["rolex"] = { price = 1000 },
            ["laptop"] = { price = 750 },
            ["phone"] = { price = 300 }
        }
    },
    -- weiterer Shop
}

Config.Debug = true
