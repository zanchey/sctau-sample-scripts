#! /bin/bash

# ------------------------------------------------------------------------------
# IMPORT FILES AND CREATE TABLES FROM HEADERS
# ------------------------------------------------------------------------------

# Pipe the output of this file into sqlite3
# Takes one argument - the directory containing the "Terminology" and "Refset" directories

set -euo pipefail

test "$#" -eq 1 || (echo "$0: specify the snapshot directory as the sole argument" >&2; exit 1 )
test -d "$1/Terminology" -a -d "$1/Refset" || ( echo "$0: Terminology and Refset directories not found in $1" >&2; exit 1)

# Using ".mode tabs" is tempting, but the refsets contain unescaped quotation marks, so use pretend TSV instead
echo ".mode ascii"
# Files are shipped with Windows line endings
echo ".separator \"\\t\" \"\\n\""

echo "PRAGMA foreign_keys = ON;"

# Use WAL mode - see https://sqlite.org/wal.html
echo "PRAGMA journal_mode=WAL;"

# RF2_CONCEPTS_SNAPSHOT
echo "DELETE FROM concepts_snapshot;"

date=$(basename -s .txt "$1"/Terminology/sct2_Concept_Snapshot_AU1000036_*.txt)
date=${date#sct2_Concept_Snapshot_AU1000036_}

echo ".import --skip 1 \"$1/Terminology/sct2_Concept_Snapshot_AU1000036_$date.txt\" concepts_snapshot"

# RF2_DESCRIPTIONS_SNAPSHOT
echo "DELETE FROM descriptions_snapshot;"

echo ".import --skip 1 \"$1/Terminology/sct2_Description_Snapshot-en-AU_AU1000036_$date.txt\" descriptions_snapshot"

# RF2_RELATIONSHIPS_SNAPSHOT
echo "DELETE FROM relationships_snapshot;"

echo ".import --skip 1 \"$1/Terminology/sct2_Relationship_Snapshot_AU1000036_$date.txt\" relationships_snapshot"

# RF2_LANGUAGE_REFSET_SNAPSHOT
echo "DELETE FROM language_refset_snapshot;"

echo ".import --skip 1 \"$1/Refset/Language/der2_cRefset_LanguageSnapshot-en-AU_AU1000036_$date.txt\" language_refset_snapshot"

# RF2_REFSET_SNAPSHOT
# NOTE: This SQL Statement will have to be executed once for every Refset file to ensure that all the Refsets in the release are in the table.
# 11000036103 Adverse reaction type reference set; 32570071000036102 Clinical finding foundation reference set; 171991000036103 Clinical finding grouper exclusion reference set; 929360051000036108 Containered trade product pack reference set; 929360061000036106 Medicinal product reference set; 929360081000036101 Medicinal product pack reference set; 929360071000036103 Medicinal product unit of use reference set; 32570351000036105 Musculoskeletal finding reference set; 929360021000036102 Trade product reference set; 929360041000036105 Trade product pack reference set; 929360031000036100 Trade product unit of use reference set; 1050951000168102 Schedule 8 medications reference set

echo "DELETE FROM refset_snapshot;"

for i in "$1"/Refset/Content/der2_Refset_* ; do
    echo ".import --skip 1 \"$i\" refset_snapshot"
done

# RF2_CREFSET_SNAPSHOT
# Import historical association reference sets
echo "DELETE FROM crefset_snapshot;"

echo ".import --skip 1 \"$1/Refset/Content/der2_cRefset_AssociationReferenceSnapshot_AU1000036_$date.txt\" crefset_snapshot"

# RF2_CCREFSET_SNAPSHOT
# Import extended association schema refset. Currently only one exists - Route and form extended association
echo "DELETE FROM ccrefset_snapshot;"

echo ".import --skip 1 \"$1/Refset/Content/der2_ccRefset_DoseRouteAndFormExtendedAssociationSnapshot_AU1000036_$date.txt\" ccrefset_snapshot"

# RF2_CCSREFSET_SNAPSHOT
# Import the three concrete domain reference sets
#    * 700000111000036105	Strength reference set
#    * 700000131000036101	Unit of use quantity reference set
#    * 700000141000036106	Unit of use size reference set

echo "DELETE FROM ccsrefset_snapshot;"

echo ".import --skip 1 \"$1/Refset/Content/der2_ccsRefset_StrengthSnapshot_AU1000036_$date.txt\" ccsrefset_snapshot"

echo ".import --skip 1  \"$1/Refset/Content/der2_ccsRefset_UnitOfUseQuantitySnapshot_AU1000036_$date.txt\" ccsrefset_snapshot"

echo ".import --skip 1 \"$1/Refset/Content/der2_ccsRefset_UnitOfUseSizeSnapshot_AU1000036_$date.txt\" ccsrefset_snapshot"

# RF2_CCIREFSET_SNAPSHOT
# Import the 700000121000036103 Subpack quantity reference set
echo "DELETE FROM ccirefset_snapshot;"

echo ".import --skip 1 \"$1/Refset/Content/der2_cciRefset_SubpackQuantitySnapshot_AU1000036_$date.txt\" ccirefset_snapshot"

# RF2_IREFSET_SNAPSHOT
# Import the 11000168105 ARTG Id reference set
echo "DELETE FROM irefset_snapshot;"

echo ".import --skip 1 \"$1/Refset/Map/der2_iRefset_ARTGIdSnapshot_AU1000036_$date.txt\" irefset_snapshot"
