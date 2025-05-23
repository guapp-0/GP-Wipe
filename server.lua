
ESX = exports['es_extended']:getSharedObject()

lib = exports.ox_lib

RegisterCommand("wipe", function(source, args)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer or not Config.AllowedGroups[xPlayer.getGroup()] then return end

    local targetId = tonumber(args[1])
    if not targetId then return TriggerClientEvent('chat:addMessage', src, { args = { '^1ERREUR', 'ID invalide' } }) end
    local target = ESX.GetPlayerFromId(targetId)
    if not target then return TriggerClientEvent('chat:addMessage', src, { args = { '^1ERREUR', 'Joueur hors ligne' } }) end

    local result = lib.inputDialog('Confirmation du wipe', {
        {
            type = 'select',
            label = 'Confirmer le wipe de ce joueur ?',
            options = {
                { label = 'Oui', value = 'yes' },
                { label = 'Non', value = 'no' }
            },
            required = true
        }
    })

    if result and result[1] == 'yes' then
        local identifier = target.getIdentifier()
        local playerName = target.getName()
        DropPlayer(targetId, string.format(Config.KickMessage, playerName, os.date("%d/%m/%Y %H:%M:%S")))
        WipePlayerData(identifier)
        SendWebhookLog(xPlayer.getName(), playerName)
    end
end, true)

RegisterCommand("wipeall", function(source)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer or not Config.AllowedGroups[xPlayer.getGroup()] then return end

    local result = lib.inputDialog('Confirmation du wipe global', {
        {
            type = 'select',
            label = 'Confirmer le wipe de tous les joueurs ?',
            options = {
                { label = 'Oui', value = 'yes' },
                { label = 'Non', value = 'no' }
            },
            required = true
        }
    })

    if result and result[1] == 'yes' then
        MySQL.query("DELETE FROM users")
        MySQL.query("DELETE FROM owned_vehicles")
        MySQL.query("DELETE FROM user_inventory")
        MySQL.query("DELETE FROM billing")
        MySQL.query("DELETE FROM datastore_data")
        MySQL.query("DELETE FROM addon_account_data")
        SendWebhookLog(xPlayer.getName(), "ALL PLAYERS")
    end
end, true)
