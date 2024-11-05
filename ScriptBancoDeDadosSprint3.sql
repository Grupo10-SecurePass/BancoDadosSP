CREATE DATABASE securepass;
USE securepass;

CREATE TABLE empresa (
    NR INT PRIMARY KEY ,
    nomeFantasia VARCHAR(45) UNIQUE NOT NULL,
    razaoSocial VARCHAR(100) UNIQUE NOT NULL,
    CNPJ CHAR(14) UNIQUE NOT NULL,
    status TINYINT
);

CREATE TABLE linha (
    idLinha INT PRIMARY KEY,
    nome VARCHAR(45),
    paradaInicial VARCHAR(45),
    paradaFinal VARCHAR(45),
    fkEmpresa INT,
    CONSTRAINT fkEmpresaLinha FOREIGN KEY (fkEmpresa) REFERENCES empresa(NR)
);

CREATE TABLE cargo (
    idCargo INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45),
    descricao VARCHAR(100)
);

CREATE TABLE usuario (
    idUsuario INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    cpf CHAR(11),
    email VARCHAR(256) UNIQUE NOT NULL,
	CONSTRAINT chEmail CHECK (email like('%@%.%')),
    senha VARCHAR(45) UNIQUE NOT NULL,
    status TINYINT,
    fkCargo INT,
    CONSTRAINT fkCargoUsuario FOREIGN KEY (fkCargo) REFERENCES cargo(idCargo),
    fkLinha INT,
    CONSTRAINT fkLinhaUsuario FOREIGN KEY (fkLinha) REFERENCES linha(idLinha),
    fkNR INT,
    CONSTRAINT fkEmpresaUsuario FOREIGN KEY (fkNR) REFERENCES empresa(NR)
);

CREATE TABLE dispositivo (
    idDispositivo INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) UNIQUE,
    status TINYINT,
    fkLinha INT,
    CONSTRAINT fkLinhaDispositivo FOREIGN KEY (fkLinha) REFERENCES linha(idLinha)
);

CREATE TABLE componente (
    idComponente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    unidadeDeMedida VARCHAR(45)
);

CREATE TABLE captura (
    idCaptura INT PRIMARY KEY AUTO_INCREMENT,
    registro FLOAT,
    dataRegistro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    fkComponente INT,
    CONSTRAINT fkCapturaComponente FOREIGN KEY (fkComponente) REFERENCES componente(idComponente),
    fkDispositivo INT,
    CONSTRAINT fkCapturaDispositivo FOREIGN KEY (fkDispositivo) REFERENCES dispositivo(idDispositivo)
);


CREATE TABLE limite (
    idLimite INT PRIMARY KEY AUTO_INCREMENT,
    valor FLOAT,
    fkComponente INT,
    CONSTRAINT fkLimiteComponente FOREIGN KEY (fkComponente) REFERENCES componente(idComponente),
    fkDispositivo INT,
	CONSTRAINT fkLimiteDispositivo FOREIGN KEY (fkDispositivo) REFERENCES dispositivo(idDispositivo),
    fkLinha INT,
	CONSTRAINT fkLimiteLinha FOREIGN KEY (fkLinha) REFERENCES linha(idLinha)
);


CREATE TABLE feedback (
    idFeedback INT PRIMARY KEY AUTO_INCREMENT,
    descricao TEXT,
    fkUsuario INT,
   CONSTRAINT fkfeedbackUsuario FOREIGN KEY (fkUsuario) REFERENCES usuario(idUsuario),
    fkNR INT,
    CONSTRAINT fkEmpresaFeedback FOREIGN KEY (fkNR) REFERENCES empresa(NR)
);


CREATE TABLE alerta (
    idAlerta INT PRIMARY KEY AUTO_INCREMENT,
    dataAlerta DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    descricao TEXT,
    fkComponente INT,
   CONSTRAINT fkAlertaComponente FOREIGN KEY (fkComponente) REFERENCES componente(idComponente),
    fkDispositivo INT,
    CONSTRAINT fkAlertaDispositivo   FOREIGN KEY (fkDispositivo) REFERENCES dispositivo(idDispositivo),
    fkLinha INT,
   CONSTRAINT fkAlertaLinha FOREIGN KEY (fkLinha) REFERENCES linha(idLinha), 
   fkCaptura INT,
   CONSTRAINT fkAlertaCaptura FOREIGN KEY (fkCaptura) REFERENCES captura(idCaptura)
    
);

CREATE TABLE feedback(
idFeedback INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(100),
email VARCHAR(256),
descricao TEXT, 
fkUsuario INT, 
CONSTRAINT fkFeedbackUsuario FOREIGN KEY (fkUsuario) REFERENCES usuario(idUsuario)
);

