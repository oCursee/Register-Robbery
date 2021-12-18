local Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
    ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX              = nil
local PlayerData = {}
local ped = PlayerPedId()
local canRob = true




Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer   
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)




local register = {
  303280717,
  3940037152,
}

exports['qtarget']:AddTargetModel(register, {
	options = {
		{
			event = "storeRobbery",
			icon = "fas fa-cut",
			label = "Rob the Register",
		},
	},
	job = {"all"},
	distance = 3.5
})


RegisterNetEvent('storeRobbery')
AddEventHandler('storeRobbery', function ()
  Citizen.CreateThread(function()
    while true do
      Citizen.Wait(1)
      CanCar = false
      local skill = exports["reload-skillbar"]:taskBar(2000,math.random(5,15))      
      if canRob and IsPedArmed(GetPlayerPed(-1), 7) and IsPedArmed(GetPlayerPed(-1), 4) then
        if skill == 100 then
          canRob = false
            RequestAnimDict("anim@amb@clubhouse@tutorial@bkr_tut_ig3@")
              while not HasAnimDictLoaded("anim@amb@clubhouse@tutorial@bkr_tut_ig3@") do Citizen.Wait(0) end
                TaskPlayAnim(PlayerPedId(), "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 1.0, -1.0, Config.RegisterTime * 1000, 49, 1, false, false, false)
                 RemoveAnimDict("anim@amb@clubhouse@tutorial@bkr_tut_ig3@")
            exports.rprogress:Custom({
             Duration = Config.RegisterTime * 1000,
              Label = "Breaking into the register",
             Animation = {
                 scenario = "", -- https://pastebin.com/6mrYTdQv
                 animationDictionary = "", -- https://alexguirre.github.io/animations-list/
              },
              DisableControls = {
                Mouse = false,
                Player = true,
                Vehicle = true
            }
         })
            Citizen.Wait(Config.RegisterTime * 1000)
            AttachRegister()
          else
          canRob = false
          exports['dopeNotify2']:Alert("You Failed", '', 5000, 'error')
         end
      else
       exports['dopeNotify2']:Alert("Nice One", 'You pose no threat!! Come back later', 5000, 'error')

      end
      break  
    end
    while CanCar do
      Wait(0)
      local cVeh = ESX.Game.GetVehicleInDirection()
      if DoesEntityExist(cVeh) then 
        print("Entity Exist")
        SetVehicleDoorOpen(cVeh, 5, false, true)
        DeleteObject(reg)
        Wait(25)
        playAnim('anim@heists@fleeca_bank@scope_out@return_case', 'trevor_action', 3200)
        Wait(3200)
        SetVehicleDoorShut(cVeh, 5, false)
        TriggerServerEvent("register-add", ped)
        print('Entity No Longer Exist')
        CanCar = false
        break
      end
    end
  end)
end)

local tableOut = false
local canReturn = false
Citizen.CreateThread(function()
while true do
  Wait(5)
  
  local Player = PlayerPedId()
  local PlayerPos = GetEntityCoords(Player)
  local distDoor = #(PlayerPos - vector3(959.64, 3619.16, 32.66))
  local distReturn = Vdist(PlayerPos.x, PlayerPos.y, PlayerPos.z, 969.18, 3623.02, 32.42)
  local RegDist = #(PlayerPos - vector3(972.4, 3617.26, 31.49))
  if not tableOut then
    if distDoor <= 3 then    
      ShowFloatingHelpNotification("Borrow a bench from Billy", vector3(959.64, 3619.16, 32.66))
      if IsControlJustReleased(1, 38) and distDoor <=4 then
        tableOut = true
        canReturn = true
        playAnim('timetable@jimmy@doorknock@', 'knockdoor_idle', 1200)
        Wait(1400)
        DoScreenFadeOut(0)
        SetEntityCoords(Player, 969.24, 3616.31, 32.63)
        SetEntityHeading(Player, 258.39)
        Wait(2500)
        DoScreenFadeIn(300)
        table = CreateObject(GetHashKey("v_ind_cftable"), 972.4, 3617.26, 31.49, true, true, false)
        FreezeEntityPosition(table, true)
        ESX.ShowNotification("Please Return the table before you leave.")
      end
    end
  end
  if tableOut then
    ShowFloatingHelpNotification("Crack Open The Register", vector3(972.4, 3617.26, 31.49))
    if RegDist <=3  and IsControlJustReleased(1, 38) then
      Register = CreateObject(GetHashKey("prop_till_01"), 972.4, 3617.26, 32.39, true, true, false)
      playAnim("anim@amb@clubhouse@tutorial@bkr_tut_ig3@","machinic_loop_mechandplayer", 15000 )
      exports.rprogress:Custom({
        Duration = 16000,
         Label = "Cracking Open the Register",
         DisableControls = {Player = true,},
         onComplete = function(cancelled)
          TriggerServerEvent('register-break', ped)
          DeleteObject(Register)
          ClearPedTasks(ped)
        end   
    })     
    end
  end
  if canReturn and tableOut and distReturn <=5 then 
    if distReturn <= 10 then
      DrawMarker(1, 969.18, 3623.02, 32.42, 0, 0, 0, 0, 0, 0, 0.301, 0.301, 0.3001, 0, 153, 255, 255, 1, 0, 0, 0)     
    end
    if IsControlJustReleased(1, 38) and distReturn <=2 then
      DeleteObject(table)
      DeleteObject(Register)
      tableOut = false
      canReturn = false
    end
  end

end
end)




















