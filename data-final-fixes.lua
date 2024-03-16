local function dupeResource(item)
    print("dupeResource: ")
    for k, v in pairs(item) do
        print(k, ":", v)
    end
    print("minable: ", serpent.block(item.minable))

    if (item.category == "se-core-mining") then
        return
    end

    local result = { type = "item", name = item.minable.result, amount = 1 }
    if (item.minable.results) then
        result = item.minable.results[1]
    end

    local dupe = {
        name = "space-inside-dupe-" .. item.name,
        enabled = true,
        type = "recipe",
        icons = item.icons or { { icon = item.icon } },
        icon_size = item.icon_size,
        allow_decomposition = false,
        order = (item.order and "a3" .. item.order or "a3"),
        localised_name = item.localised_name or { "entity-name." .. item.name },
        energy_required = 5,
    }

    if (result.type == "fluid") then
        dupe.category = "oil-processing"
        dupe.ingredients = { { type = "fluid", name = result.name, amount = 125 } }
        dupe.results = { { type = "fluid", name = result.name, amount = 165, temperature = item.temperature } }
    else
        dupe.category = "crafting";
        dupe.ingredients = { { type = "item", name = result.name, amount = 5 } }
        dupe.results = { { type = "item", name = result.name, amount = 6 } }

        if (item.minable.required_fluid) then
            table.insert(dupe.ingredients,
                { type = "fluid", name = item.minable.required_fluid, amount = item.minable.fluid_amount })
            dupe.category = "chemistry"
        end
    end

    print("result: ", serpent.block(dupe));
    return dupe
end

local dupes = {};
for k, v in pairs(data.raw.resource) do
    local dupe = dupeResource(v)
    if (dupe) then
        table.insert(dupes, dupe)
    end
end
data:extend(dupes);
