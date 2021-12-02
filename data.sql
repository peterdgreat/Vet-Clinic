/* Populate database with sample data. */

INSERT INTO animals (
    name,
    date_of_birth,
    escape_attempts,
    neutered,
    weight_kg
)
VALUES (
    'Agumon',
    DATE '2020-02-03',
    0,
    TRUE,
    10.23
),
(
    'Gabumon',
    DATE '2018-11-15',
    2,
    TRUE,
    8
),
(
    'Pikachu',
    DATE '2021-01-01',
    1,
    FALSE,
    15.04
),
(
    'Devimon',
    DATE '2017-05-12',
    5,
    TRUE,
    11
);

-- Insert more data here.


INSERT INTO animals (
    name,
    date_of_birth,
    escape_attempts,
    neutered,
    weight_kg
)
VALUES (
    'Charmander',
    DATE '2020-02-08',
    0,
    FALSE,
    -11
),
(
    'Plantmon',
    DATE '2022-11-15',
    2,
    TRUE,
    -5.7
),
(
    'Squirtle',
    DATE '1993-04-02',
    3,
    FALSE,
    -12.13
),
(
    'Angemon',
    DATE '2005-06-12',
    1,
    TRUE,
    -45
),
(
    'Boarmon',
    DATE '2005-06-7',
    7,
    TRUE,
    20.4
),
(
    'Blossom',
    DATE '1998-10-13',
    3,
    TRUE,
    17
);

-- Inside a transaction update the animals table by setting the species column to unspecified. Verify that change was made. Then roll back the change and verify that species columns went back to the state before tranasction.
BEGIN;
UPDATE animals
SET species = 'unspecified';
 SELECT * FROM animals;
 ROllBACK;
    SELECT * FROM animals;
-- Inside a transaction:
-- Update the animals table by setting the species column to digimon for all animals that have a name ending in mon.
BEGIN;
UPDATE animals
SET species = 'digimon'
WHERE name LIKE '%mon';

-- Update the animals table by setting the species column to pokemon for all animals that don't have species already set.
UPDATE animals
set species = 'pokemon'
WHERE species IS NULL;
-- Commit the transaction.

COMMIT;

-- Verify that change was made and persists after commit.
SELECT * FROM animals;
-- Now, take a deep breath and... Inside a transaction delete all records in the animals table, then roll back the transaction.
BEGIN;
TRUNCATE animals;
ROllBACK;

-- After the roll back verify if all records in the animals table still exist. After that you can start breath as usual ;)
SELECT * FROM animals;
-- Inside a transaction:
BEGIN;
-- Delete all animals born after Jan 1st, 2022.
DELETE FROM animals
WHERE date_of_birth > DATE '2022-01-01';
-- Create a savepoint for the transaction.
SAVEPOINT savepoint_1;
-- Update all animals' weight to be their weight multiplied by -1.
UPDATE animals
SET weight_kg = weight_kg * -1;
-- Rollback to the savepoint
ROLLBACK TO savepoint_1;
-- Update all animals' weights that are negative to be their weight multiplied by -1.
UPDATE animals
SET weight_kg = weight_kg * -1
WHERE weight_kg < 0;
-- Commit transaction
COMMIT;


-- Insert the following data into the owners table:
-- Sam Smith 34 years old.
-- Jennifer Orwell 19 years old.
-- Bob 45 years old.
-- Melody Pond 77 years old.
-- Dean Winchester 14 years old.
-- Jodie Whittaker 38 years old.

INSERT INTO owners (
    full_name,
    age
)
VALUES (
    'Sam Smith',
    34
),
(
    'Jennifer Orwell',
    19
),
(
    'Bob',
    45
),
(
    'Melody Pond',
    77
),
(
    'Dean Winchester',
    14
),
(
    'Jodie Whittaker',
    38
);

-- Insert the following data into the species table:
-- Pokemon
-- Digimon

INSERT  INTO specie (
    name
)
VALUES (
    'Pokemon'
),
(
    'Digimon'
);

-- Modify your inserted animals so it includes the species_id value:
-- If the name ends in "mon" it will be Digimon
-- All other animals are Pokemon
BEGIN;
UPDATE animals
SET species_id = (
    SELECT id
    FROM specie
    WHERE name = 'Digimon'
)
WHERE name LIKE '%mon';

UPDATE animals
SET species_id = (
    SELECT id
    FROM specie
    WHERE name = 'Pokemon'
)
WHERE species_id IS NULL;
COMMIT;

-- Modify your inserted animals to include owner information (owner_id):
-- Sam Smith owns Agumon.
-- Jennifer Orwell owns Gabumon and Pikachu.
-- Bob owns Devimon and Plantmon.
-- Melody Pond owns Charmander, Squirtle, and Blossom.
-- Dean Winchester owns Angemon and Boarmon.

BEGIN;
UPDATE animals
SET owner_id = (
    SELECT id
    FROM owners
    WHERE full_name = 'Sam Smith'
)
WHERE name = 'Agumon';

UPDATE animals
SET owner_id = (
    SELECT id
    FROM owners
    WHERE full_name = 'Jennifer Orwell'
)
WHERE name in ('Gabumon', 'Pikachu');

UPDATE animals
SET owner_id = (
    SELECT id
    FROM owners
    WHERE full_name = 'Bob'
)
WHERE name in ('Devimon', 'Plantmon');

UPDATE animals
SET owner_id = (
    SELECT id
    FROM owners
    WHERE full_name = 'Melody Pond'
)
WHERE name in ('Charmander', 'Squirtle', 'Blossom');

UPDATE animals 
SET owner_id = (
    SELECT id
    FROM owners
    WHERE full_name = 'Dean Winchester'
)
WHERE name in ('Angemon', 'Boarmon');
COMMIT;