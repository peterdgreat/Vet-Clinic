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

-- Create a table named vets with the following columns:
-- id: integer (set it as autoincremented PRIMARY KEY)
-- name: string
-- age: integer
-- date_of_graduation: date

CREATE TABLE vets (
  id INT generated always AS identity PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  age INT NOT NULL,
  date_of_graduation DATE
);

-- Create a "join table" called specializations to handle the many-to-many relationship between vets and species.

CREATE TABLE specializations (
  vets_id INT REFERENCES vets,
  species_id INT REFERENCES specie,
  PRIMARY KEY (vets_id, species_id),
  CONSTRAINT vets_id_fk FOREIGN KEY (vets_id) REFERENCES vets(id),
  CONSTRAINT species_id_fk FOREIGN KEY (species_id) REFERENCES specie(id)
);

-- There is a many-to-many relationship between the tables animals and vets: an animal can visit multiple vets and one vet can be visited by multiple animals. Create a "join table" called visits to handle this relationship, it should also keep track of the date of the visit.

CREATE TABLE visits (
  id INT generated always AS identity PRIMARY KEY,
  vets_id INT,
  animals_id INT,
  date_of_visit DATE,
  CONSTRAINT vets_id_fk FOREIGN KEY (vets_id) REFERENCES vets(id),
  CONSTRAINT animals_id_fk FOREIGN KEY (animals_id) REFERENCES animals(id)
);