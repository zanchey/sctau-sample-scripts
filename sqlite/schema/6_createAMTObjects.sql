
-- DERIVED Objects


PRAGMA foreign_keys = ON;

-- CREATE Table for v3_ingredient_strength
-- This table lists all the MPPs, their MPUUs and the corresponding ingredients (IAI and BoSS) and strengths
DROP TABLE IF EXISTS v3_ingredient_strength;

CREATE TABLE v3_ingredient_strength AS
select
    MPPhasMPUU.sourceId as mppid,
    (select term
        FROM descriptions_snapshot AS D
        INNER JOIN language_refset_snapshot AS ADRS
        ON D.id = ADRS.referencedcomponentid
        WHERE D.conceptId = MPPhasMPUU.sourceId
        AND ADRS.acceptabilityid = 900000000000548007
        AND ADRS.active = 1
    ) as mppterm,
    MPPhasMPUU.destinationid as mpuuid,
    (select term
        FROM descriptions_snapshot AS D
        INNER JOIN language_refset_snapshot AS ADRS
        ON D.id = ADRS.referencedcomponentid
        WHERE D.conceptId = MPPhasMPUU.destinationid
        AND ADRS.acceptabilityid = 900000000000548007
        AND ADRS.active = 1
    ) as mpuuterm,
    hasIngredient.destinationid as substanceid,
    (select term
        FROM descriptions_snapshot AS D
        INNER JOIN language_refset_snapshot AS ADRS
        ON D.id = ADRS.referencedcomponentid
        WHERE D.conceptId = hasIngredient.destinationid
        AND ADRS.acceptabilityid = 900000000000548007
        AND ADRS.active = 1
    ) as substanceterm,
    hasBoSS.destinationid as bossid,
    (select term
        FROM descriptions_snapshot AS D
        INNER JOIN language_refset_snapshot AS ADRS
        ON D.id = ADRS.referencedcomponentid
        WHERE D.conceptId = hasBoSS.destinationid
        AND ADRS.acceptabilityid = 900000000000548007
        AND ADRS.active = 1
    ) as bossterm,
    strength.operatorid as operatorid,
    (select term
        FROM descriptions_snapshot AS D
        INNER JOIN language_refset_snapshot AS ADRS
        ON D.id = ADRS.referencedcomponentid
        WHERE D.conceptId = strength.operatorid
        AND ADRS.acceptabilityid = 900000000000548007
        AND ADRS.active = 1
    ) as operatorterm,
    strength.value as strengthvalue,
    strength.unitid as unitid,
    (select term
        FROM descriptions_snapshot AS D
        INNER JOIN language_refset_snapshot AS ADRS
        ON D.id = ADRS.referencedcomponentid
        WHERE D.conceptId = strength.unitid
        AND ADRS.acceptabilityid = 900000000000548007
        AND ADRS.active = 1
    ) as unitterm
from relationships_snapshot MPPhasMPUU
    join relationships_snapshot hasIngredient
        on MPPhasMPUU.destinationId = hasIngredient.sourceId
        and MPPhasMPUU.sourceId in (select referencedComponentId from refset_snapshot where refsetId = 929360081000036101) -- MPP refset
        and MPPhasMPUU.destinationId in (select referencedComponentId from refset_snapshot where refsetId = 929360071000036103) -- MPUU refset
        and MPPhasMPUU.typeId = 30348011000036104 -- has MPUU (relationship type)
        and MPPhasMPUU.active = 1
        and hasIngredient.typeId = 700000081000036101 -- has intended active ingredient (attribute)
        and hasIngredient.active = 1

    join relationships_snapshot hasBoSS
        on hasIngredient.sourceId = hasBoSS.sourceId and hasIngredient.relationshipgroup = hasBoSS.relationshipgroup
        and hasBoSS.typeId = 30364011000036101 -- has Australian BoSS (relationship type)
        and hasBoSS.active = 1

    left outer join ccsrefset_snapshot strength
        on hasBoSS.id = strength.referencedcomponentid
        and strength.refsetid=700000111000036105 and strength.active = 1
;

