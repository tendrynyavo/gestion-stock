CREATE SCHEMA IF NOT EXISTS "public";

CREATE SEQUENCE "public".categorie_idcategorie_seq AS integer START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE "public".critere_idcritere_seq AS integer START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE "public".diplome_iddiplome_seq AS integer START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE "public".filiere_idfiliere_seq AS integer START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE "public".sannonce START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE "public".sback START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE "public".sbesoin START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE "public".scandidature START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE "public".sexperience START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE "public".sposte START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE "public".squestion START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE "public".sreponse START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE "public".sservices START WITH 1 INCREMENT BY 1;

CREATE  TABLE "public".candidature ( 
	idcandidature        varchar(7)  NOT NULL  ,
	nom                  varchar(30)    ,
	prenom               varchar(30)    ,
	datecandidature      date    ,
	datenaissance        date    ,
	contact              varchar(100)    ,
	CONSTRAINT candidature_pkey PRIMARY KEY ( idcandidature )
 );

CREATE  TABLE "public".categorie ( 
	idcategorie          serial DEFAULT nextval('categorie_idcategorie_seq'::regclass) NOT NULL  ,
	nomcategorie         varchar(30)    ,
	CONSTRAINT categorie_pkey PRIMARY KEY ( idcategorie )
 );

CREATE  TABLE "public".critere ( 
	idcritere            serial DEFAULT nextval('critere_idcritere_seq'::regclass) NOT NULL  ,
	nomcritere           varchar(30)    ,
	idcategorie          integer    ,
	minimum              double precision    ,
	maximum              double precision    ,
	CONSTRAINT critere_pkey PRIMARY KEY ( idcritere )
 );

CREATE  TABLE "public".criterecandidature ( 
	idcandidature        varchar(7)    ,
	idcritere            integer    
 );

CREATE  TABLE "public".diplome ( 
	iddiplome            serial DEFAULT nextval('diplome_iddiplome_seq'::regclass) NOT NULL  ,
	libelle              varchar(20)    ,
	CONSTRAINT diplome_pkey PRIMARY KEY ( iddiplome )
 );

CREATE  TABLE "public".experience ( 
	idexperience         varchar(7)  NOT NULL  ,
	idcandidature        varchar(7)    ,
	certification        varchar(30)    ,
	entreprise           varchar(50)    ,
	nomposte             varchar(30)    ,
	idcritereduree       integer    ,
	CONSTRAINT experience_pkey PRIMARY KEY ( idexperience )
 );

CREATE  TABLE "public".filiere ( 
	idfiliere            serial DEFAULT nextval('filiere_idfiliere_seq'::regclass) NOT NULL  ,
	nomfiliere           varchar(30)    ,
	CONSTRAINT filiere_pkey PRIMARY KEY ( idfiliere )
 );

CREATE  TABLE "public".poste ( 
	idposte              varchar(7)  NOT NULL  ,
	nomposte             varchar(30)    ,
	salaire              double precision    ,
	CONSTRAINT poste_pkey PRIMARY KEY ( idposte )
 );

CREATE  TABLE "public".posteservices ( 
	idservices           varchar(7)    ,
	idposte              varchar(7)    
 );

CREATE  TABLE "public".qualification ( 
	qualification        varchar(50)    ,
	note                 double precision    
 );

CREATE  TABLE "public".question ( 
	idquestion           varchar(7)  NOT NULL  ,
	legende              varchar(100)    ,
	coefficient          integer    ,
	CONSTRAINT question_pkey PRIMARY KEY ( idquestion )
 );

CREATE  TABLE "public".reponse ( 
	idreponse            varchar(7)  NOT NULL  ,
	idquestion           varchar(7)    ,
	vraie                integer    ,
	legende              varchar(100)    ,
	CONSTRAINT reponse_pkey PRIMARY KEY ( idreponse )
 );

CREATE  TABLE "public".resultatcandidat ( 
	idcandidature        varchar(7)    ,
	idquestion           varchar(7)    ,
	idreponse            varchar(7)    
 );

CREATE  TABLE "public".services ( 
	idservices           varchar(7)  NOT NULL  ,
	nomservice           varchar(30)    ,
	CONSTRAINT services_pkey PRIMARY KEY ( idservices )
 );

CREATE  TABLE "public".adresse ( 
	adresse              varchar(30)    ,
	idcritereville       integer    
 );

CREATE  TABLE "public".back ( 
	idback               varchar(7)  NOT NULL  ,
	nomback              varchar(30)    ,
	mdp                  varchar(30)    ,
	idservices           varchar(7)    ,
	CONSTRAINT back_pkey PRIMARY KEY ( idback )
 );

CREATE  TABLE "public".besoin ( 
	idbesoin             varchar(7)  NOT NULL  ,
	idservices           varchar(7)    ,
	idposte              varchar(7)    ,
	volnec               double precision    ,
	volexec              double precision    ,
	"date"               date DEFAULT CURRENT_DATE   ,
	CONSTRAINT besoin_pkey PRIMARY KEY ( idbesoin )
 );

CREATE  TABLE "public".candidaturebesoin ( 
	idbesoin             varchar(7)    ,
	idcandidature        varchar(7)    
 );

CREATE  TABLE "public".etude ( 
	idcandidature        varchar(7)    ,
	iddiplome            integer    ,
	idfiliere            integer    ,
	diplome              varchar    
 );

CREATE  TABLE "public".annonce ( 
	idannonce            varchar(7)  NOT NULL  ,
	idbesoin             varchar(7)    ,
	dateannonce          date    ,
	CONSTRAINT annonce_pkey PRIMARY KEY ( idannonce )
 );

