Running a full valhalla demo entirely self hosted!

Currently running at https://map-demo.wcedmisten.dev

# Clone the demo app

```
git clone git@github.com:wcedmisten/valhalla-app.git
git checkout self-hosted
```

# Build the demo app

```
docker compose build
```

# Import the data

```
mkdir ./osm-pbf
cp /path/to/osm.pbf ./osm-pbf/region.osm.pbf
./import.sh
```

# Run the apps

```
docker compose up
```

# Postgres config

import-postgresql.conf is used for import. The main difference is that autovacuum is off.

run-postgresql.conf has it turned on. This config is tuned for my machine with 128 GB of RAM and 16 CPUs.

# Pre-render tiles at low zoom

```
docker exec -it tile-server bash
sudo -u _renderd render_list -t /data/tiles -a -z 2 -Z 3 -n 16
```

