
# 🪦 GP-Wipe — WIPE Tool for ESX

GP-Wipe is a lightweight and secure FiveM utility script for wiping player data in ESX-based servers. Ideal for administrators who need to reset individual players or the entire server database. Includes permission checks, Discord logging, and OXMySQL support.

---

## 🚀 Features

- **/wipe [ID]** — Wipes a specific player's data and kicks them with a custom message.
- **/wipeall** — Removes all character data from the database.
- **Discord Webhook Logging** — Sends detailed logs to a configured channel.
- **Permission System** — Restrict access to specific ESX admin groups.
- **Safe Server Exports** — Trigger wipes via:
  ```lua
  exports['GP-Wipe']:WipePlayer(1)
  exports['GP-Wipe']:WipeAll()
  ```
- **ESX + OXMySQL Compatible**

---

## 🔒 Safety

- Logs actions with timestamp and executor identity.
- Easy configuration of allowed groups and webhook in `config.lua`.

---

## 📦 Installation

1. Extract the `GP-Wipe` folder to your `resources` directory.
2. Add to `server.cfg`:
   ```
   ensure oxmysql
   ensure GP-Wipe
   ```
3. Configure your settings in `config.lua` (admin roles, webhook, messages).

---

## 💡 Commands

| Command      | Description                          |
|--------------|--------------------------------------|
| `/wipe [ID]` | Wipe data for a specific player      |
| `/wipeall`   | Wipe all stored player data          |

---

## 📜 License

MIT License — Free to use, modify, and distribute.

---

## 🤝 Credits

Created by `guapp0`, updated and extended by the community.