CREATE  TABLE "public".detailsannonce ( 
	idannonce            varchar(7)    ,
	note                 double precision    ,
	idcritere            integer    
 );

CREATE  TABLE "public".resultat ( 
	idannonce            varchar(7)    ,
	idcandidature        varchar(7)    
 );

CREATE  TABLE "public".test ( 
	idannonce            varchar(7)    ,
	idquestion           varchar(7)    
 );

ALTER TABLE "public".adresse ADD CONSTRAINT adresse_idcritereville_fkey FOREIGN KEY ( idcritereville ) REFERENCES "public".critere( idcritere );

ALTER TABLE "public".annonce ADD CONSTRAINT annonce_idbesoin_fkey FOREIGN KEY ( idbesoin ) REFERENCES "public".besoin( idbesoin );

ALTER TABLE "public".back ADD CONSTRAINT back_idservices_fkey FOREIGN KEY ( idservices ) REFERENCES "public".services( idservices );

ALTER TABLE "public".besoin ADD CONSTRAINT besoin_idservices_fkey FOREIGN KEY ( idservices ) REFERENCES "public".services( idservices );

ALTER TABLE "public".besoin ADD CONSTRAINT besoin_idposte_fkey FOREIGN KEY ( idposte ) REFERENCES "public".poste( idposte );

ALTER TABLE "public".candidaturebesoin ADD CONSTRAINT candidaturebesoin_idbesoin_fkey FOREIGN KEY ( idbesoin ) REFERENCES "public".besoin( idbesoin );

ALTER TABLE "public".candidaturebesoin ADD CONSTRAINT candidaturebesoin_idcandidature_fkey FOREIGN KEY ( idcandidature ) REFERENCES "public".candidature( idcandidature );

ALTER TABLE "public".critere ADD CONSTRAINT critere_idcategorie_fkey FOREIGN KEY ( idcategorie ) REFERENCES "public".categorie( idcategorie );

ALTER TABLE "public".criterecandidature ADD CONSTRAINT criterecandidature_idcandidature_fkey FOREIGN KEY ( idcandidature ) REFERENCES "public".candidature( idcandidature );

ALTER TABLE "public".criterecandidature ADD CONSTRAINT criterecandidature_idcritere_fkey FOREIGN KEY ( idcritere ) REFERENCES "public".critere( idcritere );

ALTER TABLE "public".detailsannonce ADD CONSTRAINT detailsannonce_idcritere_fkey FOREIGN KEY ( idcritere ) REFERENCES "public".critere( idcritere );

ALTER TABLE "public".detailsannonce ADD CONSTRAINT detailsannonce_idannonce_fkey FOREIGN KEY ( idannonce ) REFERENCES "public".annonce( idannonce );

ALTER TABLE "public".etude ADD CONSTRAINT etude_iddiplome_fkey FOREIGN KEY ( iddiplome ) REFERENCES "public".diplome( iddiplome );

ALTER TABLE "public".etude ADD CONSTRAINT etude_idfiliere_fkey FOREIGN KEY ( idfiliere ) REFERENCES "public".filiere( idfiliere );

ALTER TABLE "public".etude ADD CONSTRAINT etude_idcandidature_fkey FOREIGN KEY ( idcandidature ) REFERENCES "public".candidature( idcandidature );

ALTER TABLE "public".experience ADD CONSTRAINT experience_idcandidature_fkey FOREIGN KEY ( idcandidature ) REFERENCES "public".candidature( idcandidature );

ALTER TABLE "public".experience ADD CONSTRAINT experience_idcritereduree_fkey FOREIGN KEY ( idcritereduree ) REFERENCES "public".critere( idcritere );

ALTER TABLE "public".reponse ADD CONSTRAINT reponse_idquestion_fkey FOREIGN KEY ( idquestion ) REFERENCES "public".question( idquestion );

ALTER TABLE "public".resultat ADD CONSTRAINT resultat_idcandidature_fkey FOREIGN KEY ( idcandidature ) REFERENCES "public".candidature( idcandidature );

ALTER TABLE "public".resultat ADD CONSTRAINT resultat_idannonce_fkey FOREIGN KEY ( idannonce ) REFERENCES "public".annonce( idannonce );

ALTER TABLE "public".resultatcandidat ADD CONSTRAINT resultatcandidat_idquestion_fkey FOREIGN KEY ( idquestion ) REFERENCES "public".question( idquestion );

ALTER TABLE "public".resultatcandidat ADD CONSTRAINT resultatcandidat_idreponse_fkey FOREIGN KEY ( idreponse ) REFERENCES "public".reponse( idreponse );

ALTER TABLE "public".resultatcandidat ADD CONSTRAINT resultatcandidat_idcandidature_fkey FOREIGN KEY ( idcandidature ) REFERENCES "public".candidature( idcandidature );

ALTER TABLE "public".test ADD CONSTRAINT test_idannonce_fkey FOREIGN KEY ( idannonce ) REFERENCES "public".annonce( idannonce );

ALTER TABLE "public".test ADD CONSTRAINT test_idquestion_fkey FOREIGN KEY ( idquestion ) REFERENCES "public".question( idquestion );

CREATE OR REPLACE VIEW "public".backservice AS SELECT back.idback,     back.nomback,     back.mdp,     back.idservices,     services.nomservice    FROM (back      JOIN services ON (((back.idservices)::text = (services.idservices)::text)))
 SELECT back.idback,
    back.nomback,
    back.mdp,
    back.idservices,
    services.nomservice
   FROM (back
     JOIN services ON (((back.idservices)::text = (services.idservices)::text)));

