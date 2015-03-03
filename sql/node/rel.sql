DROP TABLE rel;
CREATE TABLE rel (
   node_id     INTEGER REFERENCES node(id),
   parent_id   INTEGER REFERENCES node(id),
   stamp       TIMESTAMP
);
