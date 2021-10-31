#!/bin/bash

# help text
Help() {
	echo "starts a minecraft server!"
	echo
	echo "-h    Help!"
	echo "-u    Select a universe"
	echo "-w    Select a world"
}

# default vars
universe=""
world=""
memory=2048

# process inputs
while getopts u:w:h flag; do
	case "${flag}" in
		h) Help
		   exit;;

		u) universe=${OPTARG}
		   echo $universe > last_universe;;

		w) world=${OPTARG};;
	esac
done

if [ $universe ] && [ -z $world ]; then
	echo "ERROR: A universe is defined, but a world is not."
	exit 1;
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
	motd=A Minecraft Server
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

echo "starting up server using ${universe:+universe $universe and }world ${world}..."

if [ -a fabric-server-launch.jar ]; then
	serverjar="fabric-server-launch.jar"
elif [ -a server.jar ]; then
	serverjar="server.jar"
else
	echo "ERROR: could not find server jar."
fi

echo "using ${serverjar} with ${memory}M of memory..."

java -Xmx${memory}M -Xms${memory}M -jar ${serverjar} ${universe:+--universe $universe } ${world:+ --world $world}

exit 0;
