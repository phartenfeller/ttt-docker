# Docker Trouble in Terrorist Town

```sh
docker run -d -t \
  -p 27015:27015 -p 27015:27015/udp -p 27005:27005 -p 27005:27005/udp \
  --name gmod-ttt \
  --env-file path/to/your/ttt.env \
  ghcr.io/phartenfeller/trouble-in-ttown:latest
```

## Env file 

```sh
HOSTNAME=my-ttt-server
MAXPLAYERS=20
HOST_WORKSHOP_COLLECTION=45415314654 # your workshop collection ID from the URL
RCON_PASS=secret_password
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
PORT=27015
GAMEMODE=terrortown
MAP=gm_construct
```

## Debug

Enter with shell:

```sh
docker run -it -t \
  -p 27015:27015 -p 27015:27015/udp -p 27005:27005 -p 27005:27005/udp \
  --name gmod-ttt-debug \
  --env-file path/to/your/ttt.env \
  --rm \
  ghcr.io/phartenfeller/trouble-in-ttown:latest
```
