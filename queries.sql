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


-- Write queries to answer the following:
-- Who was the last animal seen by William Tatcher?
-- How many different animals did Stephanie Mendez see?
-- List all vets and their specialties, including vets with no specialties.
-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
-- What animal has the most visits to vets?
-- Who was Maisy Smith's first visit?
-- Details for most recent visit: animal information, vet information, and date of visit.
-- How many visits were with a vet that did not specialize in that animal's species?
-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.

SELECT owners.full_name, animals.name FROM owners JOIN animals ON owners.id = animals.owner_id WHERE animals.name = (SELECT animals.name FROM animals JOIN visits ON animals.id = visits.animals_id JOIN vets ON vets.id = visits.vets_id WHERE vets.name = 'William Tatcher' ORDER BY  date_of_visit DESC LIMIT 1);

SELECT COUNT(DISTINCT animals.name) FROM animals JOIN visits ON animals.id = visits.animals_id JOIN vets ON vets.id = visits.vets_id WHERE vets.name = 'Stephanie Mendez';

SELECT vets.name FROM vets LEFT JOIN specializations ON vets.id = specializations.vets_id;

SELECT animals.name FROM animals JOIN visits ON animals.id = visits.animals_id JOIN vets ON vets.id = visits.vets_id WHERE vets.name = 'Stephanie Mendez' AND   date_of_visit  BETWEEN DATE('2020-04-01') AND DATE('2020-08-30');

SELECT animals.name FROM animals JOIN visits ON animals.id = visits.animals_id JOIN vets ON vets.id = visits.vets_id GROUP BY animals.name ORDER BY COUNT(animals.name) DESC LIMIT 1;

SELECT owners.full_name, animals.name FROM owners JOIN animals ON owners.id = animals.owner_id JOIN visits ON animals.id = visits.animals_id JOIN vets ON vets.id = visits.vets_id WHERE vets.name = 'Maisy Smith' ORDER BY date_of_visit ASC LIMIT 1;

SELECT * FROM animals JOIN visits ON animals.id = visits.animals_id JOIN vets ON vets.id = visits.vets_id WHERE vets.name = 'Maisy Smith' ORDER BY date_of_visit DESC LIMIT 1;

SELECT COUNT(*) FROM animals INNER JOIN visits ON animals.id = visits.animals_id
INNER JOIN vets ON vets.id = visits.vets_id
INNER JOIN specie ON animals.species_id = specie.id
LEFT JOIN specializations ON specializations.vets_id = vets.id
WHERE specializations.species_id != specie.id OR specializations.species_id IS NULL;

SELECT specie.name FROM animals 
  INNER JOIN specie ON animals.species_id = specie.id
  INNER JOIN visits ON animals.id = visits.animals_id
  INNER JOIN vets ON vets.id = visits.vets_id
  WHERE vets.name = 'Maisy Smith'
  GROUP BY specie.name
  ORDER BY COUNT(*) DESC LIMIT 1;