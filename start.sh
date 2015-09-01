#! /bin/sh

cd /CouchPotatoServer
touch /volumes/config/CouchPotato.cfg

/usr/bin/python /CouchPotatoServer/CouchPotato.py --data_dir /volumes/config/ --config_file /volumes/config/CouchPotato.cfg --console_log
