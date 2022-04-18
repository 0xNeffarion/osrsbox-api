#!/bin/bash
: '
Author:  PH01L
Email:   phoil@osrsbox.com
Website: https://www.osrsbox.com

Update the API after a osrsbox package update

Copyright (c) 2020, PH01L

###############################################################################
This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.
This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.
You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
###############################################################################
'

git pull

# Clean docker environment
bash clean.sh

# Build and run docker environment, as a background process
docker-compose up -d --build

# Update osrsbox data
docker exec -t osrsbox-api-eve python3 /scripts/mongo_insert_osrsbox.py

# Clear cache after update
docker exec -t osrsbox-api-nginx rm -rf /etc/nginx/cache/*
