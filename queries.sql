/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';


SELECT name FROM animals WHERE date_of_birth BETWEEN DATE('2016-01-01') AND DATE('2019-12-31');


SELECT name FROM animals WHERE neutered = TRUE AND escape_attempts < 3;


SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');


SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;


SELECT * FROM animals WHERE neutered = TRUE;


SELECT * FROM animals WHERE name != 'Gabumon';


SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

-- Write queries to answer the following questions:
-- How many animals are there?
SELECT COUNT(*) FROM animals;

-- How many animals have never tried to escape?
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;

-- What is the average weight of animals?
SELECT AVG(weight_kg) FROM animals;

-- Who escapes the most, neutered or not neutered animals?
SELECT name FROM animals WHERE escape_attempts = (SELECT MAX(escape_attempts) FROM animals);

-- What is the minimum and maximum weight of each type of animal?
SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;

-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth BETWEEN DATE('1990-01-01') AND DATE('2000-12-31') GROUP BY species;


-- Write queries (using JOIN) to answer the following questions:
-- What animals belong to Melody Pond?
-- List of all animals that are pokemon (their type is Pokemon).
-- List all owners and their animals, remember to include those that don't own any animal.
-- How many animals are there per species?
-- List all Digimon owned by Jennifer Orwell.
-- List all animals owned by Dean Winchester that haven't tried to escape.
-- Who owns the most animals?


SELECT animals.name FROM animals JOIN owners ON owners.id = animals.owner_id WHERE owners.full_name = 'Melody Pond';

SELECT animals.name FROM animals JOIN specie ON animals.species_id = specie.id WHERE specie.name = 'Pokemon';

SELECT owners.full_name, animals.name FROM owners JOIN animals ON owners.id = animals.owner_id;

SELECT
COUNT(animals.name),
specie.name
FROM animals
JOIN specie ON animals.species_id = specie.id
GROUP BY specie.name;

SELECT animals.name, specie.name, owners.full_name FROM animals JOIN owners ON owners.id = animals.owner_id  JOIN specie ON specie.id = animals.species_id WHERE specie.name = 'Digimon' AND owners.full_name = 'Jennifer Orwell';

SELECT animals.name FROM animals JOIN owners ON owners.id = animals.owner_id WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0;

SELECT owners.full_name, COUNT(animals.name) FROM owners JOIN animals ON owners.id = animals.owner_id GROUP BY owners.full_name ORDER BY COUNT(animals.name) DESC;
