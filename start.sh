#!/bin/bash

# Minecraft Forge Server Startup Script
# For Minecraft 1.16.5 with Forge 36.2.42

# Version configuration
FORGE_VERSION="1.16.5-36.2.42"
FORGE_JAR="forge-${FORGE_VERSION}.jar"

# Check if minecraft directory exists and change to it
if [ -d "/minecraft" ]; then
    cd /minecraft
elif [ -f "$FORGE_JAR" ]; then
    # Already in correct directory
    :
else
    echo "ERROR: Cannot find Minecraft server directory!"
    echo "Please ensure you're in the correct directory or /minecraft exists."
    exit 1
fi

# Set memory allocation (default 2GB, can be overridden by environment variable)
MEMORY=${JAVA_MEMORY:-2G}

echo "Starting Minecraft Forge Server 1.16.5 (Forge 36.2.42)"
echo "Allocated Memory: $MEMORY"
echo "=========================================="

# Check if forge server jar exists
if [ ! -f "$FORGE_JAR" ]; then
    echo "ERROR: $FORGE_JAR not found!"
    echo "Please download and install Forge 1.16.5-36.2.42 first."
    echo "Visit: https://files.minecraftforge.net/net/minecraftforge/forge/index_1.16.5.html"
    exit 1
fi

# Check if EULA is accepted
if [ ! -f "eula.txt" ]; then
    echo "eula=false" > eula.txt
    echo "ERROR: EULA not accepted. Please set eula=true in eula.txt"
    exit 1
fi

# Start the server with optimized JVM flags
java -Xms${MEMORY} -Xmx${MEMORY} \
    -XX:+UseG1GC \
    -XX:+ParallelRefProcEnabled \
    -XX:MaxGCPauseMillis=200 \
    -XX:+UnlockExperimentalVMOptions \
    -XX:+DisableExplicitGC \
    -XX:+AlwaysPreTouch \
    -XX:G1NewSizePercent=30 \
    -XX:G1MaxNewSizePercent=40 \
    -XX:G1HeapRegionSize=8M \
    -XX:G1ReservePercent=20 \
    -XX:G1HeapWastePercent=5 \
    -XX:G1MixedGCCountTarget=4 \
    -XX:InitiatingHeapOccupancyPercent=15 \
    -XX:G1MixedGCLiveThresholdPercent=90 \
    -XX:G1RSetUpdatingPauseTimePercent=5 \
    -XX:SurvivorRatio=32 \
    -XX:+PerfDisableSharedMem \
    -XX:MaxTenuringThreshold=1 \
    -Dusing.aikars.flags=https://mcflags.emc.gs \
    -Daikars.new.flags=true \
    -jar $FORGE_JAR nogui
