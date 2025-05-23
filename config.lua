Config = {}

-- Kick message 
-- %s = Player Name, %s = Date
Config.KickMessage = "%s is dead on %s 🪦"

-- Authorized groups
Config.AllowedGroups = {
    ["admin"] = true,
    ["superadmin"] = true
}

-- Discord webhook
Config.Webhook = "/"

-- Webhook Message
Config.WebhookEmbed = {
    username = "⚡ Reborn : Wipe", -- Bot username
    title = "GP-Wipe 🪦",         -- Embed title
    description = "**%s** viens de wipe **%s** le <t:%d>", -- %s = Executor, %s = Target, %d = Timestamp
    color = 16711680           -- Embed color (Red)
}