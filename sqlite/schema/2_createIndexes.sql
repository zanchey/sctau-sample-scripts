
-- Create indexes to support queries executed on sample SCT-AU -- SNAPSHOT tables

PRAGMA foreign_keys = ON;

CREATE INDEX concepts_id_active_snap_idx ON concepts_snapshot(id, active);

CREATE INDEX descriptions_id_active_snap_idx ON descriptions_snapshot(id, active);
CREATE INDEX descriptions_concept_id_snap_idx ON descriptions_snapshot(conceptid, active);

CREATE INDEX relationships_active_snap_idx ON relationships_snapshot(active);
CREATE INDEX relationships_typeid_snap_idx ON relationships_snapshot(typeid);
CREATE INDEX relationships_sourceid_snap_idx ON relationships_snapshot(sourceid);
CREATE INDEX relationships_destinationid_snap_idx ON relationships_snapshot(destinationid);

CREATE INDEX lang_refset_referenced_description_id_snap_idx ON language_refset_snapshot(referencedcomponentid);

CREATE INDEX refset_referenced_concept_id_snap_idx ON refset_snapshot(referencedcomponentid);
CREATE INDEX refset_refset_id_snap_idx ON refset_snapshot(refsetid);

CREATE INDEX crefset_refset_id_snap_idx ON crefset_snapshot(refsetid);
CREATE INDEX crefset_referenced_component_id_snap_idx ON crefset_snapshot(referencedcomponentid);
CREATE INDEX crefset_target_component_id_snap_idx ON crefset_snapshot(targetComponentid);

CREATE INDEX ccrefset_referenced_concept_id_snap_idx ON ccrefset_snapshot(referencedcomponentid);
CREATE INDEX ccrefset_value1_snap_idx ON ccrefset_snapshot(value1);
CREATE INDEX ccrefset_value2_snap_idx ON ccrefset_snapshot(value2);

CREATE INDEX ccsrefset_referenced_relationship_id_snap_idx ON ccsrefset_snapshot(referencedcomponentid);

CREATE INDEX ccirefset_referenced_relationship_id_snap_idx ON ccirefset_snapshot(referencedcomponentid);

CREATE INDEX irefset_referenced_component_id_snsp_idx ON irefset_snapshot(referencedcomponentid);
CREATE INDEX irefset_scheme_value_snap_idx ON irefset_snapshot(schemeValue);

REINDEX;
