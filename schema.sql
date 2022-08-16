/* Database schema to keep the structure of entire database. */

CREATE DATABASE vet_clinic;

CREATE TABLE animals (
  id integer PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  name varchar(100) NOT NULL,
  date_of_birth date,
  escape_attempts integer,
  neutered boolean,
  weight_kg decimal
);
ALTER TABLE animals ADD species varchar(100);

CREATE TABLE owners (
  id integer GENERATED ALWAYS AS IDENTITY,
  full_name varchar(100) NOT NULL,
  age integer,
  PRIMARY KEY(id)
);

CREATE TABLE species (
  id integer GENERATED ALWAYS AS IDENTITY,
  name varchar(100) NOT NULL,
  PRIMARY KEY(id)
);

ALTER TABLE animals DROP COLUMN species;

ALTER TABLE animals ADD COLUMN species_id integer REFERENCES species (id);

CREATE INDEX ON animals (specie_id);

ALTER TABLE animals ADD COLUMN owner_id integer REFERENCES owners (id);

CREATE INDEX ON animals (owner_id);

CREATE TABLE vets (
  id integer GENERATED ALWAYS AS IDENTITY,
  name varchar(100) NOT NULL,
  age integer,
  date_of_graduation date,
  PRIMARY KEY (id)
);

CREATE TABLE specializations (
  vet_id integer REFERENCES vets (id),
  specie_id integer REFERENCES species (id),
  PRIMARY KEY (vet_id, specie_id)
);

CREATE INDEX ON specializations (vet_id);

CREATE INDEX ON specializations (specie_id);

CREATE TABLE visits (
  vet_id integer REFERENCES vets (id),
  animal_id integer REFERENCES animals (id),
  date_of_visit date,
  PRIMARY KEY (vet_id, animal_id, date_of_visit)
);

CREATE INDEX ON visits (vet_id);

CREATE INDEX ON visits (animal_id);

ALTER TABLE owners ADD COLUMN email VARCHAR(120);

ALTER TABLE visits ALTER COLUMN date_of_visit TYPE timestamp;

CREATE INDEX animal_id_asc ON visits(animal_id ASC);

CREATE INDEX vet_id_asc ON visits(vet_id ASC);

DROP INDEX vet_id_asc;

CREATE INDEX email_asc ON owners(email ASC);

ALTER TABLE owners DROP COLUMN email;

ALTER TABLE visits ALTER COLUMN date_of_visit TYPE date;
