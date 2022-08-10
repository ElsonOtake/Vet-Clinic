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

ALTER TABLE animals ADD COLUMN owner_id integer REFERENCES owners (id);
