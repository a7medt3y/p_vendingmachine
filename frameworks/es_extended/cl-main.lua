if Framework.Name ~= "es_extended" then return end

RegisterNetEvent("esx:playerLoaded", function()
    Wait(1500)
    TriggerEvent("p_vendingmachine:client:player-loaded")
end)