-- CREATE Table for v3_ingredient_strength
-- This table lists all the MPPs, their MPUUs and the corresponding ingredients (IAI and BoSS) and strengths
DROP TABLE IF EXISTS v3_ingredient_strength;
CREATE TABLE v3_ingredient_strength AS
select
    MPPhasMPUU.sourceId as mppid,
    (SELECT term
        FROM descriptions_snapshot AS D
        INNER JOIN language_refset_snapshot AS ADRS
        ON D.id = ADRS.referencedcomponentid
        WHERE D.conceptId = MPPhasMPUU.sourceId
        AND ADRS.acceptabilityid = 900000000000548007
        AND ADRS.active = 1) as mppterm,
    MPPhasMPUU.destinationid as mpuuid,
    (SELECT term
        FROM descriptions_snapshot AS D
        INNER JOIN language_refset_snapshot AS ADRS
        ON D.id = ADRS.referencedcomponentid
        WHERE D.conceptId = MPPhasMPUU.destinationid
        AND ADRS.acceptabilityid = 900000000000548007
        AND ADRS.active = 1) as mpuuterm,
    hasIngredient.destinationid as substanceid,
    (SELECT term
        FROM descriptions_snapshot AS D
        INNER JOIN language_refset_snapshot AS ADRS
        ON D.id = ADRS.referencedcomponentid
        WHERE D.conceptId = hasIngredient.destinationid
        AND ADRS.acceptabilityid = 900000000000548007
        AND ADRS.active = 1) as substanceterm,
    hasBoSS.destinationid as bossid,
    (SELECT term
        FROM descriptions_snapshot AS D
        INNER JOIN language_refset_snapshot AS ADRS
        ON D.id = ADRS.referencedcomponentid
        WHERE D.conceptId = hasBoSS.destinationid
        AND ADRS.acceptabilityid = 900000000000548007
        AND ADRS.active = 1) as bossterm,
    strength.operatorid as operatorid,
    (SELECT term
        FROM descriptions_snapshot AS D
        INNER JOIN language_refset_snapshot AS ADRS
        ON D.id = ADRS.referencedcomponentid
        WHERE D.conceptId = strength.operatorid
        AND ADRS.acceptabilityid = 900000000000548007
        AND ADRS.active = 1) as operatorterm,
    strength.value as strengthvalue,
    strength.unitid as unitid,
    (SELECT term
        FROM descriptions_snapshot AS D
        INNER JOIN language_refset_snapshot AS ADRS
        ON D.id = ADRS.referencedcomponentid
        WHERE D.conceptId = strength.unitid
        AND ADRS.acceptabilityid = 900000000000548007
        AND ADRS.active = 1) as unitterm
from relationships_snapshot MPPhasMPUU

    join relationships_snapshot hasIngredient
        on MPPhasMPUU.destinationId = hasIngredient.sourceId
        and MPPhasMPUU.sourceId in (select referencedComponentId from refset_snapshot where refsetId = 929360081000036101) -- MPP refset
        and MPPhasMPUU.destinationId in (select referencedComponentId from refset_snapshot where refsetId = 929360071000036103) -- MPUU refset
        and MPPhasMPUU.typeId = 30348011000036104 -- has MPUU (relationship type)
        and MPPhasMPUU.active = 1
        and hasIngredient.typeId = 700000081000036101 -- has intended active ingredient (attribute)
        and hasIngredient.active = 1

    join relationships_snapshot hasBoSS
        on hasIngredient.sourceId = hasBoSS.sourceId and hasIngredient.relationshipgroup = hasBoSS.relationshipgroup
        and hasBoSS.typeId = 30364011000036101 -- has Australian BoSS (relationship type)
        and hasBoSS.active = 1

    left outer join ccsrefset_snapshot strength
        on hasBoSS.id = strength.referencedcomponentid
        and strength.refsetid=700000111000036105 and strength.active = 1;

