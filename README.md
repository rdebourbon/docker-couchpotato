#docker couchpotato

This is a Dockerfile to set up "CouchPotato" - (https://couchpota.to/)

Build from docker file

```
git clone https://github.com/rdebourbon/docker-couchpotato.git
cd docker-couchpotato
docker build -t couchpotato .
```

docker run -d -h *your_host_name* -v /*your_config_location*:/volumes/config  -v /*your_videos_location*:/volumes/media -p 5050:5050 --name couchpotato couchpotato

