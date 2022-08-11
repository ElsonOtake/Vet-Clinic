/*Queries that provide answers to the questions from all projects.*/

-- Find all animals whose name ends in "mon".
SELECT * from animals WHERE name LIKE '%mon';
-- List the name of all animals born between 2016 and 2019.
SELECT name from animals WHERE date_of_birth BETWEEN 'Jan 1, 2016' AND 'Dec 31, 2019';
-- List the name of all animals that are neutered and have less than 3 escape attempts.
SELECT name from animals WHERE neutered AND escape_attempts < 3;
-- List the date of birth of all animals named either "Agumon" or "Pikachu".
SELECT date_of_birth from animals WHERE name IN ('Agumon', 'Pikachu');
-- List name and escape attempts of animals that weigh more than 10.5kg
SELECT name, escape_attempts from animals WHERE weight_kg > 10.5;
-- Find all animals that are neutered.
SELECT * from animals WHERE neutered;
-- Find all animals not named Gabumon.
SELECT * from animals WHERE name <> 'Gabumon';
-- Find all animals with a weight between 10.4kg and 17.3kg (including the animals with 
-- the weights that equals precisely 10.4kg or 17.3kg)
SELECT * from animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

-- How many animals are there?
SELECT COUNT(*) FROM animals;
-- How many animals have never tried to escape?
SELECT COUNT(escape_attempts) FROM animals WHERE escape_attempts = 0;
-- What is the average weight of animals?
SELECT AVG(weight_kg) FROM animals;
-- Who escapes the most, neutered or not neutered animals? neutered
SELECT neutered, SUM(escape_attempts) FROM animals GROUP BY neutered;
-- What is the minimum and maximum weight of each type of animal?
SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;
-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species, AVG(escape_attempts) FROM animals
  WHERE date_of_birth BETWEEN 'Jan 1, 1990' AND 'Dec 31, 2000' GROUP BY species;

-- What animals belong to Melody Pond?
SELECT full_name, name FROM animals JOIN owners ON owner_id = owners.id WHERE full_name = 'Melody Pond';
-- List of all animals that are pokemon (their type is Pokemon).
SELECT animals.name FROM animals JOIN species ON species_id = species.id WHERE species.name = 'Pokemon';
-- List all owners and their animals, remember to include those that don't own any animal.
SELECT full_name, name FROM owners LEFT JOIN animals ON owner_id = owners.id;
-- How many animals are there per species?
SELECT S.name, COUNT(S.name) FROM species S JOIN animals ON species_id = S.id GROUP BY S.name;
-- List all Digimon owned by Jennifer Orwell.
SELECT full_name, A.name, S.name FROM animals A JOIN owners ON owner_id = owners.id JOIN species S ON
  S.id = species_id WHERE S.name = 'Digimon' AND full_name = 'Jennifer Orwell';
-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT full_name, name, escape_attempts FROM animals JOIN owners ON owner_id = owners.id WHERE
  escape_attempts = 0 AND full_name = 'Dean Winchester';
-- Who owns the most animals?
SELECT full_name, COUNT(DISTINCT name) count FROM animals JOIN owners ON owner_id = owners.id
  GROUP BY full_name ORDER BY count DESC LIMIT 1;

-- Who was the last animal seen by William Tatcher?
SELECT vets.name, animals.name, date_of_visit FROM visits JOIN vets ON vet_id = vets.id JOIN animals ON
  animal_id = animals.id WHERE vets.name = 'William Tatcher' ORDER BY date_of_visit DESC LIMIT 1;
-- How many different animals did Stephanie Mendez see?
SELECT name, COUNT(DISTINCT animal_id) FROM visits JOIN vets ON vet_id = vets.id
  WHERE name = 'Stephanie Mendez' GROUP BY name;
-- List all vets and their specialties, including vets with no specialties.
SELECT vets.name, species.name FROM vets LEFT JOIN specializations ON vet_id = vets.id LEFT JOIN species ON
  specie_id = species.id ORDER BY vets.name, species.name;
-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT vets.name, animals.name, date_of_visit FROM visits JOIN vets ON vet_id = vets.id JOIN animals ON
  animal_id = animals.id WHERE vets.name = 'Stephanie Mendez' AND
  date_of_visit BETWEEN 'Apr 1, 2020' AND 'Aug 30, 2020' ORDER BY date_of_visit;
-- What animal has the most visits to vets?
SELECT name, COUNT(date_of_visit) count FROM visits JOIN animals ON animal_id = animals.id
  GROUP BY name ORDER BY count DESC LIMIT 1;
-- Who was Maisy Smith's first visit?
SELECT vets.name, animals.name, date_of_visit FROM visits JOIN vets ON vet_id = vets.id JOIN animals ON
  animal_id = animals.id WHERE vets.name = 'Maisy Smith' ORDER BY date_of_visit LIMIT 1;
-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT animals.name animal, species.name specie, owners.full_name owner, vets.name vet, date_of_visit FROM
  visits JOIN animals ON animal_id = animals.id JOIN vets ON vet_id = vets.id JOIN species ON
  species_id = species.id JOIN owners ON owner_id = owners.id WHERE
  date_of_visit = (SELECT MAX(date_of_visit) FROM visits);
-- How many visits were with a vet that did not specialize in that animal's species?
SELECT COUNT(date_of_visit) FROM vets LEFT JOIN visits V ON V.vet_id = vets.id LEFT JOIN specializations S ON
  S.vet_id = vets.id LEFT JOIN animals ON animal_id = animals.id WHERE animals.species_id NOT IN
  (SELECT specie_id FROM specializations WHERE vet_id = vets.id) OR S.specie_id IS NULL;
-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT vets.name vet, species.name specie, COUNT(date_of_visit) count FROM vets JOIN visits ON
  visits.vet_id = vets.id JOIN animals ON animal_id = animals.id JOIN species ON species_id = species.id WHERE
  vets.name = 'Maisy Smith' GROUP BY vet, specie ORDER BY count DESC;


-- Queries used for tests
SELECT vets.name vet, animals.name animal, speciesA.name specie, speciesB.name specialization FROM
  vets LEFT JOIN visits ON visits.vet_id = vets.id LEFT JOIN animals ON animal_id = animals.id LEFT JOIN
  species speciesA ON species_id = speciesA.id LEFT JOIN specializations special ON
  special.vet_id = vets.id LEFT JOIN species speciesB ON special.specie_id = speciesB.id;

SELECT vets.name, COUNT(date_of_visit) count FROM vets LEFT JOIN visits V ON V.vet_id = vets.id LEFT JOIN
  specializations S ON S.vet_id = vets.id LEFT JOIN animals ON animal_id = animals.id WHERE
  animals.species_id NOT IN (SELECT specie_id FROM specializations WHERE vet_id = vets.id) OR
  S.specie_id IS NULL GROUP BY vets.name ORDER BY count DESC;