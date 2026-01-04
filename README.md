# Minecraft Forge 1.16.5 Server

A complete Minecraft server setup using Forge 1.16.5 (version 36.2.42) with mod support, optimized for running in GitHub Codespaces with 4 CPU cores.

## 📋 Table of Contents
- [Features](#features)
- [Prerequisites](#prerequisites)
- [Quick Start with GitHub Codespaces](#quick-start-with-github-codespaces)
- [Manual Setup Instructions](#manual-setup-instructions)
- [Server Configuration](#server-configuration)
- [Adding Mods](#adding-mods)
- [Connecting to the Server](#connecting-to-the-server)
- [Server Management](#server-management)
- [Troubleshooting](#troubleshooting)

## ✨ Features

- **Minecraft Version**: 1.16.5
- **Forge Version**: 36.2.42
- **Java Version**: OpenJDK 8
- **Optimized JVM Flags**: Using Aikar's flags for better performance
- **Docker Support**: Easy deployment with Docker and Docker Compose
- **GitHub Codespaces Ready**: Pre-configured with 4-core setup
- **Mod Support**: Dedicated mods folder for easy mod management
- **Persistent Storage**: World data, configs, and mods are preserved

## 📦 Prerequisites

Before starting, ensure you have:
- Docker and Docker Compose installed (for local setup)
- OR GitHub Codespaces access (for cloud setup)
- Java 8 or higher (for manual setup)
- At least 4GB of RAM available
- Minecraft Java Edition 1.16.5

## 🚀 Quick Start with GitHub Codespaces

### Step 1: Create a Codespace

1. Go to this repository on GitHub
2. Click the green **"Code"** button
3. Select the **"Codespaces"** tab
4. Click **"Create codespace on main"** (or your branch)
5. **Important**: Before creating, click on the "..." menu and select **"New with options"**
6. Configure the following:
   - **Machine type**: Select **4-core** (8 GB RAM, 32 GB storage)
   - **Region**: Select the closest region to Brazil:
     - Primary: **South America (São Paulo)** (if available)
     - Alternative: **US East (Virginia)** (closest US region)
     - Alternative: **US South (Texas)** (good latency to Brazil)

### Step 2: Download and Install Forge

Once your Codespace is running, you need to download the Forge server installer:

```bash
cd /minecraft

# Download Forge 1.16.5-36.2.42 installer
wget https://maven.minecraftforge.net/net/minecraftforge/forge/1.16.5-36.2.42/forge-1.16.5-36.2.42-installer.jar

# Run the installer to set up the server
java -jar forge-1.16.5-36.2.42-installer.jar --installServer

# Clean up installer
rm forge-1.16.5-36.2.42-installer.jar
```

The installer will:
- Download the Minecraft server jar
- Download all required Forge libraries
- Set up the server structure
- Create the `forge-1.16.5-36.2.42.jar` file needed to run the server

### Step 3: Accept the EULA

You **must** accept the Minecraft End User License Agreement:

```bash
# Edit the eula.txt file
nano eula.txt

# Change this line from:
# eula=false
# To:
eula=true

# Save and exit (Ctrl+X, then Y, then Enter)
```

Or use this one-liner:
```bash
sed -i 's/eula=false/eula=true/g' eula.txt
```

**Important**: By setting `eula=true`, you are indicating your agreement to the [Minecraft EULA](https://account.mojang.com/documents/minecraft_eula).

### Step 4: Start the Server

```bash
# Make sure the start script is executable
chmod +x start.sh

# Start the server
./start.sh
```

The server will start and generate the world. First startup may take several minutes.

### Step 5: Port Forwarding (Automatic)

GitHub Codespaces will automatically detect port 25565 and forward it. You'll see a notification in VS Code. The port will be:
- **Private** by default (only you can access)
- You can make it **Public** in the Ports panel (View → Ports → Right-click port 25565 → Port Visibility → Public)

## 🔧 Manual Setup Instructions

If you're not using Codespaces, follow these steps:

### Local Setup with Docker

1. Clone the repository:
```bash
git clone https://github.com/Nirayuki/minecraft-server.git
cd minecraft-server
```

2. Download and install Forge in the `server/` directory:
```bash
cd server
wget https://maven.minecraftforge.net/net/minecraftforge/forge/1.16.5-36.2.42/forge-1.16.5-36.2.42-installer.jar
java -jar forge-1.16.5-36.2.42-installer.jar --installServer
rm forge-1.16.5-36.2.42-installer.jar
cd ..
```

3. Accept the EULA:
```bash
sed -i 's/eula=false/eula=true/g' server/eula.txt
```

4. Build and start with Docker Compose:
```bash
docker-compose up -d
```

5. View logs:
```bash
docker-compose logs -f
```

### Local Setup without Docker

1. Install Java 8 or higher
2. Download Forge installer and run it in the `server/` directory
3. Accept EULA in `server/eula.txt`
4. Run `./start.sh` from the `server/` directory

## ⚙️ Server Configuration

### Server Properties

Edit `server/server.properties` to customize:

- **server-port**: Default is 25565
- **max-players**: Default is 20
- **difficulty**: Options are peaceful, easy, normal, hard
- **gamemode**: survival, creative, adventure, spectator
- **view-distance**: Default is 10 (higher = more lag)
- **motd**: Server description shown in server list
- **online-mode**: Set to `false` for offline mode (not recommended)

### Memory Allocation

To change server memory allocation:

**In Docker Compose**: Edit `docker-compose.yml`
```yaml
environment:
  - JAVA_MEMORY=4G  # Change from 2G to 4G or more
```

**In Codespaces**: Set environment variable before starting
```bash
export JAVA_MEMORY=4G
./start.sh
```

## 🎮 Adding Mods

### Installing Mods

1. Download Forge-compatible mods for Minecraft 1.16.5
2. Place `.jar` files in the `server/mods/` directory:

**In Codespaces**:
```bash
cd /minecraft/mods
# Upload mods via VS Code file explorer, or use wget:
wget https://example.com/path-to-mod.jar
```

**Via Docker**:
- Just copy mods to `./server/mods/` on your host machine
- They'll be automatically mounted in the container

3. Restart the server for mods to take effect

### Recommended Mods

Popular server-side mods for 1.16.5:
- **JEI (Just Enough Items)**: Recipe viewing
- **JourneyMap**: World mapping
- **Biomes O' Plenty**: More biomes
- **Applied Energistics 2**: Tech mod
- **Tinkers' Construct**: Tool crafting
- **Thermal Expansion**: Tech and automation

**Important**: 
- All players need the same client-side mods installed
- Server-side only mods don't need to be on clients
- Always check mod compatibility with Forge 36.2.42

## 🌐 Connecting to the Server

### From GitHub Codespaces

1. In VS Code, go to **Ports** panel (View → Ports)
2. Find port **25565**
3. Note the **Forwarded Address** (looks like: `https://xxxxxx-25565.app.github.dev`)
4. Right-click and select **Port Visibility → Public** (if you want others to connect)
5. The actual server address will be shown in the "Local Address" column

**To connect**:
1. Open Minecraft 1.16.5 with Forge 36.2.42 installed
2. Add Server → Server Address: Use the forwarded address without `https://` and port
3. For Codespaces, you may need to use the format provided in the Ports tab

**Note**: Codespaces URLs change each time. Share the current URL with players.

### From Local Docker Setup

1. Server address: `localhost:25565` (from same machine)
2. Or your public IP: `YOUR_PUBLIC_IP:25565` (from internet)
3. Make sure port 25565 is open in your firewall

## 🔨 Server Management

### Starting the Server
```bash
./start.sh
# Or with Docker Compose
docker-compose up -d
```

### Stopping the Server
In server console, type:
```
stop
```

Or with Docker:
```bash
docker-compose down
```

### Restarting the Server
```bash
docker-compose restart
# Or
docker-compose down && docker-compose up -d
```

### Viewing Logs
```bash
# Real-time logs
docker-compose logs -f

# Last 100 lines
docker-compose logs --tail=100

# In server directory without Docker
tail -f logs/latest.log
```

### Server Console Commands

Common commands:
- `list` - Show online players
- `op <player>` - Make player an operator
- `deop <player>` - Remove operator status
- `whitelist add <player>` - Add player to whitelist
- `whitelist remove <player>` - Remove from whitelist
- `ban <player>` - Ban a player
- `pardon <player>` - Unban a player
- `save-all` - Save the world
- `stop` - Stop the server gracefully

## 🐛 Troubleshooting

### Server won't start

**Problem**: "forge-1.16.5-36.2.42.jar not found"
- **Solution**: Download and run the Forge installer (see Step 2)

**Problem**: "EULA not accepted"
- **Solution**: Set `eula=true` in `server/eula.txt` (see Step 3)

**Problem**: "Port 25565 already in use"
- **Solution**: Stop any other Minecraft servers or change the port in `server.properties`

### Cannot connect to server

**Problem**: Connection timeout
- **Solution**: 
  - Check if server is running: `docker-compose ps`
  - Verify port forwarding is configured
  - In Codespaces, ensure port visibility is set correctly

**Problem**: "Incompatible client" or version mismatch
- **Solution**: 
  - Ensure you're using Minecraft 1.16.5
  - Install Forge 36.2.42 on your client
  - Match all mods between client and server

### Low performance / lag

**Solutions**:
- Increase memory allocation (see Server Configuration)
- Reduce view-distance in server.properties
- Remove resource-intensive mods
- Upgrade to 8-core Codespace machine
- Reduce max-players

### World corruption

**Prevention**:
- Always use `stop` command instead of killing the process
- Regular backups:
```bash
tar -czf backup-$(date +%Y%m%d-%H%M%S).tar.gz server/world/
```

## 📚 Additional Resources

- [Minecraft Forge Documentation](https://docs.minecraftforge.net/)
- [Forge Downloads](https://files.minecraftforge.net/)
- [CurseForge Mods](https://www.curseforge.com/minecraft/mc-mods)
- [Modrinth Mods](https://modrinth.com/mods)
- [Server Properties Reference](https://minecraft.fandom.com/wiki/Server.properties)

## 📝 Manual Steps Summary

Since some steps cannot be automated, here's what you need to do manually:

### Required Manual Steps:

1. **Create GitHub Codespace**:
   - Go to repository → Code → Codespaces
   - Select "New with options"
   - Choose **4-core machine**
   - Select region closest to Brazil (São Paulo preferred)

2. **Download Forge Installer** (inside Codespace/server):
   ```bash
   wget https://maven.minecraftforge.net/net/minecraftforge/forge/1.16.5-36.2.42/forge-1.16.5-36.2.42-installer.jar
   java -jar forge-1.16.5-36.2.42-installer.jar --installServer
   ```

3. **Accept EULA**:
   ```bash
   sed -i 's/eula=false/eula=true/g' eula.txt
   ```

4. **Configure Port Forwarding**:
   - In Codespaces: Ports panel → Set port 25565 to Public

5. **Install Mods** (optional):
   - Download mods to `server/mods/` directory

6. **Start Server**:
   ```bash
   ./start.sh
   ```

## 📄 License

This server setup is provided as-is. Minecraft and Forge are property of their respective owners. Please comply with the [Minecraft EULA](https://account.mojang.com/documents/minecraft_eula).

## 🤝 Contributing

Feel free to open issues or submit pull requests to improve this setup!

---

**Happy Mining! ⛏️🎮**