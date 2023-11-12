CREATE VIEW v_mouvement AS
SELECT date_sortie, s.id_article, m.quantite, s.id_magasin, m.id_entree, s.id_sortie
FROM mouvement m
    JOIN sortie s ON m.id_sortie = s.id_sortie;

CREATE OR REPLACE VIEW v_somme_mouvement as
SELECT id_entree, SUM(quantite) as quantite
FROM v_mouvement
GROUP BY id_entree;

CREATE OR REPLACE VIEW v_etat_stock AS
SELECT e.id_entree, e.date_entree, (e.quantite - COALESCE(m.quantite, 0)) as quantite, e.prix_unitaire, e.id_magasin, e.id_article
FROM v_somme_mouvement m
    RIGHT JOIN entree e ON m.id_entree = e.id_entree
WHERE (e.quantite - COALESCE(m.quantite, 0)) > 0;