function playAnim(animDict, animName, duration)
    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do Citizen.Wait(0) end
    TaskPlayAnim(PlayerPedId(), animDict, animName, 1.0, -1.0, duration, 49, 1, false, false, false)
    RemoveAnimDict(animDict)
end


function AttachRegister()
    CanCar = true
    local ped = PlayerPedId()
    SetCurrentPedWeapon(ped, GetHashKey('weapon_unarmed'), true)
    Wait(100)
    reg = CreateObject(GetHashKey("prop_till_01"), 0, 0, 0, true, true, false)
    AttachEntityToEntity(reg, ped, GetPedBoneIndex(ped, 57005), 0.2, 0, 0, 0, 270.0, 60.0, true, true, false, true, 1, true)
    playAnim("anim@heists@box_carry@", "idle", 99999)
    ESX.ShowNotification("Go To Your Trunk", false, false)
end


function ShowFloatingHelpNotification(msg, coords)
    SetFloatingHelpTextWorldPosition(1, coords.x, coords.y, coords.z)
    SetFloatingHelpTextStyle(1, 1, 2, -1, 3, 0)
    BeginTextCommandDisplayHelp('STRING')
    AddTextComponentSubstringPlayerName(msg)
    EndTextCommandDisplayHelp(2, false, true, 0)
  end