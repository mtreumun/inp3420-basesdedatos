-- TIPOS DE DATOS
-- **************

-- Tipo char y varchar

-- Crear tabla
CREATE TABLE vc (v VARCHAR(4), c CHAR(4));

-- Insertar valores;
INSERT INTO vc VALUES ('ab  ', 'ab  ');

-- Obtener valores
SELECT CONCAT('(', v, ')'), CONCAT('(', c, ')') FROM vc;


-- Tipos BINARY y VARBINARY
-- Crear tabla 
CREATE TABLE t (c BINARY(3));

-- Insertar valores;
INSERT INTO t SET c = 'a';	

-- Obtener valores
SELECT HEX(c), c = 'a', c = 'a\0\0' from t;


-- DDL MODELO EMPRESA
-- ******************

-- Validar que no exista tabla
SELECT * FROM departamento;
SELECT * FROM empleado;

-- tabla departamento
CREATE TABLE IF NOT EXISTS departamento (
  codigo_depto INT UNSIGNED NOT NULL COMMENT 'codigo de departamento. numero entero sin signo.',
  nombre VARCHAR(50) NOT NULL COMMENT 'nombre del departamento. texto libre',
  PRIMARY KEY (codigo_depto));

-- tabla empleado
CREATE TABLE IF NOT EXISTS empleado (
  rut INT UNSIGNED NOT NULL COMMENT 'clave primaria. Parte entera positiva del RUT',
  dv CHAR(1) NOT NULL COMMENT 'digito verificador del RUT de largo 1. Los valores posibles son 1, 2, 3, 4, 5, 6, 7, 8, 9, 0 y K (mayuscula)',
  nombre VARCHAR(100) NOT NULL COMMENT 'Nombre del paciente, no incluye los apellidos',
  apellidos VARCHAR(100) NOT NULL COMMENT 'Apellido paterno y materno del empleado',
  direccion VARCHAR(100) NOT NULL COMMENT 'direccion del empleado',
  fecha_nacimiento DATE NULL COMMENT 'año, mes y dia de nacimiento',
  codigo_depto INT UNSIGNED NOT NULL COMMENT 'clave foranea de la tabla departamento',
  PRIMARY KEY (rut),
  INDEX cf_empleado_departamento_idx (codigo_depto ASC),
  CONSTRAINT cf_empleado_departamento
    FOREIGN KEY (codigo_depto)
    REFERENCES departamento (codigo_depto)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- Validar que exista tabla
SELECT * FROM empleado;
SELECT * FROM departamento;
    
-- Agregamos el campo dirección y agregamos la restricción de “único” al campo nombre:    
ALTER TABLE departamento 
ADD COLUMN direccion VARCHAR(100) NULL DEFAULT NULL COMMENT 'Direccion del depto' AFTER nombre,
ADD UNIQUE INDEX nombre_UNIQUE (nombre ASC);   

-- Validar nuevo campo
SELECT * FROM departamento;

-- Agregar un campo descripcion
ALTER TABLE departamento
ADD COLUMN descripcion VARCHAR(100) NULL DEFAULT NULL COMMENT 'descripcion del depto' AFTER direccion;

-- Validar nuevo campo descripcion
SELECT * FROM departamento;

-- renombrar campos descripcion
ALTER TABLE departamento RENAME COLUMN descripcion TO descripcion_depto;

-- Validar nuevo campo descripcion
SELECT * FROM departamento;

-- borrar campo descripcion_depto
ALTER TABLE departamento DROP COLUMN descripcion_depto;

-- Validar borradro de campo descripcion_depto
SELECT * FROM departamento;

-- Borrar tablas
DROP TABLE empleado;
DROP TABLE departamento;


--codigo en clases

-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema empresa2
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Table departamento
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS departamento (
  codigo_depto INT UNSIGNED NOT NULL,
  nombre_depto VARCHAR(50) NOT NULL,
  PRIMARY KEY (codigo_depto))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table empleados
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS empleados (
  rut INT NOT NULL,
  dv CHAR(1) NOT NULL,
  nombre VARCHAR(100) NULL,
  apellidos VARCHAR(100) NULL,
  direccion VARCHAR(100) NULL,
  fecha_nacimiento DATE NULL,
  codigo_depto INT UNSIGNED NOT NULL,
  PRIMARY KEY (rut),
  INDEX cf_empleado_departamento_idx (codigo_depto ASC) VISIBLE,
  CONSTRAINT cf_empleado_departamento
    FOREIGN KEY (codigo_depto)
    REFERENCES departamento (codigo_depto)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
