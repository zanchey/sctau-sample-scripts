# Prerequisites
These scripts are based around MySQL, so access to a MySQL or MariaDB server is required. The scripts also assume a schema/database exists in the server called "sctau", this must be created and available to the user executing the scripts contained in this repository.

The scripts also require an unpacked release of SNOMED CT-AU available. SNOMED CT-AU may be downloaded from <https://www.healthterminologies.gov.au/access> or using the [National Syndication Server](https://www.healthterminologies.gov.au/tools?content=nts) for automated downloading.

# How to use these scripts
The scripts can be executed using any client to the MySQL/MariaDB server being used. The instructions below assume using the MySQL command line client.

1. The creation scripts contained in the NCTIS_Australian_Terminology_Sample_Scripts.zip file need to be executed in the following order:

```
mysql> source /schema/1_createSchema.sql

mysql> source /schema/2_populateTables.sql

mysql> source /schema/3_createIndexes.sql

mysql> source /schema/4_createRoutines.sql

mysql> source /schema/5_createTransitiveClosure.sql

mysql> source /schema/6_createAMTObjects.sql
```

2. The 2_populateTables.sql script contains relative paths to the RF2 files. 
Depending on the operating system and version of mysql, you may need to amend these and replace with the full path. 
For example:
	```
	release-files/RF2Release/Snapshot/Terminology/sct2_Concept_Snapshot_AU1000036_20170831.txt
	```
	changes to 
	```
	C:/Users/SomeUser/Downloads/release-files/RF2Release/Snapshot/Terminology/sct2_Concept_Snapshot_AU1000036_20170831.txt
	```

3. The 5_createTransitiveClosure.sql file creates a procedure, which upon execution creates the transitive_closure table 
	The creation of the transitive closure will take some time, up to 20 minutes, depending on the local system specifications.