-- Create Indexes for v3_ingredient_strength table
CREATE INDEX v3_ingredient_strength_mppid_idx ON v3_ingredient_strength(mppid);
CREATE INDEX v3_ingredient_strength_mppterm_idx ON v3_ingredient_strength(mppterm);
CREATE INDEX v3_ingredient_strength_mpuuid_idx ON v3_ingredient_strength(mpuuid);
CREATE INDEX v3_ingredient_strength_mpuuterm_idx ON v3_ingredient_strength(mpuuterm);
CREATE INDEX v3_ingredient_strength_substanceid_idx ON v3_ingredient_strength(substanceid);
CREATE INDEX v3_ingredient_strength_substanceterm_idx ON v3_ingredient_strength(substanceterm);
CREATE INDEX v3_ingredient_strength_bossid_idx ON v3_ingredient_strength(bossid);
CREATE INDEX v3_ingredient_strength_bossterm_idx ON v3_ingredient_strength(bossterm);
CREATE INDEX v3_ingredient_strength_operatorid_idx ON v3_ingredient_strength(operatorid);
CREATE INDEX v3_ingredient_strength_operatorterm_idx ON v3_ingredient_strength(operatorterm);
CREATE INDEX v3_ingredient_strength_strengthvalue_idx ON v3_ingredient_strength(strengthvalue);
CREATE INDEX v3_ingredient_strength_unitid_idx ON v3_ingredient_strength(unitid);
CREATE INDEX v3_ingredient_strength_unitterm_idx ON v3_ingredient_strength(unitterm);

-- CREATE Table for v3_unit_of_use
-- This table lists all the MPPs, their MPUUs the size of each MPUU, and the number of MPUU in each pack
DROP TABLE IF EXISTS v3_unit_of_use;
CREATE TABLE v3_unit_of_use AS
select
    MPPhasMPUU.sourceId as mppid,
    (SELECT term
        FROM descriptions_snapshot AS D
        INNER JOIN language_refset_snapshot AS ADRS
        ON D.id = ADRS.referencedcomponentid
        WHERE D.conceptId = MPPhasMPUU.sourceId
        AND ADRS.acceptabilityid = 900000000000548007
        AND ADRS.active = 1) as mppterm,
    MPPhasMPUU.destinationId as mpuuid,
    (SELECT term
        FROM descriptions_snapshot AS D
        INNER JOIN language_refset_snapshot AS ADRS
        ON D.id = ADRS.referencedcomponentid
        WHERE D.conceptId = MPPhasMPUU.destinationId
        AND ADRS.acceptabilityid = 900000000000548007
        AND ADRS.active = 1) as mpuuterm,

    hasUnitOfUse.destinationId as unitofuseid,
    (SELECT term
        FROM descriptions_snapshot AS D
        INNER JOIN language_refset_snapshot AS ADRS
        ON D.id = ADRS.referencedcomponentid
        WHERE D.conceptId = hasUnitOfUse.destinationId
        AND ADRS.acceptabilityid = 900000000000548007
        AND ADRS.active = 1) as unitofuseterm,

    uouSize.operatorid as sizeoperatorid,
    (SELECT term
        FROM descriptions_snapshot AS D
        INNER JOIN language_refset_snapshot AS ADRS
        ON D.id = ADRS.referencedcomponentid
        WHERE D.conceptId = uouSize.operatorid
        AND ADRS.acceptabilityid = 900000000000548007
        AND ADRS.active = 1) as sizeoperatorterm,
    uouSize.value as sizevalue,
    uouSize.unitid as sizeunitid,
    (SELECT term
        FROM descriptions_snapshot AS D
        INNER JOIN language_refset_snapshot AS ADRS
        ON D.id = ADRS.referencedcomponentid
        WHERE D.conceptId = uouSize.unitid
        AND ADRS.acceptabilityid = 900000000000548007
        AND ADRS.active = 1) as sizeunitterm,

    uouQty.operatorid as quantityoperatorid,
    (SELECT term
        FROM descriptions_snapshot AS D
        INNER JOIN language_refset_snapshot AS ADRS
        ON D.id = ADRS.referencedcomponentid
        WHERE D.conceptId = uouQty.operatorid
        AND ADRS.acceptabilityid = 900000000000548007
        AND ADRS.active = 1) as quantityoperatorterm,
    uouQty.value as quantityvalue,
    uouQty.unitid as quantityunitid,
    (SELECT term
        FROM descriptions_snapshot AS D
        INNER JOIN language_refset_snapshot AS ADRS
        ON D.id = ADRS.referencedcomponentid
        WHERE D.conceptId = uouQty.unitid
        AND ADRS.acceptabilityid = 900000000000548007
        AND ADRS.active = 1) as quantityunitterm
