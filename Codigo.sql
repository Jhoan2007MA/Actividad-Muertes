-- Crear base de datos
CREATE DATABASE IF NOT EXISTS sistema_mortalidad;
USE sistema_mortalidad;

-- Tabla DEPARTAMENTO
CREATE TABLE DEPARTAMENTO (
    Codigo_DANE_Departamento VARCHAR(10) PRIMARY KEY,
    Departamento VARCHAR(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tabla MUNICIPIO
CREATE TABLE MUNICIPIO (
    Codigo_DANE_Municipio VARCHAR(10) PRIMARY KEY,
    Codigo_DANE_Departamento VARCHAR(10) NOT NULL,
    Municipio VARCHAR(100) NOT NULL,
    FOREIGN KEY (Codigo_DANE_Departamento) REFERENCES DEPARTAMENTO(Codigo_DANE_Departamento)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tabla PERSONA_VICTIMA
CREATE TABLE PERSONA_VICTIMA (
    ID_Victima INT PRIMARY KEY AUTO_INCREMENT,
    Sexo VARCHAR(20),
    Identidad_de_Genero VARCHAR(50),
    Transgenero VARCHAR(10),
    Orientacion_Sexual VARCHAR(50),
    Estado_Civil VARCHAR(30),
    Escolaridad VARCHAR(50),
    Grupo_Mayor_Menor VARCHAR(20),
    Grupo_de_edad_quinquenal VARCHAR(20),
    Grupo_Edad_Judicial VARCHAR(20),
    Ciclo_Vital VARCHAR(30),
    Pertenencia_Etnica VARCHAR(50),
    Ancestor_Racial VARCHAR(50),
    Pertenencia_Grupal VARCHAR(50),
    Pueblo_Indigena VARCHAR(100),
    Pais_de_Nacimiento VARCHAR(100)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tabla DIAGNOSTICO_TOPOGRAFICO
CREATE TABLE DIAGNOSTICO_TOPOGRAFICO (
    ID_Diagnostico_Topografico INT PRIMARY KEY AUTO_INCREMENT,
    Diagnostico_Topografico VARCHAR(200) NOT NULL,
    Mecanismo_Causal VARCHAR(200),
    Manera_de_Muerte VARCHAR(100)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tabla CAUSA_MUERTE
CREATE TABLE CAUSA_MUERTE (
    ID_Causa INT PRIMARY KEY AUTO_INCREMENT,
    ID_Diagnostico_Topografico INT NOT NULL,
    FOREIGN KEY (ID_Diagnostico_Topografico) REFERENCES DIAGNOSTICO_TOPOGRAFICO(ID_Diagnostico_Topografico)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tabla MUERTE_ACCIDENTAL
CREATE TABLE MUERTE_ACCIDENTAL (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    ID_Victima INT NOT NULL,
    ID_Causa INT NOT NULL,
    Codigo_DANE_Municipio VARCHAR(10) NOT NULL,
    Anio_del_hecho VARCHAR(4),
    Mes_del_hecho VARCHAR(20),
    Dia_del_hecho VARCHAR(2),
    Diagnostico_Lesion VARCHAR(200),
    Circunstancia_del_Hecho VARCHAR(200),
    Actividad_Durante_el_Hecho VARCHAR(200),
    Escenario_del_Hecho VARCHAR(100),
    Rango_Hora VARCHAR(50),
    Zona_del_Hecho VARCHAR(50),
    Localidad_del_Hecho VARCHAR(100),
    FOREIGN KEY (ID_Victima) REFERENCES PERSONA_VICTIMA(ID_Victima)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY (ID_Causa) REFERENCES CAUSA_MUERTE(ID_Causa)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY (Codigo_DANE_Municipio) REFERENCES MUNICIPIO(Codigo_DANE_Municipio)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Índices para mejorar el rendimiento
CREATE INDEX idx_municipio_departamento ON MUNICIPIO(Codigo_DANE_Departamento);
CREATE INDEX idx_muerte_victima ON MUERTE_ACCIDENTAL(ID_Victima);
CREATE INDEX idx_muerte_causa ON MUERTE_ACCIDENTAL(ID_Causa);
CREATE INDEX idx_muerte_municipio ON MUERTE_ACCIDENTAL(Codigo_DANE_Municipio);
CREATE INDEX idx_causa_diagnostico ON CAUSA_MUERTE(ID_Diagnostico_Topografico);