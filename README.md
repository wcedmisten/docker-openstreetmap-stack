Running a full valhalla demo entirely self hosted!

Currently running at https://map-demo.wcedmisten.dev

# Clone the demo app

```
git clone git@github.com:wcedmisten/valhalla-app.git
cd valhalla-app
git checkout self-hosted
cd ..
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
You may want to expand the parameters used to include higher zoom levels.
Increasing zoom levels will take exponentionally more time to render
and more space to store, but will provide a better experience for the user.

There are also better ways to render zoom levels that don't include 
ocean tiles that should be used instead.

```
docker exec -it tile-server bash
sudo -u _renderd render_list -t /data/tiles -a -z 2 -Z 3 -n 16
```

