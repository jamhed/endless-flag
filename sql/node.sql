DROP TABLE node CASCADE;
CREATE TABLE node (
   id          SERIAL PRIMARY KEY,
   parent_id   INTEGER REFERENCES node(id)
);
