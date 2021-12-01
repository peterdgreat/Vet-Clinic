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


-- Update the animals table by setting the species column to pokemon for all animals that don't have species already set.
-- Commit the transaction.
-- Verify that change was made and persists after commit.
-- Now, take a deep breath and... Inside a transaction delete all records in the animals table, then roll back the transaction.
-- After the roll back verify if all records in the animals table still exist. After that you can start breath as usual ;)
-- Inside a transaction:
-- Delete all animals born after Jan 1st, 2022.
-- Create a savepoint for the transaction.
-- Update all animals' weight to be their weight multiplied by -1.
-- Rollback to the savepoint
-- Update all animals' weights that are negative to be their weight multiplied by -1.
-- Commit transaction