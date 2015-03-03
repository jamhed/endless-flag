DROP TABLE coord;
CREATE TABLE coord (
   node_id INTEGER REFERENCES node(id),
   attitude REAL,
   longitude REAL
);