from relationships_snapshot MPPhasMPUU

    left outer join relationships_snapshot hasUnitOfUse
        on MPPhasMPUU.destinationId = hasUnitOfUse.sourceId
        and MPPhasMPUU.sourceId in (select referencedComponentId from refset_snapshot where refsetId = 929360081000036101) -- MPP refset
        and MPPhasMPUU.destinationId in (select referencedComponentId from refset_snapshot where refsetId = 929360071000036103) -- MPUU refset
        and hasUnitOfUse.typeId = 30548011000036101 -- has unit of use (relationship type)
        and hasUnitOfUse.active = 1

    join ccsrefset_snapshot uouSize
        on hasUnitOfUse.id = uouSize.referencedcomponentid
        and uouSize.refsetid=700000141000036106 and uouSize.active = 1 -- Unit of use size reference set

    join ccsrefset_snapshot uouQty
        on MPPhasMPUU.id = uouQty.referencedcomponentid
        and uouQty.refsetid=700000131000036101 and uouQty.active = 1; -- Unit of use quantity reference set

-- Create Indexes for v3_unit_of_use table
CREATE INDEX v3_unit_of_use_mppid_idx ON v3_unit_of_use(mppid);
CREATE INDEX v3_unit_of_use_mppterm_idx ON v3_unit_of_use(mppterm);
CREATE INDEX v3_unit_of_use_mpuuid_idx ON v3_unit_of_use(mpuuid);
CREATE INDEX v3_unit_of_use_mpuuterm_idx ON v3_unit_of_use(mpuuterm);
CREATE INDEX v3_unit_of_use_unitofuseid_idx ON v3_unit_of_use(unitofuseid);
CREATE INDEX v3_unit_of_use_unitofuseterm_idx ON v3_unit_of_use(unitofuseterm);
CREATE INDEX v3_unit_of_use_sizeoperatorid_idx ON v3_unit_of_use(sizeoperatorid);
CREATE INDEX v3_unit_of_use_sizeoperatorterm_idx ON v3_unit_of_use(sizeoperatorterm);
CREATE INDEX v3_unit_of_use_sizevalue_idx ON v3_unit_of_use(sizevalue);
CREATE INDEX v3_unit_of_use_sizeunitid_idx ON v3_unit_of_use(sizeunitid);
CREATE INDEX v3_unit_of_use_sizeunitterm_idx ON v3_unit_of_use(sizeunitterm);
CREATE INDEX v3_unit_of_use_quantityoperatorid_idx ON v3_unit_of_use(quantityoperatorid);
CREATE INDEX v3_unit_of_use_quantityoperatorterm_idx ON v3_unit_of_use(quantityoperatorterm);
CREATE INDEX v3_unit_of_use_quantityvalue_idx ON v3_unit_of_use(quantityvalue);
CREATE INDEX v3_unit_of_use_quantityunitid_idx ON v3_unit_of_use(quantityunitid);
CREATE INDEX v3_unit_of_use_quantityunitterm_idx ON v3_unit_of_use(quantityunitterm);


-- CREATE Table for v3_mpp_to_tpp
-- This table lists all the MPPs and corresponding TPPs
DROP TABLE IF EXISTS v3_mpp_to_tpp;
CREATE TABLE v3_mpp_to_tpp AS
select
    destinationId as mppid,
    (SELECT term
        FROM descriptions_snapshot AS D
        INNER JOIN language_refset_snapshot AS ADRS
        ON D.id = ADRS.referencedcomponentid
        WHERE D.conceptId = destinationId
        AND ADRS.acceptabilityid = 900000000000548007
        AND ADRS.active = 1) as mppterm,
    sourceId as tppid,
    (SELECT term
        FROM descriptions_snapshot AS D
        INNER JOIN language_refset_snapshot AS ADRS
        ON D.id = ADRS.referencedcomponentid
        WHERE D.conceptId = sourceId
        AND ADRS.acceptabilityid = 900000000000548007
        AND ADRS.active = 1) as tppterm
