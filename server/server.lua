QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

-- Silah Tamir
local weaponType = {
	["pistol"] = {
		[1] = {
			["item"] = "silahtamirkiti",
			["count"] = 1
		}
	},

	["smg"] = {
		[1] = {
			["item"] = "silahtamirkiti",
			["count"] = 1
		}
	},

	["taarruz"] = {
		[1] = {
			["item"] = "silahtamirkiti",
			["count"] = 1
		}
	}
}

local weaponTypeavci = {
	["avci"] = {
		[1] = {
			["item"] = "avcitamirkiti",
			["count"] = 1
		}
	}
}

local weapons = {
	["pistol"] = {
		"weapon_pistol", "weapon_pistol_mk2", "weapon_combatpistol", "weapon_pistol50", "weapon_snspistol", "weapon_heavypistol", "weapon_vintagepistol", "weapon_appistol", "weapon_stungun", "weapon_revolver", "weapon_doubleaction", "weapon_ceramicpistol"
	},
	["smg"] = {
		"weapon_microsmg", "weapon_smg", "weapon_smg_mk2", "weapon_combatpdw", "weapon_machinepistol", "weapon_minismg", "weapon_assaultsmg"
	},
	["taarruz"] = {
		"weapon_assaultrifle", "weapon_assaultrifle_mk2", "weapon_carbinerifle", "weapon_carbinerifle_mk2", "weapon_advancedrifle", "weapon_specialcarbine", "weapon_compactrifle"
	},
}

local weaponsavci = {
	["avci"] = {
	"weapon_musket"
	},
}

QBCore.Functions.CreateUseableItem("silahtamirkiti", function(source)
    TriggerClientEvent("soner:silahtamirkiti", source)
end)

QBCore.Functions.CreateUseableItem("avcitamirkiti", function(source)
    TriggerClientEvent("soner:avciliktamir", source)
end)

RegisterServerEvent('snr:avcilik')
AddEventHandler('snr:avcilik', function(type, police, key)
	local xPlayer = QBCore.Functions.GetPlayer(source)
	if not police then
		local requestItem = ""
		local requestItemCount = 0
		for type, item in pairs(weaponTypeavci[type]) do
			if xPlayer.Functions.GetItemByName(item["item"]).amount >= item["count"] then
				requestItemCount = requestItemCount + 1
			end
			requestItem = requestItem .. " ".. item["count"] .. " Tane " .. QBCore.Shared.Items[item["item"]].label
		end

		if requestItemCount ~= #weaponTypeavci[type] then 
			TriggerClientEvent("QBCore:Notify", xPlayer.PlayerData.source, "Bu Silahı Tamir Etmek İçin ".. requestItem .. " Lazım", "error", 20000)
		else
			local found = false
			for i=1, #weaponsavci[type] do
				local weapon = xPlayer.Functions.GetItemByName(weaponsavci[type][i])
				if weapon.amount > 0 then
					weapon.info.durubality = os.time()
					if xPlayer.Functions.RemoveItem(weapon.name, 1, weapon.slot, xPlayer.Functions.GetItemByName(weapon.name).slot) then
						xPlayer.Functions.AddItem(weapon.name, 1, weapon.slot, weapon.info)
						for type, item in pairs(weaponTypeavci[type]) do
							xPlayer.Functions.RemoveItem(item["item"], item["count"], xPlayer.Functions.GetItemByName(item["item"]).slot)
						end

						found = true
					end
					TriggerClientEvent("QBCore:Notify", xPlayer.PlayerData.source, weapon.slot.. ". Slottaki Silah Tamir Edildi!", "success")
					
					break
				end
			end

			if not found then
				TriggerClientEvent("QBCore:Notify", xPlayer.PlayerData.source, "Üzerinde Tamir Edebilecek Bir Silah Yok", "error")
			end
		end
	elseif police then 
		for i=1, #weaponsavci[type] do
			local weapon = xPlayer.Functions.GetItemByName(weaponsavci[type][i])
			if weapon.amount > 0 then
				weapon.info.durubality = os.time()
				if xPlayer.Functions.RemoveItem(weapon.name, 1, weapon.slot) then
					xPlayer.Functions.AddItem(weapon.name, 1, weapon.slot, weapon.info)
				end
				TriggerClientEvent("QBCore:Notify", xPlayer.PlayerData.source, weapon.slot.. ". Slottaki Silah Tamir Edildi!", "success")
				break
			end
		end
	end
end)

RegisterServerEvent('snr:repair-weapon')
AddEventHandler('snr:repair-weapon', function(type, police, key)
	local xPlayer = QBCore.Functions.GetPlayer(source)
	if not police then
		local requestItem = ""
		local requestItemCount = 0
		for type, item in pairs(weaponType[type]) do
			if xPlayer.Functions.GetItemByName(item["item"]).amount >= item["count"] then
				requestItemCount = requestItemCount + 1
			end
			requestItem = requestItem .. " ".. item["count"] .. " Tane " .. QBCore.Shared.Items[item["item"]].label
		end

		if requestItemCount ~= #weaponType[type] then 
			TriggerClientEvent("QBCore:Notify", xPlayer.PlayerData.source, "Bu Silahı Tamir Etmek İçin ".. requestItem .. " Lazım", "error", 20000)
		else
			local found = false
			for i=1, #weapons[type] do
				local weapon = xPlayer.Functions.GetItemByName(weapons[type][i])
				if weapon.amount > 0 then
					weapon.info.durubality = os.time()
					if xPlayer.Functions.RemoveItem(weapon.name, 1, weapon.slot, xPlayer.Functions.GetItemByName(weapon.name).slot) then
						xPlayer.Functions.AddItem(weapon.name, 1, weapon.slot, weapon.info)
						for type, item in pairs(weaponType[type]) do
							xPlayer.Functions.RemoveItem(item["item"], item["count"], xPlayer.Functions.GetItemByName(item["item"]).slot)
						end

						found = true
					end
					TriggerClientEvent("QBCore:Notify", xPlayer.PlayerData.source, weapon.slot.. ". Slottaki Silah Tamir Edildi!", "success")
					
					break
				end
			end

			if not found then
				TriggerClientEvent("QBCore:Notify", xPlayer.PlayerData.source, "Üzerinde Tamir Edebilecek Bir Silah Yok", "error")
			end
		end
	elseif police then 
		for i=1, #weapons[type] do
			local weapon = xPlayer.Functions.GetItemByName(weapons[type][i])
			if weapon.amount > 0 then
				weapon.info.durubality = os.time()
				if xPlayer.Functions.RemoveItem(weapon.name, 1, weapon.slot) then
					xPlayer.Functions.AddItem(weapon.name, 1, weapon.slot, weapon.info)
				end
				TriggerClientEvent("QBCore:Notify", xPlayer.PlayerData.source, weapon.slot.. ". Slottaki Silah Tamir Edildi!", "success")
				break
			end
		end
	end
end)

QBCore.Commands.Add("silahtamir", "Üzerindeki silahi tamir eder.", {{name="text", help="Üzerindeki silahi tamir eder."}}, false, function(source, args)
    TriggerClientEvent("soner:admintamir", source)
end, "god")