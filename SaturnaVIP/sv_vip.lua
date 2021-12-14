----------------------------------------------
----------------------------------------------
--------https://discord.gg/HaKMpDhEbV---------
----------------------------------------------
----------------------------------------------

----------------------------------------------
----------------------------------------------
--------https://discord.gg/HaKMpDhEbV---------
----------------------------------------------
----------------------------------------------

ESX, vips = nil, {}

TriggerEvent("esx:getSharedObject", function(obj)
    ESX = obj
end)


--------- REQUETE SQL POUR GET VIPLEVEL


Citizen.CreateThread(function()
    MySQL.Async.fetchAll("SELECT identifier, viplevel FROM users WHERE viplevel > 0", {}, function(result)
        for id, data in pairs(result) do
            vips[data.identifier] = data.viplevel
        end
    end)
end)


------------ Function Logs Werbhook


function sendToDiscordWithSpecialURL(name,message,color,url)
    local DiscordWebHook = url
	local embeds = {
		{
			["title"]=message,
			["type"]="rich",
			["color"] =color,
			["footer"]=  {
			["text"]= GetTime()
			},
		}
	}
    if message == nil or message == '' then return FALSE end
    PerformHttpRequest("LE_LIEN_DE_VOTRE_WEBHOOK_DISCORD", function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end


function GetTime() -- Fonction pour get le temps pour les logs
	local date = os.date('*t')
	if date.day < 10 then date.day = '0' .. tostring(date.day) end
	if date.month < 10 then date.month = '0' .. tostring(date.month) end
	if date.hour < 10 then date.hour = '0' .. tostring(date.hour) end
	if date.min < 10 then date.min = '0' .. tostring(date.min) end
	if date.sec < 10 then date.sec = '0' .. tostring(date.sec) end

	local date = "" .. date.day .. "." .. date.month .. "." .. date.year .. " - " .. date.hour .. " heures " .. date.min .. " minutes " .. date.sec .. " secondes"
	return date
end

-------------- EVENT POUR EXECTUTE LES LOGS

RegisterNetEvent('warzyyx:VipLogs')
AddEventHandler('warzyyx:VipLogs', function(_src, model)
    local _src = source
    local playername = GetPlayerName(_src)
    sendToDiscordWithSpecialURL("Changement de ped LOGS", "Le joueur "..playername.." a changé son PED en "..model.." ", 16711807)
end)

RegisterNetEvent('warzyyx:VipLogsProps')
AddEventHandler('warzyyx:VipLogsProps', function(_src, nameprops)
    local _src = source
    local playername = GetPlayerName(_src)
    sendToDiscordWithSpecialURL("Spawn de props LOGS", "Le joueur "..playername.." a fait spawn un props (Nom du props : **"..nameprops.."**)", 16711807)
end)




-------------CALLBACK SQL REQUETE----------

-- Réponse requêtes joueurs
RegisterNetEvent("warzyyx:RequestVipLevel")
AddEventHandler("warzyyx:RequestVipLevel", function()
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    local identifier = GetPlayerIdentifier(_src)
    TriggerClientEvent("warzyyx:callbackVipLvl", _src, (vips[identifier] or 0))
end)
    

----------------------------------------------
----------------------------------------------
--------https://discord.gg/HaKMpDhEbV---------
----------------------------------------------
----------------------------------------------