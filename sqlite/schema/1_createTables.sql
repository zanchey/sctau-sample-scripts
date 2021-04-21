/* --------------------------------------------------------------------------
-- Demonstration SNOMED CT-AU Schema creation script
-- The script creates the schema and associated SNAPSHOT tables
-- to provide platform for installing & querying SNOMED CT-AU
-- content:
------------------------------------------------------------------------*/

PRAGMA foreign_keys = ON;

--
-- Table structure for table `concepts_snapshot`
--

DROP TABLE IF EXISTS `concepts_snapshot`;
CREATE TABLE `concepts_snapshot` (
  `id` INTEGER PRIMARY KEY NOT NULL,
  `effectivetime` NOT NULL default CURRENT_TIMESTAMP,
  `active` INTEGER NOT NULL,
  `moduleid` INTEGER NOT NULL,
  `definitionstatusid` INTEGER NOT NULL
);

-- The MySQL schema uses PRIMARY KEY (id, effectivetime), but MySQL's InnoDB doesn't
-- require foreign keys to be unique (bizzarely). As the id column is used as a foreign
-- key in other tables, it needs to be UNIQUE and NOT NULL, which is effectively a
-- primary key.

-- The MySQL schema updates the effectivetime field on every change to a row,
-- but it's not clear that that's useful - the effective time should come from the
-- imported data, anyway.

--
-- Table structure for table `descriptions_snapshot`
--

DROP TABLE IF EXISTS `descriptions_snapshot`;
CREATE TABLE `descriptions_snapshot` (
  `id` INTEGER PRIMARY KEY NOT NULL,
  `effectivetime` NOT NULL default CURRENT_TIMESTAMP ,
  `active` INTEGER NOT NULL,
  `moduleid` INTEGER NOT NULL,
  `conceptid` INTEGER NOT NULL,
  `languagecode` NOT NULL,
  `typeid` INTEGER NOT NULL,
  `term` NOT NULL,
  `casesignificanceid` INTEGER NOT NULL,
  FOREIGN KEY (conceptid) REFERENCES concepts_snapshot(id) ON DELETE CASCADE,
  FOREIGN KEY (moduleid) REFERENCES concepts_snapshot(id) ON DELETE CASCADE,
  FOREIGN KEY (typeid) REFERENCES concepts_snapshot(id) ON DELETE CASCADE
);

-- The MySQL schema uses PRIMARY KEY (id, effectivetime), but MySQL's InnoDB doesn't
-- require foreign keys to be unique (bizzarely). As the id column is used as a foreign
-- key in other tables, it needs to be UNIQUE and NOT NULL, which is effectively a
-- primary key.

-- The MySQL schema updates the effectivetime field on every change to a row,
-- but it's not clear that that's useful - the effective time should come from the
-- imported data, anyway.

--
-- Table structure for table `relationships_snapshot`
--

DROP TABLE IF EXISTS `relationships_snapshot`;
CREATE TABLE `relationships_snapshot` (
  `id` INTEGER PRIMARY KEY NOT NULL,
  `effectivetime` NOT NULL default CURRENT_TIMESTAMP,
  `active` INTEGER NOT NULL,
  `moduleid` INTEGER NOT NULL,
  `sourceid` INTEGER NOT NULL,
  `destinationid` INTEGER NOT NULL,
  `relationshipgroup` INTEGER NOT NULL,
  `typeid` INTEGER NOT NULL,
  `characteristictypeid` INTEGER NOT NULL,
  `modifierid` INTEGER NOT NULL,
  FOREIGN KEY (moduleid) REFERENCES concepts_snapshot(id) ON DELETE CASCADE,
  FOREIGN KEY (typeid) REFERENCES concepts_snapshot(id) ON DELETE CASCADE,
  FOREIGN KEY (characteristictypeid) REFERENCES concepts_snapshot(id) ON DELETE CASCADE,
  FOREIGN KEY (sourceid) REFERENCES concepts_snapshot(id) ON DELETE CASCADE,
  FOREIGN KEY (destinationid) REFERENCES concepts_snapshot(id) ON DELETE CASCADE
);

-- The MySQL schema uses PRIMARY KEY (id, effectivetime), but MySQL's InnoDB doesn't
-- require foreign keys to be unique (bizzarely). As the id column is used as a foreign
-- key in other tables, it needs to be UNIQUE and NOT NULL, which is effectively a
-- primary key.

