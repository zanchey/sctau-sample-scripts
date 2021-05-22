# Prerequisites
These scripts require SQLite version 3.32.0 or later.

The scripts also require an unpacked release of SNOMED CT-AU available. SNOMED CT-AU may be downloaded from <https://www.healthterminologies.gov.au/access> or using the [National Syndication Server](https://www.healthterminologies.gov.au/tools?content=nts) for automated downloading.

# How to use these scripts

The `0_runAll.sh` script will connect to the database given as the first argument, and import the snapshot which has been unzipped at the path listed by the second argument.

For example:

```
./0_runAll.sh ~/sctau/sctau.sqlite3 ~/sctau/SnomedCT_Release_AU1000036_20210331/RF2Release/Snapshot
```

The whole process takes about 20 minutes on modern hardware.