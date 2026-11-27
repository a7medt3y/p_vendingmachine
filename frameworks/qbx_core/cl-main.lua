if Framework.Name ~= "qbx_core" then return end

RegisterNetEvent("QBCore:Client:OnPlayerLoaded", function()
    Wait(1500)
    TriggerEvent("p_vendingmachine:client:player-loaded")
end)
