local function dupeOre(ore_item)
    local dupe = {
        name = "space-inside-dupe-" .. ore_item.name,
        enabled = true,
        type = "recipe",
        icons = ore_item.icons or { { icon = ore_item.icon } },
        icon_size = ore_item.icon_size,
        allow_decomposition = false,
        order = (ore_item.order and "a3" .. ore_item.order or "a3"),
        localised_name = ore_item.localised_name or { "entity-name." .. ore_item.name },
        category = "crafting",
        energy_required = 5,
        ingredients = { { type = "item", name = ore_item.name, amount = 5 } },
        results = { { type = "item", name = ore_item.name, amount = 6 } },
    }

    if (ore_item.minable and ore_item.minable.required_fluid) then
        table.insert(dupe.ingredients,
            { type = "fluid", name = ore_item.minable.required_fluid, amount = ore_item.minable.fluid_amount })
        dupe.category = "chemistry"
    end
    data:extend({ dupe })
end

local function dupeFluid(fluid_item)
    local dupe = {
        name = "space-inside-dupe-" .. fluid_item.name,
        enabled = true,
        type = "recipe",
        icons = fluid_item.icons or { { icon = fluid_item.icon } },
        icon_size = fluid_item.icon_size,
        allow_decomposition = false,
        order = (fluid_item.order and "a3" .. fluid_item.order or "a3"),
        localised_name = fluid_item.localised_name or { "entity-name." .. fluid_item.name },
        category = "oil-processing",
        energy_required = 5,
        ingredients = { { type = "fluid", name = fluid_item.name, amount = 125 } },
        results = { { type = "fluid", name = fluid_item.name, amount = 165, temperature = fluid_item.temperature } },
    }

    data:extend({ dupe })
end

-- Vanilla recipes
dupeOre(data.raw.resource["iron-ore"])
dupeOre(data.raw.resource["coal"])
dupeOre(data.raw.resource["copper-ore"])
dupeOre(data.raw.resource["stone"])
dupeOre(data.raw.resource["uranium-ore"])
dupeFluid(data.raw.resource["crude-oil"])
dupeFluid(data.raw.fluid["water"])
