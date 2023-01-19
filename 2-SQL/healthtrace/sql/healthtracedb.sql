-- This script was generated by a beta version of the ERD tool in pgAdmin 4.
-- Please log an issue at https://redmine.postgresql.org/projects/pgadmin4/issues/new if you find any bugs, including reproduction steps.
BEGIN;


CREATE TABLE IF NOT EXISTS public.appointments
(
    id integer NOT NULL DEFAULT nextval('appointments_id_seq'::regclass),
    patient_id integer,
    practitioner_id integer,
    clinic_id integer,
    date date NOT NULL,
    "time" time with time zone NOT NULL,
    status character varying(15) COLLATE pg_catalog."default" NOT NULL,
    phone character varying(15) COLLATE pg_catalog."default",
    email text COLLATE pg_catalog."default",
    service_id integer,
    CONSTRAINT appointments_pkey PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS public.billings
(
    id integer NOT NULL DEFAULT nextval('billings_id_seq'::regclass),
    patient_id integer,
    service_id integer,
    cost numeric(10, 2) NOT NULL,
    paid boolean NOT NULL DEFAULT false,
    transaction_id uuid
);

CREATE TABLE IF NOT EXISTS public.clinics
(
    id integer NOT NULL DEFAULT nextval('clinics_id_seq'::regclass),
    name text COLLATE pg_catalog."default" NOT NULL,
    address text COLLATE pg_catalog."default" NOT NULL,
    phone character varying(15) COLLATE pg_catalog."default",
    email text COLLATE pg_catalog."default",
    CONSTRAINT clinics_pkey PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS public.encounters
(
    id integer NOT NULL DEFAULT nextval('encounters_id_seq'::regclass),
    patient_id integer,
    practitioner_id integer,
    date date NOT NULL,
    "time" time with time zone NOT NULL,
    type_of_visit character varying(15) COLLATE pg_catalog."default" NOT NULL,
    encounter_title text COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT encounters_pkey PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS public.laboratory_orders
(
    id integer NOT NULL DEFAULT nextval('laboratory_orders_id_seq'::regclass),
    patient_id integer,
    practitioner_id integer,
    clinic_id character varying(10) COLLATE pg_catalog."default" NOT NULL,
    request_date timestamp without time zone NOT NULL,
    due_date timestamp without time zone NOT NULL,
    has_result boolean NOT NULL,
    service_id integer,
    CONSTRAINT laboratory_orders_pkey PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS public.patients
(
    id integer NOT NULL DEFAULT nextval('patients_id_seq'::regclass),
    first_name text COLLATE pg_catalog."default" NOT NULL,
    last_name text COLLATE pg_catalog."default" NOT NULL,
    date_of_birth date,
    sex_at_birth character(1) COLLATE pg_catalog."default",
    phone character varying(15) COLLATE pg_catalog."default",
    email text COLLATE pg_catalog."default",
    home_address text COLLATE pg_catalog."default",
    occupation text COLLATE pg_catalog."default",
    preferred_pharmacy text COLLATE pg_catalog."default",
    blood_type character varying(3) COLLATE pg_catalog."default",
    CONSTRAINT patients_pkey PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS public.practitioners
(
    id integer NOT NULL DEFAULT nextval('practitioners_id_seq'::regclass),
    first_name text COLLATE pg_catalog."default" NOT NULL,
    last_name text COLLATE pg_catalog."default" NOT NULL,
    speciality text COLLATE pg_catalog."default" NOT NULL,
    registration_number character varying(15) COLLATE pg_catalog."default",
    phone character varying(15) COLLATE pg_catalog."default",
    email text COLLATE pg_catalog."default",
    CONSTRAINT practitioners_pkey PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS public.prescriptions
(
    id integer NOT NULL DEFAULT nextval('prescriptions_id_seq'::regclass),
    patient_id integer,
    practitioner_id integer,
    date date NOT NULL,
    drug_code character varying(15) COLLATE pg_catalog."default",
    drug_name character varying(50) COLLATE pg_catalog."default",
    notes text COLLATE pg_catalog."default",
    service_id integer,
    CONSTRAINT prescriptions_pkey PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS public.services
(
    id integer NOT NULL,
    name character varying(255) COLLATE pg_catalog."default" NOT NULL,
    description text COLLATE pg_catalog."default",
    cost numeric(10, 2) NOT NULL,
    service_type character varying(255) COLLATE pg_catalog."default" NOT NULL,
    provider character varying(255) COLLATE pg_catalog."default" NOT NULL,
    insurance_covered boolean NOT NULL,
    prerequisites text COLLATE pg_catalog."default",
    appointment_length integer NOT NULL,
    CONSTRAINT services_pkey PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS public.users
(
    id integer NOT NULL DEFAULT nextval('users_id_seq'::regclass),
    username character varying(50) COLLATE pg_catalog."default" NOT NULL,
    password character varying(60) COLLATE pg_catalog."default" NOT NULL,
    first_name text COLLATE pg_catalog."default" NOT NULL,
    last_name text COLLATE pg_catalog."default" NOT NULL,
    email text COLLATE pg_catalog."default" NOT NULL,
    phone character varying(15) COLLATE pg_catalog."default",
    role character varying(20) COLLATE pg_catalog."default" NOT NULL
);

ALTER TABLE IF EXISTS public.appointments
    ADD CONSTRAINT fk_clinics_appointments FOREIGN KEY (clinic_id)
    REFERENCES public.clinics (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS public.appointments
    ADD CONSTRAINT fk_patients_appointments FOREIGN KEY (patient_id)
    REFERENCES public.patients (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS public.appointments
    ADD CONSTRAINT fk_practitioners_appointments FOREIGN KEY (practitioner_id)
    REFERENCES public.practitioners (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS public.appointments
    ADD CONSTRAINT fk_services_appointments FOREIGN KEY (service_id)
    REFERENCES public.services (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS public.billings
    ADD CONSTRAINT fk_patients_billings FOREIGN KEY (patient_id)
    REFERENCES public.patients (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS public.billings
    ADD CONSTRAINT fk_services_billings FOREIGN KEY (service_id)
    REFERENCES public.services (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS public.encounters
    ADD CONSTRAINT fk_patients_encounters FOREIGN KEY (patient_id)
    REFERENCES public.patients (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS public.encounters
    ADD CONSTRAINT fk_practitioners_encounters FOREIGN KEY (practitioner_id)
    REFERENCES public.practitioners (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS public.laboratory_orders
    ADD CONSTRAINT fk_patients_laboratory_orders FOREIGN KEY (patient_id)
    REFERENCES public.patients (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS public.laboratory_orders
    ADD CONSTRAINT fk_practitioners_laboratory_orders FOREIGN KEY (practitioner_id)
    REFERENCES public.practitioners (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS public.laboratory_orders
    ADD CONSTRAINT fk_services_laboratory_orders FOREIGN KEY (service_id)
    REFERENCES public.services (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS public.prescriptions
    ADD CONSTRAINT fk_patients_prescriptions FOREIGN KEY (patient_id)
    REFERENCES public.patients (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS public.prescriptions
    ADD CONSTRAINT fk_practitioners_prescriptions FOREIGN KEY (practitioner_id)
    REFERENCES public.practitioners (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS public.prescriptions
    ADD CONSTRAINT fk_services_prescriptions FOREIGN KEY (service_id)
    REFERENCES public.services (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;

END;