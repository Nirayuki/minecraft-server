# Quick Reference Guide

## Server Setup (First Time)

### Option 1: Automatic Setup (Recommended)
```bash
chmod +x setup.sh
./setup.sh
```

### Option 2: Manual Setup
```bash
# Download Forge installer
wget https://maven.minecraftforge.net/net/minecraftforge/forge/1.16.5-36.2.42/forge-1.16.5-36.2.42-installer.jar

# Install Forge
java -jar forge-1.16.5-36.2.42-installer.jar --installServer

# Accept EULA
sed -i 's/eula=false/eula=true/g' eula.txt

# Clean up
rm forge-1.16.5-36.2.42-installer.jar
```

## Starting the Server

```bash
chmod +x start.sh
./start.sh
```

## Stopping the Server

In the server console:
```
stop
```

## Common Server Commands

| Command | Description |
|---------|-------------|
| `list` | Show online players |
| `op <player>` | Grant operator privileges |
| `deop <player>` | Remove operator privileges |
| `whitelist add <player>` | Add player to whitelist |
| `whitelist remove <player>` | Remove from whitelist |
| `kick <player>` | Kick a player |
| `ban <player>` | Ban a player |
| `pardon <player>` | Unban a player |
| `save-all` | Force save the world |
| `say <message>` | Broadcast message to all players |
| `tp <player1> <player2>` | Teleport player1 to player2 |
| `gamemode <mode> <player>` | Change gamemode (survival/creative/adventure/spectator) |
| `time set <value>` | Set time (day=1000, noon=6000, night=13000) |
| `weather <clear/rain/thunder>` | Change weather |
| `difficulty <peaceful/easy/normal/hard>` | Change difficulty |

## Adding Mods

1. Download Forge 1.16.5 compatible mods (`.jar` files)
2. Copy to `mods/` directory:
   ```bash
   cp mod-name.jar mods/
   ```
3. Restart the server

## Configuration Files

| File | Purpose |
|------|---------|
| `server.properties` | Main server configuration |
| `eula.txt` | EULA acceptance |
| `ops.json` | Server operators |
| `whitelist.json` | Whitelisted players |
| `banned-players.json` | Banned players |
| `banned-ips.json` | Banned IP addresses |

## Port Forwarding (Codespaces)

1. Open **Ports** panel in VS Code
2. Find port **25565**
3. Right-click → **Port Visibility** → **Public**
4. Share the forwarded address with players

## Backup World

```bash
# Create backup
tar -czf backup-$(date +%Y%m%d-%H%M%S).tar.gz world/

# Restore backup
tar -xzf backup-YYYYMMDD-HHMMSS.tar.gz
```

## Performance Tuning

### Increase Memory
Edit `start.sh` or set environment variable:
```bash
export JAVA_MEMORY=4G
./start.sh
```

### Reduce View Distance
Edit `server.properties`:
```properties
view-distance=8
```

### Optimize for Low Lag
Edit `server.properties`:
```properties
view-distance=6
simulation-distance=6
max-tick-time=60000
network-compression-threshold=256
```

## Troubleshooting

### Server won't start
- Check if Forge jar exists: `ls -la forge-*.jar`
- Check EULA: `cat eula.txt`
- View logs: `cat logs/latest.log`

### Out of memory
- Increase JAVA_MEMORY in start.sh
- Reduce view-distance in server.properties
- Remove unused mods

### Port already in use
- Check what's using the port: `lsof -i :25565`
- Change port in server.properties
- Stop other Minecraft servers

### Connection refused
- Verify server is running: `ps aux | grep forge`
- Check port forwarding (Codespaces)
- Verify firewall settings (local setup)

## Important Files Locations

```
/minecraft/
├── forge-1.16.5-36.2.42.jar    # Main server jar
├── start.sh                     # Startup script
├── setup.sh                     # Setup helper script
├── eula.txt                     # EULA acceptance
├── server.properties            # Server configuration
├── mods/                        # Your mods go here
├── config/                      # Mod configurations
├── world/                       # Overworld data
├── world_nether/                # Nether data
├── world_the_end/               # End data
├── logs/                        # Server logs
└── libraries/                   # Forge libraries
```

## Useful Links

- [Forge Downloads](https://files.minecraftforge.net/net/minecraftforge/forge/index_1.16.5.html)
- [CurseForge Mods](https://www.curseforge.com/minecraft/mc-mods?filter-game-version=2020709689%3A8203)
- [Modrinth](https://modrinth.com/mods?g=1.16.5)
- [Minecraft Wiki](https://minecraft.fandom.com/wiki/Server.properties)

## Support

For issues with this setup, please open an issue on GitHub.
For Minecraft/Forge support, visit the [Forge Forums](https://forums.minecraftforge.net/).
