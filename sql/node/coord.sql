DROP TABLE coord;
CREATE TABLE coord (
   node_id     INTEGER REFERENCES node(id),
   stamp       TIMESTAMP,
   attitude    REAL,
   longitude   REAL
);
