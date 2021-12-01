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