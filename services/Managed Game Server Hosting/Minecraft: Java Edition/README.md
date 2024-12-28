# [Managed Game Server Hosting](..) / Minecraft: Java Edition

**Minecraft: Java Edition** is simple to host but can quite quickly become expensive depending on the requirements of the client. For vanilla servers, the requirements are quite low, simply needing

## Recipe

The minimum resources for a Minecraft: Java Edition server are:

- 2 vCPUs @ 4.5 GHz combined clock speed
- 4 GB of RAM @ 2400 MHz
- 25 GB of SSD storage
- 100+ Mbps of bandwidth
- 1 IPv4 address with IP forwarding enabled
- 2 TCP ports open (25565 for the server, 25575 for RCON)
- 1 UDP port open (25565 for the server)

We can use multiple vendors to achieve this basic setup, such as GCP via [bash script](script.bash) or [Terraform](main.tf).
