--Civilian Adverts
RegisterNetEvent('TRP_Menu:SyncAds')
AddEventHandler('TRP_Menu:SyncAds',function(Text, Name, Loc, File, ID)
    Ad(Text, Name, Loc, File, ID)
end)