CREATE DATABASE Tickets;

CREATE TABLE funcionarios (
    fnc_id SERIAL PRIMARY KEY,
    fnc_cpf VARCHAR(11),
    fnc_nome VARCHAR(50),
    fnc_ativo CHAR(1) NOT NULL CHECK (tck_ativo IN ('A', 'I')),,
    update_at TIMESTAMP,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE tickets (
    tck_id SERIAL PRIMARY KEY,
    tck_quantidade INTEGER NOT NULL,
    tck_ativo CHAR(1) NOT NULL CHECK (tck_ativo IN ('A', 'I')),
    funcionario_id INTEGER NOT NULL,
    update_at TIMESTAMP,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_funcionario
      FOREIGN KEY (funcionario_id)
      REFERENCES funcionarios(fnc_id)
      ON DELETE RESTRICT
      ON UPDATE CASCADE
);
