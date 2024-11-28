CREATE DATABASE securepass;
USE securepass;

CREATE TABLE empresa (
    NR INT PRIMARY KEY ,
    nomeFantasia VARCHAR(45) UNIQUE NOT NULL,
    razaoSocial VARCHAR(100) UNIQUE NOT NULL,
    CNPJ CHAR(14) UNIQUE NOT NULL,
    status TINYINT
);

INSERT INTO empresa VALUES 
(5223, 'SecurePass', 'Empresa de solução tecnológica para auxílio no monitoramento do servidor de catracas do metro', '12345678901234', 1);

CREATE TABLE linha (
    idLinha INT PRIMARY KEY,
    nome VARCHAR(45),
    paradaInicial VARCHAR(45),
    paradaFinal VARCHAR(45),
    fkEmpresa INT,
    CONSTRAINT fkEmpresaLinha FOREIGN KEY (fkEmpresa) REFERENCES empresa(NR)
);

INSERT INTO linha (idLinha, nome, ParadaInicial, ParadaFinal, fkEmpresa) VALUES
(1, 'Linha 01 - Azul', 'Jabaquara', 'Tucuruvi', null),
(2, 'Linha 02 - Verde', 'Vila Prudente', 'Vila Madalena', null),
(3, 'Linha 03 - Vermelha', 'Corinthians-Itaquera', 'Palmeiras-Barra Funda', null),
(4, 'Linha 04 - Amarela', 'Vila Sônia', 'Luz', null),
(5, 'Linha 05 - Lilás', 'Capão Redondo', 'Chácara Klabin', null),
(15, 'Linha 15 - Prata', 'Vila Prudente', 'Jardim Colonial', null);

CREATE TABLE cargo (
    idCargo INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45),
    descricao VARCHAR(100)
);

INSERT INTO cargo (nome, descricao) VALUES
('representante', 'Responsável por relacionar as linhas com a empresa e cadastrar os gerentes de cada linha.'),
('gerente', 'Responsável por cadastrar todas as máquinas pertencentes àquela linha e os suportes técnicos.'),
('tecnico', 'Responsável por monitorar as máquinas por meio de suas dashboards.');


CREATE TABLE usuario (
    idUsuario INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    cpf CHAR(11),
    email VARCHAR(256) UNIQUE NOT NULL,
	CONSTRAINT chEmail CHECK (email like('%@%.%')),
    senha VARCHAR(45) NOT NULL,
    status TINYINT,
    fkCargo INT,
    CONSTRAINT fkCargoUsuario FOREIGN KEY (fkCargo) REFERENCES cargo(idCargo),
    fkLinha INT,
    CONSTRAINT fkLinhaUsuario FOREIGN KEY (fkLinha) REFERENCES linha(idLinha),
    fkNR INT,
    CONSTRAINT fkEmpresaUsuario FOREIGN KEY (fkNR) REFERENCES empresa(NR)
);

INSERT INTO usuario (nome, cpf, email, senha, status, fkCargo, fkLinha, fkNR) VALUES
('João Silva', '12345678901', 'joao@gmail.com', 'senha1234', 1, 1, 1, 5223),
('Maria Oliveira', '23456789012', 'maria@gmail.com', 'senha1234', 1, 3, 2, 5223),
('Carlos Santos', '34567890123', 'carlos@gmail.com', 'senha1234', 1, 3, 1, 5223),
('Ana Costa', '45678901234', 'ana@gmail.com', 'senha1234', 1, 1, 2, 5223),
('Pedro Lima', '56789012345', 'pedro@gmail.com', 'senha1234', 1, 2, 1, 5223),
('Gabriel Gomes', '56789012345', 'gabriel@gmail.com', 'senha1234', 1, 2, 2, 5223);

