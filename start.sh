#!/bin/bash

# default vars
universe=""
world=""
memory=2048  # in megabytes.
line_two=""  # of motd

# colors!
RED='\033[0;31m'
GRN='\033[0;32m'
NC='\033[0m'

# help text
Help() {
	echo -e "starts a minecraft server!"
	echo -e
	echo -e "-h    Help!"
	echo -e "-u    Select a universe"
	echo -e "-w    Select a world"
}

# process inputs
while getopts u:w:h flag; do
	case "${flag}" in
		h) Help
		   exit;;

		u) universe="${OPTARG}";;

		w) world=${OPTARG};;

		*) echo -e "ERROR: Invalid flag."
		   exit;;
	esac
done

if [ "$universe" ] && [ -z "$world" ]; then
	echo -e "${RED}ERROR: A universe is defined, but a world is not.${NC}"
	exit 1;
fi

# creating an motd...
line_one="\u00a7b\u00a7lProject Ayu\u00a7b \/ ${universe:+u: $universe >} ${world:+w: $world}\u00a7r"
if [ -a motd_lines ] && [ "$line_two" ]; then  # getting a random line from a file
	line_two=$(shuf -n 1 motd_lines)
else
	line_two=""
fi

cat > server.properties <<- EOM
	#Minecraft server properties
	#$(date)
	#File automatically set by script!
	broadcast-rcon-to-ops=true
	view-distance=8
	enable-jmx-monitoring=false
	server-ip=
	resource-pack-prompt=
	rcon.port=25575
	gamemode=survival
	server-port=25565
	allow-nether=true
	enable-command-block=false
	enable-rcon=false
	sync-chunk-writes=true
	enable-query=false
	op-permission-level=4
	prevent-proxy-connections=false
	resource-pack=
	entity-broadcast-range-percentage=100
	level-name=${world}
	rcon.password=
	player-idle-timeout=0
	motd=${line_one}\n${line_two}
	query.port=25565
	force-gamemode=false
	rate-limit=0
	hardcore=false
	white-list=false
	broadcast-console-to-ops=true
	pvp=true
	spawn-npcs=true
	spawn-animals=true
	snooper-enabled=true
	difficulty=easy
	function-permission-level=2
	network-compression-threshold=256
	text-filtering-config=
	require-resource-pack=false
	spawn-monsters=true
	max-tick-time=60000
	enforce-whitelist=false
	use-native-transport=true
	max-players=20
	resource-pack-sha1=
	spawn-protection=16
	online-mode=true
	enable-status=true
	allow-flight=false
	max-world-size=29999984
EOM

echo -e "${GRN}starting up server using ${universe:+universe $universe and }world ${world}...${NC}"

if [ -a fabric-server-launch.jar ]; then
	serverjar="fabric-server-launch.jar"
elif [ -a server.jar ]; then
	serverjar="server.jar"
else
	echo -e "${RED}ERROR: could not find server jar.${NC}"
fi

echo -e "${GRN}using ${serverjar} with ${memory}M of memory...${NC}"

java -Xmx${memory}M -Xms${memory}M -jar ${serverjar} ${universe:+--universe universes/$universe } ${world:+ --world $world} --nogui

echo -e "${RED}server has stopped!${NC}" 

exit 0;
