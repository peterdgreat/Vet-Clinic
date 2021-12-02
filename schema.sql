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

-- Create a table named owners with the following columns:
-- id: integer (set it as autoincremented PRIMARY KEY)
-- full_name: string
-- age: integer
CREATE TABLE owners(
  id  INT generated always AS identity PRIMARY KEY,
  full_name VARCHAR(50) NOT NULL,
  age INT NOT NULL
);

-- Create a table named species with the following columns:
-- id: integer (set it as autoincremented PRIMARY KEY)
-- name: string

CREATE TABLE specie (
  id  INT generated always AS identity PRIMARY KEY,
  name VARCHAR(50) NOT NULL
);

-- Modify animals table:
-- Make sure that id is set as autoincremented PRIMARY KEY
-- Remove column species
-- Add column species_id which is a foreign key referencing species table
-- Add column owner_id which is a foreign key referencing the owners table

ALTER TABLE animals
DROP COLUMN species,
ADD COLUMN species_id INT REFERENCES specie,
ADD COLUMN owner_id INT REFERENCES owners;