CREATE TABLE dispositivo (
    idDispositivo INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) UNIQUE,
    ipv4Catraca VARCHAR(15) UNIQUE,
    status TINYINT,
    fkLinha INT,
    CONSTRAINT fkLinhaDispositivo FOREIGN KEY (fkLinha) REFERENCES linha(idLinha)
);

INSERT INTO dispositivo(nome, ipv4Catraca, status, fkLinha) VALUES
('DESKTOP-17C842E', "98.81.77.174",1, 1),
('MaquinaTeste', "98.81.78.174",1, 1);

CREATE TABLE componente (
    idComponente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    unidadeDeMedida VARCHAR(45)
);

INSERT INTO componente(nome, unidadeDeMedida) VALUES
('PercCPU', '%'),
('PercMEM', '%'),
('PercDISCO', '%'),
('RedeRecebida', 'MB'),
('RedeEnviada', 'MB'),
('FreqCPU', 'GHz'),
('PerdaPacote', '%'),
('TempoResposta', 'ms'),
('PacoteRecebido', 'Pacotes'),
('PacoteEnviado', 'Pacotes');

CREATE TABLE captura (
    idCaptura INT PRIMARY KEY AUTO_INCREMENT,
    registro FLOAT,
    dataRegistro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    fkComponente INT,
    CONSTRAINT fkCapturaComponente FOREIGN KEY (fkComponente) REFERENCES componente(idComponente),
    fkLinha INT,
    CONSTRAINT fkCapturaLinha FOREIGN KEY (fkLinha) REFERENCES linha(idLinha),
    fkDispositivo INT,
    CONSTRAINT fkCapturaDispositivo FOREIGN KEY (fkDispositivo) REFERENCES dispositivo(idDispositivo)
);

-- Inserções para o dia de hoje (substitua com a data atual, por exemplo: '2024-10-24')
INSERT INTO captura (registro, dataRegistro, fkComponente, fkLinha, fkDispositivo) 
VALUES (3.5, '2024-10-24 10:00:00', 6, 1, 1);

INSERT INTO captura (registro, dataRegistro, fkComponente, fkLinha, fkDispositivo) 
VALUES (15.2, '2024-10-24 11:30:00', 8, 1, 1);

-- Inserções para 1 dia atrás
INSERT INTO captura (registro, dataRegistro, fkComponente, fkLinha, fkDispositivo) 
VALUES (4.8, '2024-10-23 09:15:00', 6, 1, 1);

INSERT INTO captura (registro, dataRegistro, fkComponente, fkLinha, fkDispositivo) 
VALUES (30.6, '2024-10-23 14:45:00', 8, 1, 1);

-- Inserções para 2 dias atrás
INSERT INTO captura (registro, dataRegistro, fkComponente, fkLinha, fkDispositivo) 
VALUES (5.0, '2024-10-22 08:30:00', 6, 1, 1);

INSERT INTO captura (registro, dataRegistro, fkComponente, fkLinha, fkDispositivo) 
VALUES (42.7, '2024-10-22 12:10:00', 8, 1, 1);

-- Inserções para 3 dias atrás
INSERT INTO captura (registro, dataRegistro, fkComponente, fkLinha, fkDispositivo) 
VALUES (3.9, '2024-10-21 10:20:00', 6, 1, 1);

INSERT INTO captura (registro, dataRegistro, fkComponente, fkLinha, fkDispositivo) 
VALUES (65.4, '2024-10-21 13:50:00', 8, 1, 1);

-- Inserções para 4 dias atrás
INSERT INTO captura (registro, dataRegistro, fkComponente, fkLinha, fkDispositivo) 
VALUES (5.8, '2024-10-20 07:45:00', 6, 1, 2);

INSERT INTO captura (registro, dataRegistro, fkComponente, fkLinha, fkDispositivo) 
VALUES (23.1, '2024-10-20 16:30:00', 8, 1, 2);

-- Inserções para 5 dias atrás
INSERT INTO captura (registro, dataRegistro, fkComponente, fkLinha, fkDispositivo) 
VALUES (4.2, '2024-10-19 09:00:00', 6, 1, 2);

