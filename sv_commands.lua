ESX = nil


TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)




RegisterNetEvent('register-break')
AddEventHandler('register-break', function()
  local xPlayer = ESX.GetPlayerFromId(source)
 if xPlayer.getInventoryItem('cashregister').count >= 1 then
   xPlayer.removeInventoryItem('cashregister', 1)
   xPlayer.addInventoryItem('money', math.random(100, 1500))
 else
  TriggerClientEvent('dopeNotify2:Alert', source, "", "You need a Cash Register(1)", 5000, 'error')
 end
end)




RegisterNetEvent('register-add')
AddEventHandler('register-add', function()
  local xPlayer = ESX.GetPlayerFromId(source)
 --xPlayer.addMoney(math.random(50, 700))
 xPlayer.addInventoryItem('cashregister', 1)
end)


