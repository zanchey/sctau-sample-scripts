-- Run this until it returns 0

-- This pragma is deprecated but is the easiest way to get the list of
-- changed lines without writing a more involved script

PRAGMA foreign_keys = ON;
PRAGMA count_changes = 1;

INSERT INTO Transitive_Closure (sourceid,destinationid)
    SELECT DISTINCT b.sourceid,a.destinationid
    FROM Transitive_Closure a
    JOIN Transitive_Closure b
        ON a.sourceid = b.destinationid
    LEFT JOIN Transitive_Closure c
        ON c.sourceid = b.sourceid
    AND c.destinationid = a.destinationid
    WHERE c.sourceid IS NULL;
