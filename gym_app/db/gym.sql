DROP TABLE IF EXISTS members;
DROP TABLE IF EXISTS sessions;

CREATE TABLE sessions(
  id SERIAL8 PRIMARY KEY,
  type VARCHAR(255),
  instructor VARCHAR(255),
  time VARCHAR(255)
);

CREATE TABLE members(
  id SERIAL8 PRIMARY KEY,
  first_name VARCHAR(255),
  last_name VARCHAR(255),
  age INT4,
  session INT8 REFERENCES sessions(id) ON DELETE CASCADE
);
