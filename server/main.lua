ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

AddEventHandler('esx:playerLoaded', function(source)
	TriggerEvent('esx_license:getLicenses', source, function(licenses)
		TriggerClientEvent('esx_dmvschool:loadLicenses', source, licenses)
	end)
end)

RegisterNetEvent('esx_dmvschool:addLicense')
AddEventHandler('esx_dmvschool:addLicense', function(type)
	local _source = source

	TriggerEvent('esx_license:addLicense', _source, type, function()
		TriggerEvent('esx_license:getLicenses', _source, function(licenses)
			TriggerClientEvent('esx_dmvschool:loadLicenses', _source, licenses)
		end)
	end)
end)

RegisterNetEvent('esx_dmvschool:zaplacenihotoveteorie')
AddEventHandler('esx_dmvschool:zaplacenihotoveteorie', function(price)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local cenateorie = Config.Prices.dmv

	if xPlayer.getMoney() >= cenateorie then
		xPlayer.removeMoney(cenateorie)
		TriggerClientEvent('esx:showNotification', _source, _U('you_paid', ESX.Math.GroupDigits(cenateorie)))
		TriggerClientEvent('esx_dmvschool:zaplacenateorie', _source)
	else
		TriggerClientEvent('esx:showNotification', _source, 'Nedostatek penez')
	end
end)

RegisterNetEvent('esx_dmvschool:zaplacenikartouteorie')
AddEventHandler('esx_dmvschool:zaplacenikartouteorie', function(price)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local cenateorie = Config.Prices.dmv
	local account = xPlayer.getAccount('bank')
	
	if account.money >= cenateorie then
		xPlayer.removeAccountMoney('bank', cenateorie)
		TriggerClientEvent('esx:showNotification', _source, _U('you_paid', ESX.Math.GroupDigits(cenateorie)))
		TriggerClientEvent('esx_dmvschool:zaplacenateorie', _source)
	else
		TriggerClientEvent('esx:showNotification', _source, 'Nedostatek penez')
	end
end)

RegisterNetEvent('esx_dmvschool:zaplacenihotoveprakticka')
AddEventHandler('esx_dmvschool:zaplacenihotoveprakticka', function(type)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local cenateorie = Config.Prices[type]
	local typ = type

	if xPlayer.getMoney() >= cenateorie then
		xPlayer.removeMoney(cenateorie)
		TriggerClientEvent('esx:showNotification', _source, _U('you_paid', ESX.Math.GroupDigits(cenateorie)))
		TriggerClientEvent('esx_dmvschool:zaplacenaprakticka', _source, typ)
	else
		TriggerClientEvent('esx:showNotification', _source, 'Nedostatek penez')
	end
end)

RegisterNetEvent('esx_dmvschool:zaplacenikartouprakticka')
AddEventHandler('esx_dmvschool:zaplacenikartouprakticka', function(type)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local cenateorie = Config.Prices.dmv
	local account = xPlayer.getAccount('bank')
	local typ = type
	
	if account.money >= cenateorie then
		xPlayer.removeAccountMoney('bank', cenateorie)
		TriggerClientEvent('esx:showNotification', _source, _U('you_paid', ESX.Math.GroupDigits(cenateorie)))
		TriggerClientEvent('esx_dmvschool:zaplacenaprakticka', _source, typ)
	else
		TriggerClientEvent('esx:showNotification', _source, 'Nedostatek penez')
	end
end)
