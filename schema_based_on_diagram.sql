CREATE DATABASE clinic;

CREATE TABLE patients (
  id SERIAL,
  name VARCHAR(255) NOT NULL,
  date_of_birth DATE NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE invoices (
  id integer GENERATED ALWAYS AS IDENTITY,
  total_amount DECIMAL NOT NULL,
  generated_at TIMESTAMP NOT NULL, 
  payed_at TIMESTAMP NOT NULL,
  medical_history_id INT NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE inovice_items (
  id integer GENERATED ALWAYS AS IDENTITY,
  unit_price DECIMAL,
  quantity integer,
  total_price DECIMAL,
  invoice_id integer,
  treatment_id integer,
  PRIMARY KEY (id)
);

CREATE TABLE medical_histories (
  id integer GENERATED ALWAYS AS IDENTITY,
  admitted_at TIMESTAMP,
  patient_id integer,
  status varchar(255),
  PRIMARY KEY(id)
);

CREATE TABLE treatments (
  id integer GENERATED ALWAYS AS IDENTITY,
  type VARCHAR(255),
  name VARCHAR(255),
  primary key (id)
);