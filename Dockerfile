FROM ubuntu:xenial

RUN apt-get update && \
  apt-get install -y wget lib32gcc1 lib32tinfo5 unzip nginx lib32stdc++6 lib32z1 lib32z1-dev ca-certificates

RUN useradd -ms /bin/bash steam
WORKDIR /home/steam

USER steam

RUN wget -O /tmp/steamcmd_linux.tar.gz http://media.steampowered.com/installer/steamcmd_linux.tar.gz && \
  tar -xvzf /tmp/steamcmd_linux.tar.gz && \
  rm /tmp/steamcmd_linux.tar.gz

RUN ./steamcmd.sh +login anonymous +force_install_dir ./gmod-base +app_update 4020 validate +quit
RUN ./steamcmd.sh +login anonymous +force_install_dir ./cstrike-base +app_update 232330 validate +quit


# ----------------
# Annoying lib fix
# --------------


#RUN mkdir /gmod-libs
#WORKDIR /gmod-libs
#RUN wget http://launchpadlibrarian.net/195509222/libc6_2.15-0ubuntu10.10_i386.deb
#RUN dpkg -x libc6_2.15-0ubuntu10.10_i386.deb .
#RUN cp -a lib/i386-linux-gnu/. /gmod-base/bin/
#WORKDIR /
#RUN rm -rf /gmod-libs
#RUN cp /steamcmd/linux32/libstdc++.so.6 /gmod-base/bin/

#RUN mkdir -p /home/steam/.steam/sdk32/
#RUN cp -a /steamcmd/linux32/. /home/steam/.steam/sdk32/

# ----------------------
# Setup Volume and Union
# ----------------------
#
#RUN mkdir /gmod-volume
#VOLUME /gmod-volume
#RUN chown -R steam /gmod-volume /gmod-base /steamcmd /home/steam /cstrike-base

# ---------------
# Setup Container
# ---------------

ADD ./start-server.sh start-server.sh

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

CMD ./start-server.sh