-- The MySQL schema updates the effectivetime field on every change to a row,
-- but it's not clear that that's useful - the effective time should come from the
-- imported data, anyway.

--
-- Table structure for table `language_refset_snapshot`
--

DROP TABLE IF EXISTS `language_refset_snapshot`;
CREATE TABLE `language_refset_snapshot` (
  `id` PRIMARY KEY NOT NULL,
  `effectivetime` NOT NULL default CURRENT_TIMESTAMP,
  `active` INTEGER NOT NULL,
  `moduleid` INTEGER NOT NULL,
  `refsetid` INTEGER NOT NULL,
  `referencedcomponentid` INTEGER NOT NULL,
  `acceptabilityid` INTEGER NOT NULL,
  FOREIGN KEY (moduleid) REFERENCES concepts_snapshot(id) ON DELETE CASCADE,
  FOREIGN KEY (refsetid) REFERENCES concepts_snapshot(id) ON DELETE CASCADE,
  FOREIGN KEY (referencedcomponentid) REFERENCES descriptions_snapshot(id) ON DELETE CASCADE
);

-- The MySQL schema uses PRIMARY KEY (id, effectivetime), but MySQL's InnoDB doesn't
-- require foreign keys to be unique (bizzarely). As the id column is used as a foreign
-- key in other tables, it needs to be UNIQUE and NOT NULL, which is effectively a
-- primary key.

-- The MySQL schema updates the effectivetime field on every change to a row,
-- but it's not clear that that's useful - the effective time should come from the
-- imported data, anyway.

--
-- Table structure for table `refset_snapshot`
-- Stores all simple type reference sets
--

DROP TABLE IF EXISTS `refset_snapshot`;
CREATE TABLE `refset_snapshot` (
  `id` PRIMARY KEY NOT NULL,
  `effectivetime` timestamp NOT NULL default CURRENT_TIMESTAMP,
  `active` INTEGER NOT NULL,
  `moduleid` INTEGER NOT NULL,
  `refsetid` INTEGER NOT NULL,
  `referencedcomponentid` INTEGER NOT NULL,
  FOREIGN KEY (moduleid) REFERENCES concepts_snapshot(id) ON DELETE CASCADE,
  FOREIGN KEY (refsetid) REFERENCES concepts_snapshot(id) ON DELETE CASCADE,
  FOREIGN KEY (referencedcomponentid) REFERENCES concepts_snapshot(id) ON DELETE CASCADE
);

-- The MySQL schema uses PRIMARY KEY (id, effectivetime), but MySQL's InnoDB doesn't
-- require foreign keys to be unique (bizzarely). As the id column is used as a foreign
-- key in other tables, it needs to be UNIQUE and NOT NULL, which is effectively a
-- primary key.

-- The MySQL schema updates the effectivetime field on every change to a row,
-- but it's not clear that that's useful - the effective time should come from the
-- imported data, anyway.

--
-- Table structure for table `crefset_snapshot`
-- Required for history tracking of components
--

DROP TABLE IF EXISTS `crefset_snapshot`;
CREATE TABLE `crefset_snapshot` (
  `id` PRIMARY KEY NOT NULL,
  `effectivetime` timestamp NOT NULL default CURRENT_TIMESTAMP,
  `active` INTEGER NOT NULL,
  `moduleid` INTEGER NOT NULL,
  `refsetid` INTEGER NOT NULL,
  `referencedcomponentid` INTEGER NOT NULL,
  `targetComponentid` INTEGER NOT NULL,
  FOREIGN KEY (moduleid) REFERENCES concepts_snapshot(id) ON DELETE CASCADE,
  FOREIGN KEY (refsetid) REFERENCES concepts_snapshot(id) ON DELETE CASCADE --,
  -- The following foreign keys are commented out because they may reference concepts
  -- that do not exist in the snapshot (presumably because they are inactive).
  --  FOREIGN KEY (referencedcomponentid) REFERENCES concepts_snapshot(id) ON DELETE CASCADE,
  --  FOREIGN KEY (targetComponentid) REFERENCES concepts_snapshot(id) ON DELETE CASCADE
);

-- The MySQL schema uses PRIMARY KEY (id, effectivetime), but MySQL's InnoDB doesn't
-- require foreign keys to be unique (bizzarely). As the id column is used as a foreign
-- key in other tables, it needs to be UNIQUE and NOT NULL, which is effectively a
-- primary key.

