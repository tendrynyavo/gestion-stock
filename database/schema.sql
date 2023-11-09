CREATE TABLE Article(
   id_article VARCHAR(50) ,
   code VARCHAR(50)  NOT NULL,
   nom VARCHAR(100) ,
   type INTEGER,
   unite VARCHAR(50)  NOT NULL,
   PRIMARY KEY(id_article),
   UNIQUE(code)
);

CREATE TABLE Magasin(
   id_magasin VARCHAR(50) ,
   nom VARCHAR(50)  NOT NULL,
   PRIMARY KEY(id_magasin)
);

CREATE TABLE Sortie(
   id_sortie VARCHAR(50) ,
   date_sortie DATE NOT NULL,
   quantite DOUBLE PRECISION NOT NULL,
   id_magasin VARCHAR(50) ,
   id_article VARCHAR(50) ,
   PRIMARY KEY(id_sortie),
   FOREIGN KEY(id_magasin) REFERENCES Magasin(id_magasin),
   FOREIGN KEY(id_article) REFERENCES Article(id_article)
);

CREATE SEQUENCE seq_sortie
    INCREMENT BY 1
    START WITH 1;


CREATE TABLE Entree(
   id_entree VARCHAR(50) ,
   date_entree DATE NOT NULL,
   quantite DOUBLE PRECISION NOT NULL,
   prix_unitaire DOUBLE PRECISION NOT NULL,
   id_magasin VARCHAR(50) ,
   id_article VARCHAR(50) ,
   PRIMARY KEY(id_entree),
   FOREIGN KEY(id_magasin) REFERENCES Magasin(id_magasin),
   FOREIGN KEY(id_article) REFERENCES Article(id_article)
);

CREATE TABLE Mouvement(
   id_sortie VARCHAR(50) ,
   id_entree VARCHAR(50) ,
   quantite DOUBLE PRECISION NOT NULL,
   PRIMARY KEY(id_sortie, id_entree),
   FOREIGN KEY(id_sortie) REFERENCES Sortie(id_sortie),
   FOREIGN KEY(id_entree) REFERENCES Entree(id_entree)
);