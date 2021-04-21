-- Create the Transitive Closure table schema

PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS Transitive_Closure;
CREATE TABLE Transitive_Closure (
    sourceid INTEGER NOT NULL,
    destinationid INTEGER NOT NULL,
    PRIMARY KEY (sourceid, destinationid)
);

CREATE INDEX idx_TransitiveClosure_sourceid ON Transitive_Closure (sourceid);
CREATE INDEX idx_TransitiveClosure_destinationid ON Transitive_Closure (destinationid);

-- Insert the immediate set of IS A relationships from the distributed relationships table
INSERT INTO Transitive_Closure (sourceid,destinationid)
    SELECT DISTINCT sourceid,destinationid
    FROM relationships_snapshot
    WHERE typeid = 116680003 -- "IS A" relationship type
    AND active = 1;
