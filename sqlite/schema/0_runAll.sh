#! /bin/bash

set -euo pipefail

test "$#" -eq 2 || (echo "Usage: $0 database_path snapshot_path" >&2; exit 1 )
DB="$1"
SNAPSHOT_PATH="$2"

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
SQLITE=${SQLITE:-sqlite3}

if [[ ! $( (echo 3.32.0; $SQLITE --version | cut -d ' ' -f 1) | sort --version-sort | head -n 1) = 3.32.0 ]]; then
    echo "SQLite version 3.32.0 later required; set \$SQLITE environment variable to use a different executable."
    exit 1
fi

echo Creating tables...
$SQLITE "$DB" < "$DIR"/1_createTables.sql
echo Creating indexes...
$SQLITE "$DB" < "$DIR"/2_createIndexes.sql
echo Importing data from snapshot files...
"$DIR"/3_importTables.sh "$SNAPSHOT_PATH" | $SQLITE "$DB"
echo Creating transitive closure tables...
$SQLITE "$DB" < "$DIR"/4_createTransitiveClosure.sql

while [ "$($SQLITE "$DB" < "$DIR"/5_addTransitiveClosures.sql)" -gt 0 ]
do true; done

echo "Creating AMT objects (this may take some time)..."
$SQLITE "$DB" < "$DIR"/6_createAMTObjects.sql