INSERT INTO captura (registro, dataRegistro, fkComponente, fkLinha, fkDispositivo) 
VALUES (78.3, '2024-10-19 15:20:00', 8, 1, 2);

INSERT INTO captura (registro, fkComponente, fkLinha, fkDispositivo) 
VALUES 
(50.0, 1, 1, 1),
(70.0, 1, 1, 1),
(55.0, 1, 1, 1),
(80.0, 1, 1, 1),
(60.0, 1, 1, 1),
(90.0, 1, 1, 1);

INSERT INTO captura (registro, fkComponente, fkLinha, fkDispositivo) 
VALUES 
(50.0, 2, 1, 1),
(70.0, 2, 1, 1),
(55.0, 2, 1, 1),
(80.0, 2, 1, 1),
(60.0, 2, 1, 1),
(90.0, 2, 1, 1);

CREATE TABLE limite (
    idLimite INT PRIMARY KEY AUTO_INCREMENT,
    valor FLOAT,
    tipo VARCHAR(10) NOT NULL,
		CONSTRAINT chTipo CHECK (tipo in ('acima', 'abaixo')),
    fkComponente INT,
    CONSTRAINT fkLimiteComponente FOREIGN KEY (fkComponente) REFERENCES componente(idComponente),
    fkDispositivo INT,
	CONSTRAINT fkLimiteDispositivo FOREIGN KEY (fkDispositivo) REFERENCES dispositivo(idDispositivo),
    fkLinha INT,
	CONSTRAINT fkLimiteLinha FOREIGN KEY (fkLinha) REFERENCES linha(idLinha)
);

INSERT INTO limite (valor, tipo,fkComponente, fkDispositivo, fkLinha) VALUES
(80.0, 'acima', 1, 1, 1),
(85.0, 'acima', 2, 1, 1),
(90.0, 'acima', 3, 1, 1),
(1000.0, 'abaixo', 4, 1, 1),
(1000.0, 'abaixo', 5, 1, 1),
(3.5, 'abaixo', 6, 1, 1),
(10.0, 'acima', 7, 1, 1),
(200.0, 'acima', 8, 1, 1);

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
    visualizacao TINYINT,
    fkComponente INT,
   CONSTRAINT fkAlertaComponente FOREIGN KEY (fkComponente) REFERENCES componente(idComponente),
    fkDispositivo INT,
    CONSTRAINT fkAlertaDispositivo   FOREIGN KEY (fkDispositivo) REFERENCES dispositivo(idDispositivo),
    fkLinha INT,
   CONSTRAINT fkAlertaLinha FOREIGN KEY (fkLinha) REFERENCES linha(idLinha), 
   fkCaptura INT,
   CONSTRAINT fkAlertaCaptura FOREIGN KEY (fkCaptura) REFERENCES captura(idCaptura)
);

-- Alerta para captura do dia de hoje
INSERT INTO alerta (dataAlerta, descricao, visualizacao, fkComponente, fkDispositivo, fkLinha, fkCaptura) 
VALUES ('2024-10-24 10:00:00', 'Componente 6 está abaixo do limite de 5.0: valor atual é 3.5', 0, 6, 1, 1, 1);

INSERT INTO alerta (dataAlerta, descricao, visualizacao, fkComponente, fkDispositivo, fkLinha, fkCaptura) 
VALUES ('2024-10-24 11:30:00', 'Componente 8 está abaixo do limite de 50.0: valor atual é 15.2', 0, 8, 1, 1, 2);

-- Alerta para captura de 1 dia atrás
INSERT INTO alerta (dataAlerta, descricao, visualizacao, fkComponente, fkDispositivo, fkLinha, fkCaptura) 
VALUES ('2024-10-23 09:15:00', 'Componente 6 está abaixo do limite de 5.0: valor atual é 4.8', 0, 6, 1, 1, 3);

