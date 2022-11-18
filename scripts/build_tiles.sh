#!/bin/bash

mkdir /data/valhalla/valhalla_tiles

if ! test -f "/data/valhalla/valhalla.json"; then
    echo "Valhalla JSON not found. Creating config." 
    valhalla_build_config --mjolnir-tile-dir /data/valhalla/valhalla_tiles --mjolnir-tile-extract /data/valhalla/valhalla_tiles.tar --mjolnir-timezone /data/valhalla/valhalla_tiles/timezones.sqlite --mjolnir-admin /data/valhalla/valhalla_tiles/admins.sqlite > /data/valhalla/valhalla.json
fi

if ! test -f "/data/valhalla/valhalla_tiles/timezones.sqlite"; then
    echo "Valhalla tiles not found. Building now."
    valhalla_build_timezones > /data/valhalla/valhalla_tiles/timezones.sqlite
    valhalla_build_tiles -c /data/valhalla/valhalla.json /data/valhalla/region.osm.pbf
fi

if ! test -f "/data/valhalla/valhalla_tiles.tar"; then
    echo "Tile extract not found. Extracting now."
    valhalla_build_extract -c /data/valhalla/valhalla.json -v
fi

echo "Starting valhalla server."
valhalla_service /data/valhalla/valhalla.json 1

