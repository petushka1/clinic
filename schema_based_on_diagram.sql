/* CLININ DATABASE SCHEMA */

CREATE TABLE medical_histiries (
    id INT GENERATED ALWAYS AS IDENTITY,
    admitted_at TIMESTAMP,
    patient_id INT,
    status VARCHAR(250),
    CONSTRAINT patient_fk
        FOREIGN KEY(patient_id)
            REFERENCES patient(id),
    PRIMARY KEY (id)
);

CREATE TABLE patient (
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(250),
    date_of_birth DATE,
    PRIMARY KEY (id)
);

CREATE TABLE invoices (
    id INT GENERATED ALWAYS AS IDENTITY,
    total_amount DECIMAL,
    generated_at TIMESTAMP,
    payed_at TIMESTAMP,
    medical_history_id INT,
    CONSTRAINT medical_history_fk
        FOREIGN KEY(medical_history_id)
            REFERENCES medical_histories(id),
    PRIMARY KEY (id)
);

CREATE TABLE treatments (
    id INT GENERATED ALWAYS AS IDENTITY,
    type VARCHAR,
    name VARCHAR,
    PRIMARY KEY (id)
);

CREATE TABLE invoice_items (
    id INT GENERATED ALWAYS AS IDENTITY,
    unit_price DECIMAL,
    quantity INT,
    total_price DECIMAL,
    invoice_id INT,
    treatment_id INT,
    CONSTRAINT treatment_fk
        FOREIGN KEY(treatment_id)
            REFERENCES treatments(id),
    PRIMARY KEY (id)
);

/* MANY-TO-MANY RELATIONAL TABLE */
CREATE TABLE medical_treatment_history (
    medical_history_id INT,
    treatment_id INT,
    CONSTRAINT medical_history_fk
        FOREIGN KEY(medical_history_id)
            REFERENCES medical_histories(id),
    CONSTRAINT treatment_fk
        FOREIGN KEY(treatment_id)
            REFERENCES treatments(id)
);

/* CREATE INDEXES ON FOREIGN KEYS */
CREATE INDEX patient_index ON medical_histories (patient_id DESC);
CREATE INDEX invoices_index ON invoices (medical_history_id DESC);
CREATE INDEX invoice_items_index ON invoice_items (treatment_id DESC);
CREATE INDEX medical_treatment_history_index ON medical_treatment_history (medical_history_id, treatment_id DESC);