#!/bin/bash

# downloading fabric...
curl https://maven.fabricmc.net/net/fabricmc/fabric-installer/0.8.3/fabric-installer-0.8.3.jar -o fabric-installer.jar
java -jar fabric-installer.jar server -downloadMinecraft
echo "if fabric-installer.jar succeeded, you can delete it now."
echo "eula=true" > eula.txt

# downloading lithium...
curl -s https://api.github.com/repos/CaffeineMC/lithium-fabric/releases/latest \
| grep "browser_download_url.*jar" \
| grep -v "api" \
| cut -d : -f 2,3 \
| tr -d \" \
| wget -P ./mods/ -qi -

echo "stuff downloaded, you can probably start the server now."
