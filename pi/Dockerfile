### qbittorrent
docker run \
  --name=qbittorrent \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Europe/London \
  -e WEBUI_PORT=8088 \
  -p 8088:8088 \
  -p 6881:6881 \
  -p 6881:6881/udp \
  -v /home/pi/qb/appdata/config:/config \
  -v /mnt/share/下载:/downloads \
  --restart unless-stopped 

### aria2
  docker run -d \
    --name aria2-pro \
    --restart unless-stopped \
    --log-opt max-size=1m \
    --network host \
    -e PUID=1000 \
    -e PGID=1000 \
    -e RPC_SECRET=zhangjh \
    -e RPC_PORT=6800 \
    -e LISTEN_PORT=6888 \
    -v /home/pi/aria2/aria2-config:/config \
    -v /mnt/share/下载:/downloads \
    p3terx/aria2-pro

### ariang
docker run -d \
  --name ariang \
  --log-opt max-size=1m \
  --restart unless-stopped \
  -p 6880:6880 \
  p3terx/ariang
