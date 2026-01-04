# Manual Setup Instructions for User

This document contains the specific steps that you need to perform manually, as they cannot be automated.

## ⚠️ IMPORTANT: Read This First

This repository is now configured with everything needed to run a Minecraft Forge 1.16.5 server. However, some steps **require manual action** from you:

---

## 🌟 Step 1: Create a GitHub Codespace (Recommended)

### Why Codespaces?
- No local installation needed
- Pre-configured 4-core environment
- Can select region closest to Brazil
- Easy port forwarding
- Free tier available

### How to Create:

1. **Go to this repository on GitHub** (https://github.com/Nirayuki/minecraft-server)

2. **Click the green "Code" button** at the top right

3. **Click on the "Codespaces" tab**

4. **IMPORTANT**: Don't click "Create codespace" yet! Instead:
   - Click the **"..." (three dots)** button
   - Select **"New with options..."**

5. **Configure your Codespace**:
   - **Branch**: Select your working branch (likely `main` or `copilot/create-minecraft-server-1-16-5`)
   - **Machine type**: ⚠️ **SELECT "4-core"** (8 GB RAM, 32 GB storage)
     - This is critical for server performance!
   - **Region**: Choose the closest to Brazil:
     - **BEST**: "South America (São Paulo)" - if available
     - **Good**: "US East (Virginia)" - good latency to Brazil
     - **Alternative**: "US South (Texas)" - reasonable latency
   
6. **Click "Create codespace"**

7. **Wait for the environment to initialize** (2-3 minutes)

---

## 🔧 Step 2: Install Forge Server (Inside Codespace)

Once your Codespace is ready, you'll see a VS Code interface. Now you need to install the Forge server files:

### Option A: Automatic Installation (Recommended)

Run the automated setup script:

```bash
cd /minecraft
./setup.sh
```

This script will:
- Download the Forge installer
- Install Forge server
- Prompt you to accept the EULA
- Clean up temporary files

**Follow the prompts and accept the EULA when asked.**

### Option B: Manual Installation

If you prefer to do it manually:

```bash
# Navigate to server directory
cd /minecraft

# Download Forge installer
wget https://maven.minecraftforge.net/net/minecraftforge/forge/1.16.5-36.2.42/forge-1.16.5-36.2.42-installer.jar

# Run installer
java -jar forge-1.16.5-36.2.42-installer.jar --installServer

# Wait for installation to complete (may take a few minutes)

# Clean up installer
rm forge-1.16.5-36.2.42-installer.jar
```

---

## ⚖️ Step 3: Accept the Minecraft EULA

**This is REQUIRED to run the server.**

You need to indicate that you accept Mojang's End User License Agreement.

### Read the EULA:
👉 https://account.mojang.com/documents/minecraft_eula

### Accept it:

**Option A**: Use the automated command:
```bash
sed -i 's/eula=false/eula=true/g' /minecraft/eula.txt
```

**Option B**: Edit manually:
```bash
nano /minecraft/eula.txt
```
- Change `eula=false` to `eula=true`
- Press `Ctrl+X`, then `Y`, then `Enter` to save

---

## 🚀 Step 4: Start the Server

Now you can start your Minecraft server:

```bash
cd /minecraft
./start.sh
```

**What happens next:**
- The server will start initializing
- First startup takes 3-5 minutes (generating world, loading mods, etc.)
- You'll see logs scrolling in the terminal
- When you see "Done!" the server is ready

**Server is ready when you see:**
```
[Server thread/INFO]: Done (X.XXXs)! For help, type "help"
```

---

## 🌐 Step 5: Configure Port Forwarding (For Multiplayer)

To allow you and others to connect from Minecraft:

1. **In VS Code, open the Ports panel**:
   - Menu: **View → Ports**
   - Or press `Ctrl+Shift+P` and type "Ports"

2. **Find port 25565** in the list
   - It should auto-detect when the server starts

3. **Make it accessible**:
   - Right-click on port 25565
   - Select **"Port Visibility"**
   - Choose **"Public"** if you want others to connect
   - Choose **"Private"** if only you should connect

4. **Get the connection address**:
   - Look in the "Forwarded Address" column
   - It will look like: `random-name-xxxx.app.github.dev`
   - **This is what you'll use to connect from Minecraft**

5. **Note**: The address changes each time you create a new Codespace!

---

## 🎮 Step 6: Connect from Minecraft

### Install Minecraft Forge on Your Computer:

1. **Download Forge 1.16.5-36.2.42 Client**:
   - Go to: https://files.minecraftforge.net/net/minecraftforge/forge/index_1.16.5.html
   - Download the **Installer** for version **36.2.42**
   - Run the installer and select "Install Client"

2. **Launch Minecraft**:
   - Open Minecraft Launcher
   - Select the **"Forge 1.16.5"** profile
   - Click **Play**

### Connect to Your Server:

1. In Minecraft, click **"Multiplayer"**

2. Click **"Add Server"**

3. **Server Info**:
   - **Server Name**: Whatever you want (e.g., "My Forge Server")
   - **Server Address**: Use the forwarded address from Step 5
     - Example: `random-name-xxxx.app.github.dev:25565`
     - Or just: `random-name-xxxx.app.github.dev` (port is implied)

4. Click **"Done"**, then **double-click** your server to join!

---

## 🎯 Step 7: Adding Mods (Optional)

To add mods to your server:

### 1. Find Mods:
- **CurseForge**: https://www.curseforge.com/minecraft/mc-mods
- **Modrinth**: https://modrinth.com/mods
- **Filter by**: Minecraft 1.16.5, Forge compatible

### 2. Download Mods:
- Download the `.jar` file(s)
- Make sure they're for **Minecraft 1.16.5** and **Forge**

### 3. Add to Server:
In your Codespace terminal:
```bash
cd /minecraft/mods
# Upload via VS Code or use wget:
wget https://example.com/path-to-mod.jar
```

Or use VS Code file explorer to drag-and-drop into `/minecraft/mods/`

### 4. Install on Client:
- Place the **SAME mods** in your local Minecraft mods folder:
  - Windows: `%APPDATA%\.minecraft\mods`
  - Mac: `~/Library/Application Support/minecraft/mods`
  - Linux: `~/.minecraft/mods`

### 5. Restart Server:
In server console, type:
```
stop
```
Then start again:
```bash
./start.sh
```

---

## 📊 Step 8: Server Management

### Useful Commands (type in server console):

- `list` - Show online players
- `op <username>` - Make someone an admin
- `stop` - Stop the server gracefully
- `save-all` - Force save the world
- `whitelist add <username>` - Whitelist a player

### Viewing Logs:
```bash
tail -f /minecraft/logs/latest.log
```

### Stopping the Server:
Type `stop` in the server console (don't use Ctrl+C!)

### Restarting:
```bash
./start.sh
```

---

## 🔧 Troubleshooting Common Issues

### "Connection refused" when trying to connect:
- ✅ Make sure server is running
- ✅ Check port 25565 is forwarded (Step 5)
- ✅ Verify port visibility is set to Public
- ✅ Use the correct forwarded address

### "Outdated client" or "Outdated server":
- ✅ Make sure you're using Minecraft 1.16.5
- ✅ Install Forge 36.2.42 on your client
- ✅ Match mod versions between client and server

### Server lag or low performance:
- ⚙️ Consider upgrading to 8-core Codespace
- ⚙️ Reduce view-distance in server.properties
- ⚙️ Remove resource-intensive mods

### Out of memory errors:
- Edit `start.sh` and change `MEMORY=2G` to `MEMORY=4G`
- Restart the server

---

## 📝 Summary Checklist

- [ ] Create GitHub Codespace with 4-core machine
- [ ] Select region closest to Brazil
- [ ] Run `./setup.sh` to install Forge
- [ ] Accept EULA when prompted
- [ ] Start server with `./start.sh`
- [ ] Configure port forwarding to Public
- [ ] Install Forge client on your computer
- [ ] Connect using the forwarded address
- [ ] (Optional) Add mods to both server and client
- [ ] Enjoy your server! 🎮

---

## 🆘 Getting Help

- **Server not starting?** Check `/minecraft/logs/latest.log`
- **Can't connect?** Verify port forwarding is configured
- **Mods not working?** Ensure same mods on client and server
- **Performance issues?** See troubleshooting section

For more detailed instructions, see **README.md** and **QUICKSTART.md**.

---

**Happy Mining! ⛏️🎮**

