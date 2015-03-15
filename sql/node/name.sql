DROP TABLE name;
CREATE TABLE name (
   id          SERIAL PRIMARY KEY,
   node_id     INTEGER REFERENCES node(id),
   name        TEXT NOT NULL,
   stamp       TIMESTAMP NOT NULL DEFAULT now()
);
