# Minecraft Forge 1.16.5 Server Dockerfile
FROM openjdk:8-jdk-slim

# Install necessary packages
RUN apt-get update && \
    apt-get install -y wget curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /minecraft

# Create necessary directories
RUN mkdir -p /minecraft/mods /minecraft/config /minecraft/world /minecraft/logs

# Copy server files
COPY server/ /minecraft/
COPY start.sh /minecraft/

# Make start script executable
RUN chmod +x /minecraft/start.sh

# Expose Minecraft server port
EXPOSE 25565

# Set environment variables
ENV JAVA_MEMORY=2G
ENV MINECRAFT_VERSION=1.16.5
ENV FORGE_VERSION=36.2.42

# Run the server
CMD ["/minecraft/start.sh"]
