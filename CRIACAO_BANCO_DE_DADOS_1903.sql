
CREATE Database DB_ADOTAPET

USE DB_ADOTAPET
CREATE TABLE Usuario
(
	IdUsuario INT NOT NULL PRIMARY KEY IDENTITY (1,1),
	Nome VARCHAR (150) NOT NULL, 
	CPF  VARCHAR (12) NOT NULL,
	Email VARCHAR (150) NOT NULL,
	Senha VARCHAR (30) NOT NULL,
	Numero VARCHAR (20) NOT NULL,
	Endereco VARCHAR (200) NOT NULL,
	Municipio VARCHAR (150) NOT NULL,
	CEP VARCHAR(20) NOT NULL,
	UF VARCHAR(2) NOT NULL,
)

CREATE TABLE Organizacao
(
	IdOrg INT NOT NULL PRIMARY KEY IDENTITY (1,1),
	Nome VARCHAR (40) NOT NULL,
	CNPJ VARCHAR(15) NOT NULL,
	Email VARCHAR(150) NOT NULL,
	Senha VARCHAR (30) NOT NULL,
	Numero VARCHAR (100) NOT NULL, -- Para poder colocar mais de um número ex: 9999-9999;9998-8888
	Site VARCHAR (150),
	Instagram VARCHAR(150),
	Facebook VARCHAR(150),
	Vakaquinha VARCHAR(150), -- Caso queria contribuir com dinheiro será redirecionada para a Vakinha Online
	Endereco VARCHAR (200) NOT NULL,
	Municipio VARCHAR (150) NOT NULL,
	CEP VARCHAR(20) NOT NULL,
	UF VARCHAR(2) NOT NULL,
	CaixaPostal VARCHAR(50) NOT NULL,
)

CREATE TABLE Animal
(
	IdAnimal INT NOT NULL PRIMARY KEY IDENTITY (1,1),
	Nome VARCHAR (30) NOT NULL,
	Raca VARCHAR (50) NOT NULL,
	Porte VARCHAR (20) NOT NULL,
	Idade VARCHAR (20) NOT NULL,
	Sexo VARCHAR (25) NOT NULL,
	TipoAnimal char NOT NULL, -- Identificar se é gato ou cachorro
	Limitacoes VARCHAR(150) null, -- Caso o animal esteja em algum tratamento de doença, ou não goste crianças por exemplo
	Descricao VARCHAR(150) NOT NULL, -- Dados sobre o animal, comportamento e etc
	Castrado BIT NOT NULL,
	VacinacaoEmDia BIT NOT NULL,
	IdOrgResponsavel INT NOT NULL,
	FOREIGN KEY(IdOrgResponsavel) REFERENCES Organizacao(IdOrg)
)

CREATE TABLE AnimalFavorito
(
	IdFavorito INT NOT NULL PRIMARY KEY IDENTITY (1,1),
	IdAnimal INT NOT NULL,
	IdUsuario INT NOT NULL
)

CREATE TABLE InteresseAnimal -- Quando clicar no botão de tenho interesse, irá popular esta tabela e mandar um e-mail para ong responsável
(
	IdInteresse INT NOT NULL PRIMARY KEY IDENTITY (1,1),
	IdAnimal INT NOT NULL,
	IdUsuario INT NOT NULL,
	Mensagem VARCHAR(MAX) NOT NULL,
	DataSolicitacao DATE NOT NULL
)

CREATE TABLE FotosAnimal
(
	IdFoto INT NOT NULL PRIMARY KEY IDENTITY (1,1),
	IdAnimal INT NOT NULL,
	UrlFoto VARCHAR(MAX) NOT NULL,
	FOREIGN KEY (IdAnimal) REFERENCES Animal(IdAnimal),
)


CREATE TABLE Adocao
(
	IdAdocao INT NOT NULL PRIMARY KEY IDENTITY (1,1),
	DataAdocao DATE NOT NULL,
	IdAnimal INT NOT NULL,
	IdUsuario INT NOT NULL,
	FOREIGN KEY (IdAnimal) REFERENCES Animal(IdAnimal),
	FOREIGN KEY (IdUsuario) REFERENCES Usuario(IdUsuario)
)


CREATE TABLE FotosOrganizacao(
	IdFoto INT NOT NULL PRIMARY KEY IDENTITY (1,1),
	IdOrg INT NOT NULL,
	UrlFoto VARCHAR(MAX) NOT NULL,
	FOREIGN KEY(IdOrg) REFERENCES Organizacao(IdOrg)
)

CREATE TABLE Contribuicao -- Para contribuir com dinheiro
(
	IdContribuicao INT NOT NULL PRIMARY KEY IDENTITY (1,1),
	DataContribuicao DATE NOT NULL,
	TipoContribuicao VARCHAR(40),
	IdOrg INT NOT NULL,
	IdUsuario INT NOT NULL,
	FOREIGN KEY(IdOrg) REFERENCES Organizacao(IdOrg),
	FOREIGN KEY (IdUsuario) REFERENCES Usuario(IdUsuario)
)

CREATE TABLE Doacao 
(
	IdDoacao INT NOT NULL PRIMARY KEY IDENTITY (1,1),
	DataDoacao DATE NOT NULL,
	TipoDoacao VARCHAR(40),
	IdOrg INT NOT NULL,
	IdUsuario INT NOT NULL,
	FOREIGN KEY(IdOrg) REFERENCES Organizacao(IdOrg),
	FOREIGN KEY (IdUsuario) REFERENCES Usuario(IdUsuario)
)

-- ADICIONA COLUNA PARA RECUPERAÇÃO DE SENHA

  BEGIN 

  ALTER TABLE Usuario
  ADD  TokenRecuperacao VARCHAR(15) null;

  END

  BEGIN 

  ALTER TABLE Organizacao
  ADD  TokenRecuperacao VARCHAR(15) null;

  END

