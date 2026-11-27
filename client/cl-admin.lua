RegisterNetEvent("p_vendingmachine:client:open-admin-menu", function()
    if IsPlacing() then return end

    NuiMessage("setView", { view = "admin" })
    SetNuiFocus(true, true)
end)

RegisterNuiCallback("admin:get-data", function(_, cb)
    local response = lib.callback.await("p_vendingmachine:server:get-admin-data", false)

    if response and response.success and response.data then
        response.data.customMachines = GetResourceState("olentrix_vending") == "started"
    end

    cb(response)
end)

local forwarded <const> = {
    ["admin:create-machine"] = "p_vendingmachine:server:create-machine",
    ["admin:update-machine"] = "p_vendingmachine:server:update-machine",
    ["admin:delete-machine"] = "p_vendingmachine:server:delete-machine",
    ["admin:import-machine"] = "p_vendingmachine:server:import-machines",
    ["admin:set-status"] = "p_vendingmachine:server:set-machine-status",
    ["admin:reset-balance"] = "p_vendingmachine:server:reset-machine-balance",
    ["admin:save-settings"] = "p_vendingmachine:server:save-admin-settings",
}

for name, callback in pairs(forwarded) do
    RegisterNuiCallback(name, function(data, cb)
        cb(lib.callback.await(callback, false, data))
    end)
end

RegisterNuiCallback("admin:teleport", function(data, cb)
    local response = lib.callback.await("p_vendingmachine:server:get-machine-position", false, data)

    if not response or not response.success then
        cb(response)
        return
    end

    local position = response.data
    local heading = math.rad(position.heading)
    local x = position.x - math.sin(heading) * 1.2
    local y = position.y + math.cos(heading) * 1.2
    local ped = cache.ped

    FreezeEntityPosition(ped, true)
    RequestCollisionAtCoord(x, y, position.z)
    SetEntityCoords(ped, x, y, position.z, false, false, false, false)
    SetEntityHeading(ped, (position.heading + 180.0) % 360.0)

    local timeout = GetGameTimer() + 3000
    while not HasCollisionLoadedAroundEntity(ped) and GetGameTimer() < timeout do
        Wait(0)
    end

    FreezeEntityPosition(ped, false)
    cb({ success = true })
end)
