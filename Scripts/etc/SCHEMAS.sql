CREATE DATABASE EXEMPLO
GO

USE EXEMPLO
GO

CREATE SCHEMA OLTP
GO

CREATE SCHEMA STG
GO

CREATE SCHEMA DWH
GO

CREATE TABLE OLTP.CLIENTE(
	ID INT,
	NOME VARCHAR(30)
)
GO