from relationships_snapshot TPPisMPP
        where TPPisMPP.sourceId in (select referencedComponentId from refset_snapshot where refsetId = 929360041000036105) -- TPP refset
        and TPPisMPP.destinationId in (select referencedComponentId from refset_snapshot where refsetId = 929360081000036101) -- MPP refset
        and TPPisMPP.typeId = 116680003 -- Is a
        and TPPisMPP.active = 1;

-- Create Indexes for v3_mpp_to_tpp table
CREATE INDEX v3_mpp_to_tpp_mppid_idx ON v3_mpp_to_tpp(mppid);
CREATE INDEX v3_mpp_to_tpp_mppterm_idx ON v3_mpp_to_tpp(mppterm);
CREATE INDEX v3_mpp_to_tpp_tppid_idx ON v3_mpp_to_tpp(tppid);
CREATE INDEX v3_mpp_to_tpp_tppterm_idx ON v3_mpp_to_tpp(tppterm);

-- CREATE Table for v3_mpp_to_tpp
-- This table lists all the MPUUs, the strength of each BoSS, and the size of each MPUU
DROP TABLE IF EXISTS v3_total_ingredient_quantity;
CREATE TABLE v3_total_ingredient_quantity AS
select
    strength.mpuuid as mpuuid,
    strength.mpuuterm as mpuuterm,
    strength.bossid as bossid,
    strength.bossterm as bossterm,
    strength.strengthvalue as strengthvalue,
    strength.unitid as strengthunitid,
    unitterm as strengthunitterm,
    substanceid as activeingredientid,
    substanceterm as activeingredientterm,
    sizevalue as sizevalue,
    sizeunitid as sizeunitid,
    sizeunitterm as sizeunitterm,
    round(strength.strengthvalue * sizevalue, 6) as totalquantity,
    hasNumeratorUnits.destinationid as totalquantityunitid,
    (SELECT term
        FROM descriptions_snapshot AS D
        INNER JOIN language_refset_snapshot AS ADRS
        ON D.id = ADRS.referencedcomponentid
        WHERE D.conceptId = hasNumeratorUnits.destinationid
        AND ADRS.acceptabilityid = 900000000000548007
        AND ADRS.active = 1) as totalquantityunitterm
from v3_ingredient_strength strength
    join v3_unit_of_use uousize
        on strength.mpuuid = uousize.mpuuid

    join relationships_snapshot hasNumeratorUnits
        on strength.unitid = sourceId
        and typeid = 700000091000036104
        and active = 1;

-- Create Indexes for v3_total_ingredient_quantity table
CREATE INDEX v3_total_ingredient_quantity_mpuuid_idx ON v3_total_ingredient_quantity(mpuuid);
CREATE INDEX v3_total_ingredient_quantity_mpuuterm_idx ON v3_total_ingredient_quantity(mpuuterm);
CREATE INDEX v3_total_ingredient_quantity_bossid_idx ON v3_total_ingredient_quantity(bossid);
CREATE INDEX v3_total_ingredient_quantity_bossterm_idx ON v3_total_ingredient_quantity(bossterm);
CREATE INDEX v3_total_ingredient_quantity_strengthvalue_idx ON v3_total_ingredient_quantity(strengthvalue);
CREATE INDEX v3_total_ingredient_quantity_strengthunitid_idx ON v3_total_ingredient_quantity(strengthunitid);
CREATE INDEX v3_total_ingredient_quantity_strengthunitterm_idx ON v3_total_ingredient_quantity(strengthunitterm);
CREATE INDEX v3_total_ingredient_quantity_activeingredientid_idx ON v3_total_ingredient_quantity(activeingredientid);
CREATE INDEX v3_total_ingredient_quantity_activeingredientterm_idx ON v3_total_ingredient_quantity(activeingredientterm);
CREATE INDEX v3_total_ingredient_quantity_sizevalue_idx ON v3_total_ingredient_quantity(sizevalue);
CREATE INDEX v3_total_ingredient_quantity_sizeunitid_idx ON v3_total_ingredient_quantity(sizeunitid);
CREATE INDEX v3_total_ingredient_quantity_sizeunitterm_idx ON v3_total_ingredient_quantity(sizeunitterm);
CREATE INDEX v3_total_ingredient_quantity_totalquantity_idx ON v3_total_ingredient_quantity(totalquantity);
CREATE INDEX v3_total_ingredient_quantity_totalquantityunitid_idx ON v3_total_ingredient_quantity(totalquantityunitid);
CREATE INDEX v3_total_ingredient_quantity_totalquantityunitterm_idx ON v3_total_ingredient_quantity(totalquantityunitterm);

