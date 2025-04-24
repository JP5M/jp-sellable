
# jp-sellable

A modular sell shop system for FiveM using QBCore. Supports multiple NPC-based shops, each with their own sellable items and settings.

## Usage

1. **Add the resource:**
   ```cfg
   ensure jp-sellable
   ```

2. **Create shop entries in `config.lua`:**
   ```lua
   Config.Shops = {
       ["grovestreet"] = {
           npc = {
               model = "a_m_m_business_01",
               position = vector4(123.4, -456.7, 29.3, 90.0)
           },
           blip = {
               enabled = true,
               sprite = 52,
               scale = 0.8,
               color = 2,
               label = "Grove Pawnshop"
           },
           sellableItems = {
               ["rolex"] = { price = 1000 },
               ["laptop"] = { price = 800 }
           }
       }
   }
   ```

3. **Players interact via `ox_target`**, triggering:
   - `jp-sellable:openMenu` → opens the sell menu
   - `jp-sellable:sellItem` → sells a specific item
   - `jp-sellable:sellAll` → sells all available sellable items

## License

MIT License
