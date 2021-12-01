/* Database schema to keep the structure of entire database. */

CREATE TABLE animals(
  id  INT generated always AS identity PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  date_of_birth DATE NOT NULL,
  escape_attempts INT,
  neutered BOOLEAN NOT NULL,
  weight_kg DECIMAL NOT NULL
 );

ALTER TABLE animals
ADD SPECIES VARCHAR(50) ;