-- CREATE table for v3_AMT_products
-- This table lists the seven AMT products with the IDs, preferred terms and ARTGID
-- This requires a lot of computation - ~6 hours of CPU time on a Core i5 1.6 GHz
DROP TABLE IF EXISTS v3_AMT_products;
CREATE TABLE v3_AMT_products AS

SELECT
ctpp_tpp.sourceid CTPP_ID,
(SELECT term
        FROM descriptions_snapshot AS D
        INNER JOIN language_refset_snapshot AS ADRS
        ON D.id = ADRS.referencedcomponentid
        WHERE D.conceptId = ctpp_tpp.sourceid
        AND ADRS.acceptabilityid = 900000000000548007
        AND ADRS.active = 1) CTPP_PT,
    ifnull(artgid.schemeValue,'') ARTG_ID,
    ctpp_tpp.destinationid TPP_ID,
    (SELECT term
        FROM descriptions_snapshot AS D
        INNER JOIN language_refset_snapshot AS ADRS
        ON D.id = ADRS.referencedcomponentid
        WHERE D.conceptId = ctpp_tpp.destinationid
        AND ADRS.acceptabilityid = 900000000000548007
        AND ADRS.active = 1) TPP_PT,
    has_tpuu.destinationid TPUU_ID,
    (SELECT term
        FROM descriptions_snapshot AS D
        INNER JOIN language_refset_snapshot AS ADRS
        ON D.id = ADRS.referencedcomponentid
        WHERE D.conceptId = has_tpuu.destinationid
        AND ADRS.acceptabilityid = 900000000000548007
        AND ADRS.active = 1) TPUU_PT,
    has_tp.destinationid TPP_TP_ID,
    (SELECT term
        FROM descriptions_snapshot AS D
        INNER JOIN language_refset_snapshot AS ADRS
        ON D.id = ADRS.referencedcomponentid
        WHERE D.conceptId = has_tp.destinationid
        AND ADRS.acceptabilityid = 900000000000548007
        AND ADRS.active = 1) TPP_TP_PT,
    tpuu_tp.destinationid TPUU_TP_ID,
    (SELECT term
        FROM descriptions_snapshot AS D
        INNER JOIN language_refset_snapshot AS ADRS
        ON D.id = ADRS.referencedcomponentid
        WHERE D.conceptId = tpuu_tp.destinationid
        AND ADRS.acceptabilityid = 900000000000548007
        AND ADRS.active = 1) TPUU_TP_PT,
    tpp_mpp.destinationid MPP_ID,
    (SELECT term
        FROM descriptions_snapshot AS D
        INNER JOIN language_refset_snapshot AS ADRS
        ON D.id = ADRS.referencedcomponentid
        WHERE D.conceptId = tpp_mpp.destinationid
        AND ADRS.acceptabilityid = 900000000000548007
        AND ADRS.active = 1) MPP_PT,
    tpuu_mpuu.destinationid MPUU_ID,
    (SELECT term
        FROM descriptions_snapshot AS D
        INNER JOIN language_refset_snapshot AS ADRS
        ON D.id = ADRS.referencedcomponentid
        WHERE D.conceptId = tpuu_mpuu.destinationid
        AND ADRS.acceptabilityid = 900000000000548007
        AND ADRS.active = 1) MPUU_PT,
    mpuu_mp.destinationid MP_ID,
    (SELECT term
        FROM descriptions_snapshot AS D
        INNER JOIN language_refset_snapshot AS ADRS
        ON D.id = ADRS.referencedcomponentid
        WHERE D.conceptId = mpuu_mp.destinationid
        AND ADRS.acceptabilityid = 900000000000548007
        AND ADRS.active = 1) MP_PT

