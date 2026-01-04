#!/bin/bash

# Automated Forge Server Setup Script
# For Minecraft 1.16.5 with Forge 36.2.42

set -e

echo "=========================================="
echo "Minecraft Forge 1.16.5 Setup Script"
echo "Forge Version: 36.2.42"
echo "=========================================="
echo ""

# Check if we're in the right directory
if [ ! -f "start.sh" ]; then
    echo "ERROR: This script must be run from the server directory"
    echo "Please cd to /minecraft or the directory containing start.sh"
    exit 1
fi

# Check if Java is installed
if ! command -v java &> /dev/null; then
    echo "ERROR: Java is not installed!"
    echo "Please install Java 8 or higher first."
    exit 1
fi

echo "✓ Java is installed:"
java -version
echo ""

# Check if forge is already installed
if [ -f "forge-1.16.5-36.2.42.jar" ]; then
    echo "⚠ Forge server jar already exists!"
    read -p "Do you want to reinstall? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Skipping Forge installation..."
    else
        echo "Removing old installation..."
        rm -f forge-1.16.5-36.2.42.jar
    fi
fi

# Download Forge installer if needed
if [ ! -f "forge-1.16.5-36.2.42.jar" ]; then
    echo "📥 Downloading Forge installer..."
    
    INSTALLER_URL="https://maven.minecraftforge.net/net/minecraftforge/forge/1.16.5-36.2.42/forge-1.16.5-36.2.42-installer.jar"
    
    if command -v wget &> /dev/null; then
        wget -q --show-progress "$INSTALLER_URL" -O forge-installer.jar
    elif command -v curl &> /dev/null; then
        curl -L -o forge-installer.jar "$INSTALLER_URL"
    else
        echo "ERROR: Neither wget nor curl is available!"
        echo "Please install wget or curl to continue."
        exit 1
    fi
    
    echo "✓ Forge installer downloaded"
    echo ""
    
    # Run the installer
    echo "🔧 Installing Forge server..."
    echo "This may take several minutes..."
    java -jar forge-installer.jar --installServer
    
    if [ $? -eq 0 ]; then
        echo "✓ Forge installed successfully"
        
        # Clean up
        rm -f forge-installer.jar
        rm -f forge-installer.jar.log
        echo "✓ Cleaned up installer files"
    else
        echo "ERROR: Forge installation failed!"
        exit 1
    fi
fi

echo ""
echo "=========================================="
echo "Checking EULA acceptance..."
echo "=========================================="
echo ""

# Check EULA
if grep -q "eula=false" eula.txt 2>/dev/null; then
    echo "⚠ Minecraft EULA not accepted"
    echo ""
    echo "The Minecraft End User License Agreement (EULA) must be accepted to run the server."
    echo "Please read it at: https://account.mojang.com/documents/minecraft_eula"
    echo ""
    read -p "Do you accept the Minecraft EULA? (y/N): " -n 1 -r
    echo
    
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        sed -i 's/eula=false/eula=true/g' eula.txt
        echo "✓ EULA accepted"
    else
        echo "⚠ EULA not accepted. You must accept it to run the server."
        echo "You can manually edit eula.txt and set eula=true"
        exit 1
    fi
else
    echo "✓ EULA already accepted"
fi

echo ""
echo "=========================================="
echo "Setup Complete!"
echo "=========================================="
echo ""
echo "✓ Forge 1.16.5-36.2.42 is installed"
echo "✓ EULA is accepted"
echo "✓ Server is ready to start"
echo ""
echo "To start the server, run:"
echo "  ./start.sh"
echo ""
echo "To add mods, place .jar files in the 'mods/' directory"
echo ""
echo "Server will be available on port 25565"
echo ""
echo "Happy Mining! ⛏️"
echo ""
