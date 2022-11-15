local PlayerData = {}
local coreLoaded = false
local bussy = false
local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function(job)
    PlayerData.job = job
end)

local tamirhane = PolyZone:Create({
    vector2(993.6256, -119.367),
    vector2(1005.685, -126.210),
    vector2(999.4315, -134.151),
    vector2(988.4653, -127.003)
  }, {
    name= "tamirhanezone",
    minZ = 65.544399261475,
    maxZ = 85.885969161987
})

RegisterNetEvent('soner:silahtamirkiti')
AddEventHandler('soner:silahtamirkiti', function(source)
	local player = PlayerPedId()
    local playerCoords = GetEntityCoords(player)
	if PlayerData.job and PlayerData.job.name == 'mechanic4' then 
		if tamirhane:isPointInside(playerCoords) then
			QBCore.UI.Menu.CloseAll()
				QBCore.Functions.Notify("Üstünde Silah Olarak Sadece Tamir Edeceğin Silah Olduğundan Emin Ol Yoksa Yanlış Silahı Tamir Edebilirsin!", "error", 25000)
				QBCore.UI.Menu.Open('default', GetCurrentResourceName(), 'npc_craft', {
					title    = "Silah Tamir Menüsü",
						align    = 'top-left',
						elements = {
						{label = "Tabanca Tamir Et", value = "pistol"},
						{label = "SMG Tamir Et", value = "smg"},
						{label = "Tüfek Tamir Et", value = "taarruz"},
					}
				},function(data, menu)
					if data.current.value then	
						SetCurrentPedWeapon(PlayerPedId(), `WEAPON_UNARMED`, true)
						TriggerServerEvent("snr:repair-weapon", data.current.value, false, QBCore.Key)
						menu.close()
					end
				end, function(data, menu)
					menu.close()
			end)
		else
			QBCore.Functions.Notify("Bu kiti burada kullanamazsın.", "error")
		end
	else
		QBCore.Functions.Notify("Bu Kiti kullanmayı bilmiyorsun.", "error")
	end
end)

RegisterNetEvent('soner:avciliktamir')
AddEventHandler('soner:avciliktamir', function(source)
	local player = PlayerPedId()
    local playerCoords = GetEntityCoords(player)
	QBCore.UI.Menu.CloseAll()
	QBCore.Functions.Notify("Üstünde Silah Olarak Sadece Tamir Edeceğin Silah Olduğundan Emin Ol Yoksa Yanlış Silahı Tamir Edebilirsin!", "error", 25000)
	QBCore.UI.Menu.Open('default', GetCurrentResourceName(), 'npc_craft', {
		title    = "Silah Tamir Menüsü",
		align    = 'top-left',
		elements = {
	{label = "Avcılık Silahi Bakimini yap", value = "avci"},
	}
	},function(data, menu)
		if data.current.value then	
			SetCurrentPedWeapon(PlayerPedId(), `WEAPON_UNARMED`, true)
			TriggerServerEvent("snr:avcilik", data.current.value, false, QBCore.Key)
			menu.close()
		end
	end, function(data, menu)
		menu.close()
	end)
end)

RegisterNetEvent('soner:admintamir')
AddEventHandler('soner:admintamir', function(source)
TriggerServerEvent("snr:repair-weapon", "pistol", false, QBCore.Key)
TriggerServerEvent("snr:repair-weapon", "smg", false, QBCore.Key)
TriggerServerEvent("snr:repair-weapon", "taarruz", false, QBCore.Key)
end)