FROM transitive_closure ctpp_tpp

JOIN transitive_closure ctpp_type
ON ctpp_tpp.sourceid = ctpp_type.sourceid
AND ctpp_type.destinationid = 30537011000036101 -- CTPP concept

JOIN transitive_closure tpp_mpp
ON tpp_mpp.sourceid = ctpp_tpp.destinationid

JOIN relationships_snapshot has_tpuu
ON ctpp_tpp.sourceid = has_tpuu.sourceid
AND has_tpuu.typeid = 30409011000036107 -- has TPUU
AND has_tpuu.active = 1

JOIN relationships_snapshot has_tp
ON ctpp_tpp.sourceid = has_tp.sourceid
AND has_tp.typeid = 700000101000036108 -- has TP
AND has_tp.active = 1

JOIN transitive_closure tpuu_mpuu
ON tpuu_mpuu.sourceid = has_tpuu.destinationid

JOIN transitive_closure tpuu_tp
ON tpuu_tp.sourceid = has_tpuu.destinationid

JOIN transitive_closure mpuu_mp
ON mpuu_mp.sourceid = tpuu_mpuu.destinationid

LEFT OUTER JOIN irefset_snapshot artgid
ON artgid.refsetid = 11000168105 -- ARTG Id reference set
AND artgid.referencedComponentId = ctpp_tpp.sourceid
AND artgid.active = 1

WHERE EXISTS (SELECT 'a' FROM refset_snapshot WHERE refsetid = 929360041000036105 AND ctpp_tpp.destinationid = referencedComponentId) -- TPP refset
AND NOT EXISTS (SELECT 'a' FROM transitive_closure a
                JOIN refset_snapshot ON refsetid = 929360041000036105 AND a.sourceid = referencedComponentId
                JOIN transitive_closure b on a.sourceid = b.destinationid
                WHERE ctpp_tpp.destinationid = a.destinationid AND ctpp_tpp.sourceid = b.sourceid)

AND EXISTS (SELECT 'a' FROM refset_snapshot WHERE refsetid = 929360081000036101 AND tpp_mpp.destinationid = referencedComponentId) -- MPP refset
AND NOT EXISTS (SELECT 'a' FROM transitive_closure a
                JOIN refset_snapshot ON refsetid = 929360081000036101 AND a.sourceid = referencedComponentId
                JOIN transitive_closure b ON a.sourceid = b.destinationid
                WHERE tpp_mpp.destinationid = a.destinationid and tpp_mpp.sourceid = b.sourceid)

AND EXISTS (SELECT 'a' FROM refset_snapshot WHERE refsetid = 929360071000036103 AND tpuu_mpuu.destinationid = referencedComponentId) -- MPUU refset
AND NOT EXISTS (SELECT 'a' FROM transitive_closure a
                JOIN refset_snapshot ON refsetid = 929360071000036103 AND a.sourceid = referencedComponentId
                JOIN transitive_closure b on a.sourceid = b.destinationid
                WHERE tpuu_mpuu.destinationid = a.destinationid AND tpuu_mpuu.sourceid = b.sourceid)

AND EXISTS (SELECT 'a' FROM refset_snapshot WHERE refsetid = 929360021000036102 AND tpuu_tp.destinationid = referencedComponentId) -- TP refset
AND NOT EXISTS (SELECT 'a' FROM transitive_closure a
                JOIN refset_snapshot ON refsetid = 929360021000036102 and a.sourceid = referencedComponentId
                JOIN transitive_closure b on a.sourceid = b.destinationid
                WHERE tpuu_tp.destinationid = a.destinationid AND tpuu_tp.sourceid = b.sourceid)

AND EXISTS (SELECT 'a' FROM refset_snapshot WHERE refsetid = 929360061000036106 and mpuu_mp.destinationid = referencedComponentId) -- MP refset
AND NOT EXISTS (SELECT 'a' FROM transitive_closure a
                JOIN refset_snapshot ON refsetid = 929360061000036106 and a.sourceid = referencedComponentId
                JOIN transitive_closure b ON a.sourceid = b.destinationid
                WHERE mpuu_mp.destinationid = a.destinationid AND mpuu_mp.sourceid = b.sourceid);