--
-- Table structure for table `ccrefset_snapshot`
-- Required for use of Dose route and form extended association reference set
--

DROP TABLE IF EXISTS `ccrefset_snapshot`;
CREATE TABLE `ccrefset_snapshot` (
  `id` PRIMARY KEY NOT NULL,
  `effectivetime` timestamp NOT NULL default CURRENT_TIMESTAMP,
  `active` INTEGER NOT NULL,
  `moduleid` INTEGER NOT NULL,
  `refsetid` INTEGER NOT NULL,
  `referencedcomponentid` INTEGER NOT NULL,
  `value1` INTEGER NOT NULL,
  `value2` INTEGER NOT NULL,
  FOREIGN KEY (moduleid) REFERENCES concepts_snapshot(id) ON DELETE CASCADE,
  FOREIGN KEY (refsetid) REFERENCES concepts_snapshot(id) ON DELETE CASCADE,
  FOREIGN KEY (referencedcomponentid) REFERENCES concepts_snapshot(id) ON DELETE CASCADE,
  FOREIGN KEY (value1) REFERENCES concepts_snapshot(id) ON DELETE CASCADE,
  FOREIGN KEY (value2) REFERENCES concepts_snapshot(id) ON DELETE CASCADE
);

-- The MySQL schema uses PRIMARY KEY (id, effectivetime), but MySQL's InnoDB doesn't
-- require foreign keys to be unique (bizzarely). As the id column is used as a foreign
-- key in other tables, it needs to be UNIQUE and NOT NULL, which is effectively a
-- primary key.

--
-- Table structure for table `ccsrefset_snapshot`
-- Stores the following three concrete domain reference sets:
--    * 700000111000036105	Strength reference set
--    * 700000131000036101	Unit of use quantity reference set
--    * 700000141000036106	Unit of use size reference set
--

DROP TABLE IF EXISTS ccsrefset_snapshot;
CREATE TABLE ccsrefset_snapshot (
  id PRIMARY KEY NOT NULL,
  effectivetime timestamp NOT NULL default CURRENT_TIMESTAMP,
  active INTEGER NOT NULL,
  moduleid INTEGER NOT NULL,
  refsetid INTEGER NOT NULL,
  referencedcomponentid INTEGER NOT NULL,
  unitid INTEGER NOT NULL,
  operatorid INTEGER NOT NULL,
  value INTEGER NOT NULL
);

--
-- Table structure for table `ccirefset_snapshot`
-- Stores the 700000121000036103 Subpack quantity reference set
--

DROP TABLE IF EXISTS ccirefset_snapshot;
CREATE TABLE ccirefset_snapshot (
  id PRIMARY KEY NOT NULL,
  effectivetime timestamp NOT NULL default CURRENT_TIMESTAMP,
  active INTEGER NOT NULL,
  moduleid INTEGER NOT NULL,
  refsetid INTEGER NOT NULL,
  referencedcomponentid INTEGER NOT NULL,
  unitid INTEGER NOT NULL,
  operatorid INTEGER NOT NULL,
  value INTEGER NOT NULL
);

--
-- Table structure for table `full_ARTGId_irefset`
-- Stores the 11000168105 ARTG Id reference set
--

DROP TABLE IF EXISTS `irefset_snapshot`;
CREATE TABLE `irefset_snapshot` (
  `id` PRIMARY KEY NOT NULL,
  `effectivetime` timestamp NOT NULL default CURRENT_TIMESTAMP,
  `active` INTEGER NOT NULL,
  `moduleid` INTEGER NOT NULL,
  `refsetid` INTEGER NOT NULL,
  `referencedcomponentid` INTEGER NOT NULL,
  `schemeValue` NOT NULL,
  FOREIGN KEY (moduleid) REFERENCES concepts_snapshot(id) ON DELETE CASCADE,
  FOREIGN KEY (refsetid) REFERENCES concepts_snapshot(id) ON DELETE CASCADE,
  FOREIGN KEY (referencedcomponentid) REFERENCES concepts_snapshot(id) ON DELETE CASCADE
);

-- The MySQL schema uses PRIMARY KEY (id, effectivetime), but MySQL's InnoDB doesn't
-- require foreign keys to be unique (bizzarely). As the id column is used as a foreign
-- key in other tables, it needs to be UNIQUE and NOT NULL, which is effectively a
-- primary key.
