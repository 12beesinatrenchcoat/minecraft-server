# minecraft-server

a handful of things that help me start up/maintain my own minecraft server, or something like that. designed for use on linux systems, may or may not work on windows.

runs [fabric server](https://fabricmc.net/) with [lithium](https://github.com/CaffeineMC/lithium-fabric) mod.

# how to use

make sure you have java ≥ 16 installed. (and also you need `curl` and `wget`, but you probably have those already.)

```bash
sudo apt install openjdk-17-jre  # openjdk-16-jre also works
```

[download the repository](https://github.com/12beesinatrenchcoat/minecraft-server/archive/refs/heads/master.zip) (as a .zip, unless you want to contribute), unzip, and open it in a terminal, or something.

run `download-server.sh` to download server files (fabric server + lithium). after that, you can run `start.sh` to start the server. make modifications to the default variables if needed.

```bash
start.sh
starts a minecraft server!

-h    Help!
-u    Select a universe
-w    Select a world
```

## random second line of motd

if you want the second line of the motd to be random on each server startup (because that's a feature, i guess!) make a new file called `motd_lines` and start writing stuff (separate with newlines).

# other stuff

this repo (but not its dependencies) is under [the unlicense](./LICENSE.txt). do what you want. please don't expect support for this.

this repo does not port forward your server or anything of the sort; if you want others over the internet to connect to your server, figure that out.

i am not associated with mojang, microsoft, or anyone associated with minecraft. 