CREATE OR REPLACE VIEW "public".criterecategorie AS SELECT critere.idcritere,     critere.nomcritere,     critere.idcategorie,     critere.minimum,     critere.maximum,     categorie.nomcategorie    FROM (critere      JOIN categorie ON ((categorie.idcategorie = critere.idcategorie)))
 SELECT critere.idcritere,
    critere.nomcritere,
    critere.idcategorie,
    critere.minimum,
    critere.maximum,
    categorie.nomcategorie
   FROM (critere
     JOIN categorie ON ((categorie.idcategorie = critere.idcategorie)));

CREATE OR REPLACE VIEW "public".detailscritere AS SELECT detailsannonce.idannonce,     detailsannonce.note,     detailsannonce.idcritere,     critere.nomcritere,     categorie.nomcategorie    FROM ((detailsannonce      JOIN critere ON ((critere.idcritere = detailsannonce.idcritere)))      JOIN categorie ON ((categorie.idcategorie = critere.idcategorie)))
 SELECT detailsannonce.idannonce,
    detailsannonce.note,
    detailsannonce.idcritere,
    critere.nomcritere,
    categorie.nomcategorie
   FROM ((detailsannonce
     JOIN critere ON ((critere.idcritere = detailsannonce.idcritere)))
     JOIN categorie ON ((categorie.idcategorie = critere.idcategorie)));

CREATE OR REPLACE VIEW "public".vanswer AS SELECT rc.idcandidature,     rc.idquestion,     rc.idreponse,     r.vraie,     r.legende    FROM (resultatcandidat rc      JOIN reponse r ON (((rc.idreponse)::text = (r.idreponse)::text)))
 SELECT rc.idcandidature,
    rc.idquestion,
    rc.idreponse,
    r.vraie,
    r.legende
   FROM (resultatcandidat rc
     JOIN reponse r ON (((rc.idreponse)::text = (r.idreponse)::text)));

CREATE OR REPLACE VIEW "public".vbesoin AS SELECT besoin.idbesoin,     besoin.idservices,     besoin.idposte,     besoin.volnec,     besoin.volexec,     services.nomservice,     poste.nomposte,     poste.salaire    FROM ((besoin      JOIN services ON (((services.idservices)::text = (besoin.idservices)::text)))      JOIN poste ON (((poste.idposte)::text = (besoin.idposte)::text)))
 SELECT besoin.idbesoin,
    besoin.idservices,
    besoin.idposte,
    besoin.volnec,
    besoin.volexec,
    services.nomservice,
    poste.nomposte,
    poste.salaire
   FROM ((besoin
     JOIN services ON (((services.idservices)::text = (besoin.idservices)::text)))
     JOIN poste ON (((poste.idposte)::text = (besoin.idposte)::text)));

CREATE OR REPLACE VIEW "public".vcriterecandidature AS SELECT criterecandidature.idcandidature,     criterecandidature.idcritere,     critere.nomcritere,     categorie.idcategorie,     categorie.nomcategorie    FROM ((criterecandidature      JOIN critere ON ((critere.idcritere = criterecandidature.idcritere)))      JOIN categorie ON ((categorie.idcategorie = critere.idcategorie)))
 SELECT criterecandidature.idcandidature,
    criterecandidature.idcritere,
    critere.nomcritere,
    categorie.idcategorie,
    categorie.nomcategorie
   FROM ((criterecandidature
     JOIN critere ON ((critere.idcritere = criterecandidature.idcritere)))
     JOIN categorie ON ((categorie.idcategorie = critere.idcategorie)));

CREATE OR REPLACE VIEW "public".vexperience AS SELECT experience.idexperience,     experience.idcandidature,     experience.certification,     experience.entreprise,     experience.nomposte,     experience.idcritereduree,     critere.nomcritere,     critere.minimum,     critere.maximum    FROM (experience      JOIN critere ON ((critere.idcritere = experience.idcritereduree)))
 SELECT experience.idexperience,
    experience.idcandidature,
    experience.certification,
    experience.entreprise,
    experience.nomposte,
    experience.idcritereduree,
    critere.nomcritere,
    critere.minimum,
    critere.maximum
   FROM (experience
     JOIN critere ON ((critere.idcritere = experience.idcritereduree)));

CREATE OR REPLACE VIEW "public".vgeneralnote AS SELECT cc.idcandidature,     dc.idannonce,     dc.note,     cr.idcritere,     cr.nomcritere,     cr.idcategorie,     cr.minimum,     cr.maximum    FROM ((criterecandidature cc      JOIN detailscritere dc ON ((cc.idcritere = dc.idcritere)))      JOIN critere cr ON ((cr.idcritere = dc.idcritere)))
 SELECT cc.idcandidature,
    dc.idannonce,
    dc.note,
    cr.idcritere,
    cr.nomcritere,
    cr.idcategorie,
    cr.minimum,
    cr.maximum
   FROM ((criterecandidature cc
     JOIN detailscritere dc ON ((cc.idcritere = dc.idcritere)))
     JOIN critere cr ON ((cr.idcritere = dc.idcritere)));

CREATE OR REPLACE VIEW "public".vpost AS SELECT p.idposte,     p.nomposte,     p.salaire,     ps.idservices    FROM (posteservices ps      JOIN poste p ON (((ps.idposte)::text = (p.idposte)::text)))
 SELECT p.idposte,
    p.nomposte,
    p.salaire,
    ps.idservices
   FROM (posteservices ps
     JOIN poste p ON (((ps.idposte)::text = (p.idposte)::text)));

