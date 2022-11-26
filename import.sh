#!/bin/bash
set -eo pipefail

echo "Creating docker volumes"
docker volume create osm-data
docker volume create osm-tiles
docker volume create valhalla-data
docker volume create nominatim-data

echo "Importing data for tile server"
docker run \
    -v $(pwd)/osm-pbf/region.osm.pbf:/data/region.osm.pbf \
    -v osm-data:/data/database/ \
    -v $(pwd)/import-postgresql.conf:/etc/postgresql/14/main/postgresql.custom.conf.tmpl \
    -e THREADS=16 \
    -e "OSM2PGSQL_EXTRA_ARGS=-C 16384" \
    overv/openstreetmap-tile-server \
    import

echo "Importing data for valhalla"
docker run \
    -v $(pwd)/osm-pbf/region.osm.pbf:/data/region.osm.pbf \
    -v $(pwd)/scripts:/scripts \
    -v valhalla-data:/data/valhalla \
    valhalla/valhalla:run-latest \
    /scripts/import_data.sh

