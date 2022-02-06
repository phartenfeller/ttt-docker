FROM ubuntu:xenial

LABEL org.opencontainers.image.source https://github.com/phartenfeller/ttt-docker

RUN apt-get update && \
  apt-get install -y wget lib32gcc1 lib32tinfo5 unzip nginx lib32stdc++6 lib32z1 lib32z1-dev ca-certificates

RUN useradd -ms /bin/bash steam
WORKDIR /home/steam

USER steam

RUN wget -O /tmp/steamcmd_linux.tar.gz http://media.steampowered.com/installer/steamcmd_linux.tar.gz && \
  tar -xvzf /tmp/steamcmd_linux.tar.gz && \
  rm /tmp/steamcmd_linux.tar.gz

# Install GMOD
RUN ./steamcmd.sh +login anonymous +force_install_dir ./gmod-base +app_update 4020 validate +quit

# Verify (sometimes something is missing...)
RUN ./steamcmd.sh +login anonymous +force_install_dir ./gmod-base +app_update 4020 validate +quit

# Install Counter Strike Source (for some assets)
RUN ./steamcmd.sh +login anonymous +force_install_dir ./cstrike-base +app_update 232330 validate +quit

ADD ./start-server.sh start-server.sh

# Add cstrike mount file
ADD ./static/mount.cfg /home/steam/gmod-base/garrysmod/cfg/mount.cfg

USER root
RUN chmod +x ./start-server.sh && chown steam ./start-server.sh

USER steam


EXPOSE 27015/udp
EXPOSE 27015/tcp
EXPOSE 27005/udp
EXPOSE 27006/tcp

ENV PORT="27015"
ENV MAXPLAYERS="16"
ENV HOSTNAME="Garry's Mod"
ENV GAMEMODE="terrortown"
ENV MAP="gm_construct"
ENV HOST_WORKSHOP_COLLECTION = ""

RUN ln -s /home/steam/linux32/ /home/steam/.steam/sdk32

VOLUME /home/steam/gmod-base/garrysmod

CMD ./start-server.sh