CREATE OR REPLACE VIEW "public".vtest AS SELECT q.idquestion,     q.legende,     q.coefficient,     t.idannonce    FROM (test t      JOIN question q ON (((t.idquestion)::text = (q.idquestion)::text)))
 SELECT q.idquestion,
    q.legende,
    q.coefficient,
    t.idannonce
   FROM (test t
     JOIN question q ON (((t.idquestion)::text = (q.idquestion)::text)));

INSERT INTO "public".candidature( idcandidature, nom, prenom, datecandidature, datenaissance, contact ) VALUES ( 'CAN1', 'Doe', 'John', '2023-10-01', null, null);
INSERT INTO "public".candidature( idcandidature, nom, prenom, datecandidature, datenaissance, contact ) VALUES ( 'CAN2', 'Smith', 'Alice', '2023-10-02', null, null);
INSERT INTO "public".candidature( idcandidature, nom, prenom, datecandidature, datenaissance, contact ) VALUES ( 'CAN3', 'Brown', 'Bob', '2023-10-03', null, null);
INSERT INTO "public".candidature( idcandidature, nom, prenom, datecandidature, datenaissance, contact ) VALUES ( 'CAN4', 'Johnson', 'Emily', '2023-10-04', null, null);
INSERT INTO "public".candidature( idcandidature, nom, prenom, datecandidature, datenaissance, contact ) VALUES ( 'CAN0005', 'Tendry', 'Ny Avo', null, '2023-03-09', '0341909360');
INSERT INTO "public".candidature( idcandidature, nom, prenom, datecandidature, datenaissance, contact ) VALUES ( 'CAN0008', 'Aina', 'Avotra', null, '2023-10-03', '0341909360');
INSERT INTO "public".categorie( idcategorie, nomcategorie ) VALUES ( 1, 'sexe');
INSERT INTO "public".categorie( idcategorie, nomcategorie ) VALUES ( 2, 'nationalite');
INSERT INTO "public".categorie( idcategorie, nomcategorie ) VALUES ( 3, 'situation_matrimoniale');
INSERT INTO "public".categorie( idcategorie, nomcategorie ) VALUES ( 4, 'ville');
INSERT INTO "public".categorie( idcategorie, nomcategorie ) VALUES ( 5, 'diplome');
INSERT INTO "public".categorie( idcategorie, nomcategorie ) VALUES ( 6, 'filiere');
INSERT INTO "public".categorie( idcategorie, nomcategorie ) VALUES ( 7, 'experience');
INSERT INTO "public".categorie( idcategorie, nomcategorie ) VALUES ( 8, 'salaire');
INSERT INTO "public".critere( idcritere, nomcritere, idcategorie, minimum, maximum ) VALUES ( 1, 'Homme', 1, null, null);
INSERT INTO "public".critere( idcritere, nomcritere, idcategorie, minimum, maximum ) VALUES ( 2, 'Femme', 1, null, null);
INSERT INTO "public".critere( idcritere, nomcritere, idcategorie, minimum, maximum ) VALUES ( 3, 'Autre', 1, null, null);
INSERT INTO "public".critere( idcritere, nomcritere, idcategorie, minimum, maximum ) VALUES ( 4, 'Malagasy', 2, null, null);
INSERT INTO "public".critere( idcritere, nomcritere, idcategorie, minimum, maximum ) VALUES ( 5, 'Fran‡aise', 2, null, null);
INSERT INTO "public".critere( idcritere, nomcritere, idcategorie, minimum, maximum ) VALUES ( 6, 'Anglaise', 2, null, null);
INSERT INTO "public".critere( idcritere, nomcritere, idcategorie, minimum, maximum ) VALUES ( 7, 'Mari‚(e)', 3, null, null);
INSERT INTO "public".critere( idcritere, nomcritere, idcategorie, minimum, maximum ) VALUES ( 8, 'C‚libataire', 3, null, null);
INSERT INTO "public".critere( idcritere, nomcritere, idcategorie, minimum, maximum ) VALUES ( 9, 'Divorc‚(e)', 3, null, null);
INSERT INTO "public".critere( idcritere, nomcritere, idcategorie, minimum, maximum ) VALUES ( 10, 'Veuf/Veuve', 3, null, null);
INSERT INTO "public".critere( idcritere, nomcritere, idcategorie, minimum, maximum ) VALUES ( 11, 'S‚par‚(e)', 3, null, null);
INSERT INTO "public".critere( idcritere, nomcritere, idcategorie, minimum, maximum ) VALUES ( 12, 'Autres', 3, null, null);
INSERT INTO "public".critere( idcritere, nomcritere, idcategorie, minimum, maximum ) VALUES ( 13, 'Toamasina', 4, null, null);
INSERT INTO "public".critere( idcritere, nomcritere, idcategorie, minimum, maximum ) VALUES ( 14, 'Antananarivo', 4, null, null);
INSERT INTO "public".critere( idcritere, nomcritere, idcategorie, minimum, maximum ) VALUES ( 15, 'Mahajanga', 4, null, null);
INSERT INTO "public".critere( idcritere, nomcritere, idcategorie, minimum, maximum ) VALUES ( 16, 'Antsiranana', 4, null, null);
INSERT INTO "public".critere( idcritere, nomcritere, idcategorie, minimum, maximum ) VALUES ( 17, 'Toliara', 4, null, null);
INSERT INTO "public".critere( idcritere, nomcritere, idcategorie, minimum, maximum ) VALUES ( 18, 'Fianarantsoa', 4, null, null);
INSERT INTO "public".critere( idcritere, nomcritere, idcategorie, minimum, maximum ) VALUES ( 19, 'Licence', 5, null, null);
INSERT INTO "public".critere( idcritere, nomcritere, idcategorie, minimum, maximum ) VALUES ( 20, 'Master', 5, null, null);
INSERT INTO "public".critere( idcritere, nomcritere, idcategorie, minimum, maximum ) VALUES ( 21, 'Doctorat', 5, null, null);
INSERT INTO "public".critere( idcritere, nomcritere, idcategorie, minimum, maximum ) VALUES ( 22, 'Informatique', 6, null, null);
INSERT INTO "public".critere( idcritere, nomcritere, idcategorie, minimum, maximum ) VALUES ( 23, 'G‚nie civil', 6, null, null);
INSERT INTO "public".critere( idcritere, nomcritere, idcategorie, minimum, maximum ) VALUES ( 24, 'Sciences ‚conomiques', 6, null, null);
INSERT INTO "public".critere( idcritere, nomcritere, idcategorie, minimum, maximum ) VALUES ( 25, 'M‚decine', 6, null, null);
INSERT INTO "public".critere( idcritere, nomcritere, idcategorie, minimum, maximum ) VALUES ( 26, 'Arts et Lettres', 6, null, null);
INSERT INTO "public".critere( idcritere, nomcritere, idcategorie, minimum, maximum ) VALUES ( 27, 'Sciences politiques', 6, null, null);
INSERT INTO "public".critere( idcritere, nomcritere, idcategorie, minimum, maximum ) VALUES ( 28, 'Chimie', 6, null, null);
INSERT INTO "public".critere( idcritere, nomcritere, idcategorie, minimum, maximum ) VALUES ( 29, 'Biologie', 6, null, null);
INSERT INTO "public".critere( idcritere, nomcritere, idcategorie, minimum, maximum ) VALUES ( 30, 'Math‚matiques', 6, null, null);
INSERT INTO "public".critere( idcritere, nomcritere, idcategorie, minimum, maximum ) VALUES ( 31, 'Moins de 1 an', 7, 0.0, 1.0);
INSERT INTO "public".critere( idcritere, nomcritere, idcategorie, minimum, maximum ) VALUES ( 32, 'Entre 1 et 3 ans', 7, 1.0, 3.0);
INSERT INTO "public".critere( idcritere, nomcritere, idcategorie, minimum, maximum ) VALUES ( 33, 'Entre 3 et 5 ans', 7, 3.0, 5.0);
INSERT INTO "public".critere( idcritere, nomcritere, idcategorie, minimum, maximum ) VALUES ( 34, 'Entre 5 et 7 ans', 7, 5.0, 7.0);
INSERT INTO "public".critere( idcritere, nomcritere, idcategorie, minimum, maximum ) VALUES ( 35, 'Plus de 7 ans', 7, 7.0, 10000.0);
INSERT INTO "public".critere( idcritere, nomcritere, idcategorie, minimum, maximum ) VALUES ( 36, 'Moins de 100 000 Ar ', 8, 0.0, 100000.0);
INSERT INTO "public".critere( idcritere, nomcritere, idcategorie, minimum, maximum ) VALUES ( 37, 'Entre 100 000 et 300 000 Ar', 8, 100000.0, 300000.0);
INSERT INTO "public".critere( idcritere, nomcritere, idcategorie, minimum, maximum ) VALUES ( 38, 'Entre 300 000 Ar et 500 000 Ar', 8, 300000.0, 500000.0);
INSERT INTO "public".critere( idcritere, nomcritere, idcategorie, minimum, maximum ) VALUES ( 39, 'Entre 500 000 et 700 000 Ar', 8, 500000.0, 700000.0);
INSERT INTO "public".critere( idcritere, nomcritere, idcategorie, minimum, maximum ) VALUES ( 40, 'Entre 700 000 et 1 000 000 Ar', 8, 700000.0, 1000000.0);
INSERT INTO "public".critere( idcritere, nomcritere, idcategorie, minimum, maximum ) VALUES ( 41, 'Plus de 1 000 000 Ar', 8, 1000000.0, 1.0E7);
INSERT INTO "public".criterecandidature( idcandidature, idcritere ) VALUES ( 'CAN0008', 1);
INSERT INTO "public".criterecandidature( idcandidature, idcritere ) VALUES ( 'CAN0008', 4);
INSERT INTO "public".criterecandidature( idcandidature, idcritere ) VALUES ( 'CAN0008', 7);
INSERT INTO "public".criterecandidature( idcandidature, idcritere ) VALUES ( 'CAN0008', 13);
INSERT INTO "public".criterecandidature( idcandidature, idcritere ) VALUES ( 'CAN0008', 19);
INSERT INTO "public".criterecandidature( idcandidature, idcritere ) VALUES ( 'CAN0008', 22);
INSERT INTO "public".criterecandidature( idcandidature, idcritere ) VALUES ( 'CAN0008', 31);
INSERT INTO "public".criterecandidature( idcandidature, idcritere ) VALUES ( 'CAN0008', 36);
INSERT INTO "public".diplome( iddiplome, libelle ) VALUES ( 1, 'Licence');
INSERT INTO "public".diplome( iddiplome, libelle ) VALUES ( 2, 'Master');
INSERT INTO "public".diplome( iddiplome, libelle ) VALUES ( 3, 'Doctorat');
INSERT INTO "public".experience( idexperience, idcandidature, certification, entreprise, nomposte, idcritereduree ) VALUES ( 'EXP1', 'CAN1', 'C:\Users\Antsa\Desktop\pic.png', 'STAR', 'D‚veloppeur Web', 32);
INSERT INTO "public".experience( idexperience, idcandidature, certification, entreprise, nomposte, idcritereduree ) VALUES ( 'EXP2', 'CAN2', 'C:\Users\Antsa\Desktop\pic.png', 'Socobis', 'Ing‚nieur Civil', 31);
INSERT INTO "public".experience( idexperience, idcandidature, certification, entreprise, nomposte, idcritereduree ) VALUES ( 'EXP3', 'CAN3', 'C:\Users\Antsa\Desktop\pic.png', 'JB', 'Analyste Financier', 32);
INSERT INTO "public".filiere( idfiliere, nomfiliere ) VALUES ( 1, 'Informatique');
INSERT INTO "public".filiere( idfiliere, nomfiliere ) VALUES ( 2, 'G‚nie civil');
INSERT INTO "public".filiere( idfiliere, nomfiliere ) VALUES ( 3, 'Sciences ‚conomiques');
INSERT INTO "public".filiere( idfiliere, nomfiliere ) VALUES ( 4, 'M‚decine');
INSERT INTO "public".filiere( idfiliere, nomfiliere ) VALUES ( 5, 'Arts et Lettres');
INSERT INTO "public".filiere( idfiliere, nomfiliere ) VALUES ( 6, 'Sciences politiques');
INSERT INTO "public".filiere( idfiliere, nomfiliere ) VALUES ( 7, 'Chimie');
INSERT INTO "public".filiere( idfiliere, nomfiliere ) VALUES ( 8, 'Biologie');
INSERT INTO "public".filiere( idfiliere, nomfiliere ) VALUES ( 9, 'Math‚matiques');
INSERT INTO "public".poste( idposte, nomposte, salaire ) VALUES ( 'PST1', 'Ing‚nieur logiciel', 60000.0);
INSERT INTO "public".poste( idposte, nomposte, salaire ) VALUES ( 'PST2', 'Analyste financier', 75000.0);
INSERT INTO "public".poste( idposte, nomposte, salaire ) VALUES ( 'PST3', 'Responsable des ventes', 80000.0);
INSERT INTO "public".poste( idposte, nomposte, salaire ) VALUES ( 'PST4', 'D‚veloppeur web', 55000.0);
INSERT INTO "public".poste( idposte, nomposte, salaire ) VALUES ( 'PST5', 'Chef de projet', 70000.0);
INSERT INTO "public".poste( idposte, nomposte, salaire ) VALUES ( 'PST6', 'Comptable', 60000.0);
INSERT INTO "public".posteservices( idservices, idposte ) VALUES ( 'SRV3', 'PST1');
INSERT INTO "public".posteservices( idservices, idposte ) VALUES ( 'SRV3', 'PST4');
INSERT INTO "public".posteservices( idservices, idposte ) VALUES ( 'SRV3', 'PST5');
INSERT INTO "public".posteservices( idservices, idposte ) VALUES ( 'SRV4', 'PST3');
INSERT INTO "public".posteservices( idservices, idposte ) VALUES ( 'SRV2', 'PST6');
INSERT INTO "public".posteservices( idservices, idposte ) VALUES ( 'SRV5', 'PST2');
INSERT INTO "public".qualification( qualification, note ) VALUES ( 'TrŠs recommand‚', 100.0);
INSERT INTO "public".qualification( qualification, note ) VALUES ( 'Recommand‚', 75.0);
INSERT INTO "public".qualification( qualification, note ) VALUES ( 'Admissible', 50.0);
INSERT INTO "public".qualification( qualification, note ) VALUES ( 'Tol‚r‚', 25.0);
INSERT INTO "public".qualification( qualification, note ) VALUES ( 'Passable', 1.0);
INSERT INTO "public".question( idquestion, legende, coefficient ) VALUES ( 'QST1', 'Quelle est votre exp‚rience en programmation Java?', 5);
INSERT INTO "public".question( idquestion, legende, coefficient ) VALUES ( 'QST2', 'Pouvez-vous d‚crire un projet sur lequel vous avez travaill‚ r‚cemment?', 4);
INSERT INTO "public".question( idquestion, legende, coefficient ) VALUES ( 'QST3', 'Comment g‚rez-vous les d‚lais serr‚s?', 3);
INSERT INTO "public".question( idquestion, legende, coefficient ) VALUES ( 'QST4', 'Quelles sont vos comp‚tences en gestion de projet?', 4);
INSERT INTO "public".question( idquestion, legende, coefficient ) VALUES ( 'QST5', 'Comment abordez-vous la r‚solution de problŠmes complexes?', 5);
INSERT INTO "public".reponse( idreponse, idquestion, vraie, legende ) VALUES ( 'RPS1', 'QST1', 1, 'J''ai plus de 5 ans d''exp‚rience en programmation Java.');
INSERT INTO "public".reponse( idreponse, idquestion, vraie, legende ) VALUES ( 'RPS2', 'QST1', 0, 'J''ai une exp‚rience limit‚e en programmation Java.');
INSERT INTO "public".reponse( idreponse, idquestion, vraie, legende ) VALUES ( 'RPS3', 'QST2', 1, 'J''ai r‚cemment travaill‚ sur un projet de d‚veloppement web pour une grande entreprise.');
INSERT INTO "public".reponse( idreponse, idquestion, vraie, legende ) VALUES ( 'RPS4', 'QST2', 0, 'Je n''ai pas d''exp‚rience r‚cente en d‚veloppement web.');
INSERT INTO "public".reponse( idreponse, idquestion, vraie, legende ) VALUES ( 'RPS5', 'QST3', 0, 'Je trouve difficile de g‚rer des d‚lais serr‚s.');
INSERT INTO "public".reponse( idreponse, idquestion, vraie, legende ) VALUES ( 'RPS6', 'QST3', 1, 'Ca va je m''en sors pas mal');
INSERT INTO "public".reponse( idreponse, idquestion, vraie, legende ) VALUES ( 'RPS7', 'QST3', 1, 'Je suis habitu‚ … travailler sous pression et … respecter les d‚lais.');
INSERT INTO "public".reponse( idreponse, idquestion, vraie, legende ) VALUES ( 'RPS8', 'QST4', 1, 'J''ai une certification en gestion de projet et j''ai g‚r‚ plusieurs projets avec succŠs.');
INSERT INTO "public".reponse( idreponse, idquestion, vraie, legende ) VALUES ( 'RPS9', 'QST4', 0, 'Je n''ai pas de certification en gestion de projet.');
INSERT INTO "public".reponse( idreponse, idquestion, vraie, legende ) VALUES ( 'RPS10', 'QST4', 0, 'Je sais gerer mˆme sans certification');
INSERT INTO "public".reponse( idreponse, idquestion, vraie, legende ) VALUES ( 'RPS11', 'QST5', 0, 'Je pr‚fŠre laisser le problŠme se r‚soudre de lui-mˆme.');
INSERT INTO "public".reponse( idreponse, idquestion, vraie, legende ) VALUES ( 'RPS12', 'QST5', 0, 'Je deteste ‡a');
INSERT INTO "public".resultatcandidat( idcandidature, idquestion, idreponse ) VALUES ( 'CAN1', 'QST1', 'RPS1');
INSERT INTO "public".resultatcandidat( idcandidature, idquestion, idreponse ) VALUES ( 'CAN1', 'QST2', 'RPS3');
INSERT INTO "public".resultatcandidat( idcandidature, idquestion, idreponse ) VALUES ( 'CAN1', 'QST3', 'RPS6');
INSERT INTO "public".resultatcandidat( idcandidature, idquestion, idreponse ) VALUES ( 'CAN1', 'QST3', 'RPS7');
INSERT INTO "public".resultatcandidat( idcandidature, idquestion, idreponse ) VALUES ( 'CAN1', 'QST4', 'RPS10');
INSERT INTO "public".resultatcandidat( idcandidature, idquestion, idreponse ) VALUES ( 'CAN1', 'QST5', 'RPS12');
INSERT INTO "public".resultatcandidat( idcandidature, idquestion, idreponse ) VALUES ( 'CAN2', 'QST1', 'RPS2');
INSERT INTO "public".resultatcandidat( idcandidature, idquestion, idreponse ) VALUES ( 'CAN2', 'QST2', 'RPS4');
INSERT INTO "public".resultatcandidat( idcandidature, idquestion, idreponse ) VALUES ( 'CAN2', 'QST3', 'RPS5');
INSERT INTO "public".resultatcandidat( idcandidature, idquestion, idreponse ) VALUES ( 'CAN2', 'QST4', 'RPS10');
INSERT INTO "public".resultatcandidat( idcandidature, idquestion, idreponse ) VALUES ( 'CAN2', 'QST5', 'RPS11');
INSERT INTO "public".services( idservices, nomservice ) VALUES ( 'SRV1', 'Ressources Humaines');
INSERT INTO "public".services( idservices, nomservice ) VALUES ( 'SRV2', 'Comptabilit‚');
INSERT INTO "public".services( idservices, nomservice ) VALUES ( 'SRV3', 'D‚veloppement Informatique');
INSERT INTO "public".services( idservices, nomservice ) VALUES ( 'SRV4', 'Ventes');
INSERT INTO "public".services( idservices, nomservice ) VALUES ( 'SRV5', 'Marketing');
INSERT INTO "public".services( idservices, nomservice ) VALUES ( 'SRV6', 'Support Technique');
INSERT INTO "public".adresse( adresse, idcritereville ) VALUES ( 'Avenue Andrianampoinimerina', 14);
INSERT INTO "public".adresse( adresse, idcritereville ) VALUES ( 'Avenue de l''Ind‚pendance ', 15);
INSERT INTO "public".adresse( adresse, idcritereville ) VALUES ( 'Boulevard de Tokyo', 16);
INSERT INTO "public".adresse( adresse, idcritereville ) VALUES ( 'Rue Emile Ralambo', 17);
INSERT INTO "public".adresse( adresse, idcritereville ) VALUES ( 'Rue Docteur Ramanantsirava', 18);
INSERT INTO "public".back( idback, nomback, mdp, idservices ) VALUES ( 'ADM1', 'Admin1', 'motdepasse1', 'SRV1');
INSERT INTO "public".back( idback, nomback, mdp, idservices ) VALUES ( 'ADM2', 'Admin2', 'motdepasse2', 'SRV2');
INSERT INTO "public".back( idback, nomback, mdp, idservices ) VALUES ( 'ADM3', 'Admin3', 'motdepasse3', 'SRV3');
INSERT INTO "public".besoin( idbesoin, idservices, idposte, volnec, volexec, "date" ) VALUES ( 'BES1', 'SRV1', 'PST1', 5.0, 3.0, '2023-10-20');
INSERT INTO "public".besoin( idbesoin, idservices, idposte, volnec, volexec, "date" ) VALUES ( 'BES2', 'SRV2', 'PST2', 3.0, 2.0, '2023-10-20');
INSERT INTO "public".besoin( idbesoin, idservices, idposte, volnec, volexec, "date" ) VALUES ( 'BES3', 'SRV3', 'PST3', 7.0, 5.0, '2023-10-20');
INSERT INTO "public".besoin( idbesoin, idservices, idposte, volnec, volexec, "date" ) VALUES ( 'BES4', 'SRV1', 'PST4', 4.0, 4.0, '2023-10-20');
INSERT INTO "public".besoin( idbesoin, idservices, idposte, volnec, volexec, "date" ) VALUES ( 'BES5', 'SRV2', 'PST5', 6.0, 6.0, '2023-10-20');
INSERT INTO "public".besoin( idbesoin, idservices, idposte, volnec, volexec, "date" ) VALUES ( 'BES0029', 'SRV1', 'PST1', 200.0, 50.0, '2023-10-20');
INSERT INTO "public".besoin( idbesoin, idservices, idposte, volnec, volexec, "date" ) VALUES ( 'BES0030', 'SRV1', 'PST3', 200.0, 50.0, '2023-10-20');
INSERT INTO "public".besoin( idbesoin, idservices, idposte, volnec, volexec, "date" ) VALUES ( 'BES0031', null, null, null, null, '2023-10-20');
INSERT INTO "public".besoin( idbesoin, idservices, idposte, volnec, volexec, "date" ) VALUES ( 'BES0033', 'SRV1', 'PST1', 54.0, null, '2023-10-20');
INSERT INTO "public".besoin( idbesoin, idservices, idposte, volnec, volexec, "date" ) VALUES ( 'BES0034', 'SRV1', 'PST1', 68.0, null, '2023-10-20');
INSERT INTO "public".besoin( idbesoin, idservices, idposte, volnec, volexec, "date" ) VALUES ( 'BES0035', 'SRV1', 'PST1', 50.0, null, '2023-10-20');
INSERT INTO "public".besoin( idbesoin, idservices, idposte, volnec, volexec, "date" ) VALUES ( 'BES0036', 'SRV1', 'PST1', 80.0, null, '2023-10-20');
INSERT INTO "public".besoin( idbesoin, idservices, idposte, volnec, volexec, "date" ) VALUES ( 'BES0037', 'SRV1', 'PST3', 50.0, null, '2023-10-21');
INSERT INTO "public".candidaturebesoin( idbesoin, idcandidature ) VALUES ( 'BES1', 'CAN1');
INSERT INTO "public".candidaturebesoin( idbesoin, idcandidature ) VALUES ( 'BES1', 'CAN2');
INSERT INTO "public".candidaturebesoin( idbesoin, idcandidature ) VALUES ( 'BES2', 'CAN3');
INSERT INTO "public".candidaturebesoin( idbesoin, idcandidature ) VALUES ( 'BES3', 'CAN4');
INSERT INTO "public".etude( idcandidature, iddiplome, idfiliere, diplome ) VALUES ( 'CAN1', 1, 3, '/bureau/certificat.pdf');
INSERT INTO "public".etude( idcandidature, iddiplome, idfiliere, diplome ) VALUES ( 'CAN1', 2, 4, '/bureau/certificat.pdf');
INSERT INTO "public".etude( idcandidature, iddiplome, idfiliere, diplome ) VALUES ( 'CAN2', 1, 5, '/bureau/certificat.pdf');
INSERT INTO "public".etude( idcandidature, iddiplome, idfiliere, diplome ) VALUES ( 'CAN3', 1, 6, '/bureau/certificat.pdf');
INSERT INTO "public".etude( idcandidature, iddiplome, idfiliere, diplome ) VALUES ( 'CAN4', 3, 2, '/bureau/certificat.pdf');
INSERT INTO "public".annonce( idannonce, idbesoin, dateannonce ) VALUES ( 'ANN1', 'BES1', '2023-10-01');
INSERT INTO "public".annonce( idannonce, idbesoin, dateannonce ) VALUES ( 'ANN2', 'BES2', '2023-10-02');
INSERT INTO "public".annonce( idannonce, idbesoin, dateannonce ) VALUES ( 'ANN3', 'BES3', '2023-10-03');
INSERT INTO "public".annonce( idannonce, idbesoin, dateannonce ) VALUES ( 'ANN4', 'BES4', '2023-10-04');
INSERT INTO "public".annonce( idannonce, idbesoin, dateannonce ) VALUES ( 'ANN5', 'BES5', '2023-10-05');
INSERT INTO "public".detailsannonce( idannonce, note, idcritere ) VALUES ( 'ANN1', 15.0, 19);
INSERT INTO "public".detailsannonce( idannonce, note, idcritere ) VALUES ( 'ANN1', 10.0, 20);
INSERT INTO "public".detailsannonce( idannonce, note, idcritere ) VALUES ( 'ANN1', 5.0, 21);
INSERT INTO "public".resultat( idannonce, idcandidature ) VALUES ( 'ANN1', 'CAN1');
INSERT INTO "public".resultat( idannonce, idcandidature ) VALUES ( 'ANN2', 'CAN2');
INSERT INTO "public".test( idannonce, idquestion ) VALUES ( 'ANN1', 'QST1');
INSERT INTO "public".test( idannonce, idquestion ) VALUES ( 'ANN1', 'QST2');
INSERT INTO "public".test( idannonce, idquestion ) VALUES ( 'ANN2', 'QST3');
INSERT INTO "public".test( idannonce, idquestion ) VALUES ( 'ANN2', 'QST4');
INSERT INTO "public".test( idannonce, idquestion ) VALUES ( 'ANN2', 'QST5');