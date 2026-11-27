RegisterNuiCallback("owner:get-data", function(_, cb)
    local ownerData = GetViewData("owner")
    cb(ownerData and { success = true, data = ownerData } or { success = false })
end)

local function forward(name, callback, read)
    RegisterNuiCallback(name, function(data, cb)
        local payload = data
        if read then payload = read(data) end

        cb(lib.callback.await(callback, false, GetOpenMachine(), payload))
    end)
end

local function amount(data) return data.amount end

forward("owner:save-settings", "p_vendingmachine:server:save-owner-settings")
forward("owner:update-price", "p_vendingmachine:server:owner-update-price")
forward("owner:order-stock", "p_vendingmachine:server:owner-order-stock", function(data) return data.items end)
forward("owner:deposit", "p_vendingmachine:server:owner-deposit", amount)
forward("owner:withdraw", "p_vendingmachine:server:owner-withdraw", amount)
forward("owner:hire-staff", "p_vendingmachine:server:owner-hire-staff")
forward("owner:update-staff", "p_vendingmachine:server:owner-update-staff")
forward("owner:fire-staff", "p_vendingmachine:server:owner-fire-staff")
forward("owner:transfer", "p_vendingmachine:server:owner-transfer")
forward("owner:sell", "p_vendingmachine:server:owner-sell")

RegisterNetEvent("p_vendingmachine:client:order-status", function(machineId, orderId, status)
    local openMachine, view = GetOpenMachine()
    if view ~= "owner" or openMachine ~= machineId then return end

    NuiMessage("setOrderStatus", { id = orderId, status = status })
end)
