ESX = exports['es_extended']:getSharedObject()

exports('WipePlayer', function(targetId)
    local target = ESX.GetPlayerFromId(targetId)
    if not target then return false, "Player not found" end

    local identifier = target.getIdentifier()
    local playerName = target.getName()
    DropPlayer(targetId, string.format(Config.KickMessage, playerName, os.date("%d/%m/%Y %H:%M:%S")))
    WipePlayerData(identifier)
    return true
end)

exports('WipeAll', function()
    MySQL.query("DELETE FROM users")
    MySQL.query("DELETE FROM owned_vehicles")
    MySQL.query("DELETE FROM user_inventory")
    MySQL.query("DELETE FROM billing")
    MySQL.query("DELETE FROM datastore_data")
    MySQL.query("DELETE FROM addon_account_data")
    return true
end)

RegisterCommand("wipe", function(source, args)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if not Config.AllowedGroups[xPlayer.getGroup()] then
    TriggerClientEvent('chat:addMessage', src, { args = { '^1ERREUR', 'Vous n\'avez pas la permission.' } })
    return
end
    local targetId = tonumber(args[1])
    if not targetId then return TriggerClientEvent('chat:addMessage', src, { args = { '^1ERROR', 'Invalid ID' } }) end
    local target = ESX.GetPlayerFromId(targetId)
    if not target then return TriggerClientEvent('chat:addMessage', src, { args = { '^1ERROR', 'Player not online' } }) end

    local identifier = target.getIdentifier()
    local playerName = target.getName()
    DropPlayer(targetId, string.format(Config.KickMessage, playerName, os.date("%d/%m/%Y %H:%M:%S")))

    WipePlayerData(identifier)
    SendWebhookLog(xPlayer.getName(), playerName)
end, true)

RegisterCommand("wipeall", function(source)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if not Config.AllowedGroups[xPlayer.getGroup()] then
    TriggerClientEvent('chat:addMessage', src, { args = { '^1ERREUR', 'Vous n\'avez pas la permission.' } })
    return
end
    MySQL.query("DELETE FROM users")
    MySQL.query("DELETE FROM owned_vehicles")
    MySQL.query("DELETE FROM user_inventory")
    MySQL.query("DELETE FROM billing")
    MySQL.query("DELETE FROM datastore_data")
    MySQL.query("DELETE FROM addon_account_data")

    SendWebhookLog(xPlayer.getName(), "ALL PLAYERS")
end, true)

function WipePlayerData(identifier)
    MySQL.query("DELETE FROM users WHERE identifier = ?", {identifier})
    MySQL.query("DELETE FROM owned_vehicles WHERE owner = ?", {identifier})
    MySQL.query("DELETE FROM user_inventory WHERE identifier = ?", {identifier})
    MySQL.query("DELETE FROM billing WHERE identifier = ?", {identifier})
    MySQL.query("DELETE FROM datastore_data WHERE owner = ?", {identifier})
    MySQL.query("DELETE FROM addon_account_data WHERE owner = ?", {identifier})
end

function SendWebhookLog(executor, target)
    local timestamp = os.time()
    local embed = {
        username = Config.WebhookEmbed.username,
        embeds = {{
            title = Config.WebhookEmbed.title,
            description = string.format(Config.WebhookEmbed.description, executor, target, timestamp),
            color = Config.WebhookEmbed.color
        }}
    }

    PerformHttpRequest(Config.Webhook, function(err, text, headers) end, "POST", json.encode(embed), {["Content-Type"] = "application/json"})
end