INSERT INTO alerta (dataAlerta, descricao, visualizacao, fkComponente, fkDispositivo, fkLinha, fkCaptura) 
VALUES ('2024-10-23 14:45:00', 'Componente 8 está abaixo do limite de 50.0: valor atual é 30.6', 0, 8, 1, 1, 4);

-- Alerta para captura de 2 dias atrás
INSERT INTO alerta (dataAlerta, descricao, visualizacao, fkComponente, fkDispositivo, fkLinha, fkCaptura) 
VALUES ('2024-10-22 08:30:00', 'Componente 6 está abaixo do limite de 5.0: valor atual é 5.0', 0, 6, 1, 1, 5);

INSERT INTO alerta (dataAlerta, descricao, visualizacao, fkComponente, fkDispositivo, fkLinha, fkCaptura) 
VALUES ('2024-10-22 12:10:00', 'Componente 8 está abaixo do limite de 50.0: valor atual é 42.7', 0, 8, 1, 1, 6);

-- Alerta para captura de 3 dias atrás
INSERT INTO alerta (dataAlerta, descricao, visualizacao, fkComponente, fkDispositivo, fkLinha, fkCaptura) 
VALUES ('2024-10-21 10:20:00', 'Componente 6 está abaixo do limite de 5.0: valor atual é 3.9', 0, 6, 1, 1, 7);

INSERT INTO alerta (dataAlerta, descricao, visualizacao, fkComponente, fkDispositivo, fkLinha, fkCaptura) 
VALUES ('2024-10-21 13:50:00', 'Componente 8 está acima do limite de 50.0: valor atual é 65.4', 0, 8, 1, 1, 8);

-- Alerta para captura de 4 dias atrás
INSERT INTO alerta (dataAlerta, descricao, visualizacao, fkComponente, fkDispositivo, fkLinha, fkCaptura) 
VALUES ('2024-10-20 07:45:00', 'Componente 6 está acima do limite de 5.0: valor atual é 5.8', 0, 6, 2, 1, 9);

INSERT INTO alerta (dataAlerta, descricao, visualizacao, fkComponente, fkDispositivo, fkLinha, fkCaptura) 
VALUES ('2024-10-20 16:30:00', 'Componente 8 está abaixo do limite de 50.0: valor atual é 23.1', 0, 8, 2, 1, 10);

-- Alerta para captura de 5 dias atrás
INSERT INTO alerta (dataAlerta, descricao, visualizacao, fkComponente, fkDispositivo, fkLinha, fkCaptura) 
VALUES ('2024-10-19 09:00:00', 'Componente 6 está abaixo do limite de 5.0: valor atual é 4.2', 0, 6, 2, 1, 11);

INSERT INTO alerta (dataAlerta, descricao, visualizacao, fkComponente, fkDispositivo, fkLinha, fkCaptura) 
VALUES ('2024-10-19 15:20:00', 'Componente 8 está acima do limite de 50.0: valor atual é 78.3', 0, 8, 2, 1, 12);


INSERT INTO alerta (descricao, visualizacao, fkComponente, fkDispositivo, fkLinha, fkCaptura) 
VALUES
('Componente 1 (CPU) está acima do limite de 50.0: valor atual é 50.0', 0, 1, 1, 1, 13),
('Componente 2 (RAM) está acima do limite de 70.0: valor atual é 70.0', 0, 2, 1, 1, 14),
('Componente 1 (CPU) está acima do limite de 50.0: valor atual é 55.0', 0, 1, 1, 1, 15),
('Componente 2 (RAM) está acima do limite de 70.0: valor atual é 80.0', 0, 2, 1, 1, 16),
('Componente 1 (CPU) está acima do limite de 50.0: valor atual é 60.0', 0, 1, 1, 1, 17),
('Componente 2 (RAM) está acima do limite de 70.0: valor atual é 90.0', 0, 2, 1, 1, 18);