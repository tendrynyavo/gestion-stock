package model.etat;

import java.sql.Connection;
import java.sql.Date;
import agregation.Liste;
import connection.BddObject;
import model.article.Article;
import model.entree.Entree;
import model.magasin.Magasin;
import model.sortie.Mouvement;

public class EtatStock {

    Date initiale;
    Date finale;
    ListeStock[] stocks;

    public Date getFinale() {
        return finale;
    }

    public Date getInitiale() {
        return initiale;
    }

    public ListeStock[] getStocks() {
        return stocks;
    }

    public void setFinale(Date finale) {
        this.finale = finale;
    }

    public void setFinale(String finale) throws IllegalArgumentException {
        if (finale.isEmpty()) throw new IllegalArgumentException("Date finale est vide");
        this.setFinale(Date.valueOf(finale));
    }

    public void setInitiale(Date initiale) {
        this.initiale = initiale;
    }
    
    public void setInitiale(String initiale) {
        if (initiale.isEmpty()) throw new IllegalArgumentException("Date initiale est vide");
        this.setInitiale(Date.valueOf(initiale));
    }

    public void setStocks(ListeStock[] stocks) {
        this.stocks = stocks;
    }

    public double getTotalMontant() {
        try {
            return Liste.sommer(this.getStocks(), "getMontant");
        } catch (Exception e) {
            e.printStackTrace();
            return 0.0;
        }
    }

    public String getMontantFormat() {
        return ListeStock.format(getTotalMontant());
    }

    public EtatStock(String initiale, String finale) {
        this.setInitiale(initiale);
        this.setFinale(finale);
    }

    public static EtatStock getEtatStock(String initiale, String finale, String code, String codeMagasin) throws Exception {
        ListeStock[] stocks = null;
        EtatStock etatStock = new EtatStock(initiale, finale);
        try (Connection connection = BddObject.getPostgreSQL()) {
        /// Donnée
            Article[] articles = (Article[]) ((BddObject) new Article().setTable(String.format("article WHERE code LIKE '%s'", code))).findAll(connection, null);
            Magasin[] magasins = (Magasin[]) ((BddObject) new Magasin().setTable(String.format("magasin WHERE nom LIKE '%s'", codeMagasin))).findAll(connection, null);
            Entree[] entreesInitiale = (Entree[]) ((BddObject) new Entree().setTable(String.format("entree WHERE date_entree <= '%s'", initiale))).findAll(connection, null);
            Mouvement[] sortiesInitiale = (Mouvement[]) new Mouvement().getData(String.format("SELECT id_entree, SUM(quantite) as quantite FROM v_mouvement WHERE date_sortie <= '%s' GROUP BY id_entree", initiale), connection);
            Entree[] entrees = (Entree[]) ((BddObject) new Entree().setTable(String.format("entree WHERE date_entree <= '%s'", finale))).findAll(connection, null);
            Mouvement[] sorties = (Mouvement[]) new Mouvement().getData(String.format("SELECT id_entree, SUM(quantite) as quantite FROM v_mouvement WHERE date_sortie <= '%s' GROUP BY id_entree", finale), connection);
            
        /// Traitement
            int p = 0;
            stocks = new ListeStock[articles.length * magasins.length];
            for (int i = 0; i < articles.length; i++) {
                for (int j = 0; j < magasins.length; j++) {
                    
                    // Calcule quantite du stock initiale
                    double initial = 0;
                    for (Entree entree : entreesInitiale) {
                        if (entree.getMagasin().equals(magasins[j]) && entree.getArticle().equals(articles[i])) {
                            double k = entree.getQuantite();
                            for (Mouvement sortie : sortiesInitiale) {
                                if (sortie.getEntree().equals(entree)) {
                                    k = entree.getQuantite() - sortie.getQuantite();
                                }
                            }
                            initial += k;
                        }
                    }

                    // Calcule reste, montant du stock finale
                    double reste = 0;
                    double montant = 0;
                    for (Entree entree : entrees) {
                        if (entree.getMagasin().equals(magasins[j]) && entree.getArticle().equals(articles[i])) {
                            double k = entree.getQuantite();
                            double s = entree.getQuantite() * entree.getPrixUnitaire();
                            for (Mouvement sortie : sorties) {
                                if (sortie.getEntree().equals(entree)) {
                                    k = entree.getQuantite() - sortie.getQuantite();
                                    s = k * entree.getPrixUnitaire();
                                }
                            }
                            reste += k;
                            montant += s;
                        }
                    }
                    stocks[p] = new ListeStock(articles[i].getCode(), articles[i].getNom(), articles[i].getUnite(), initial, reste, montant, magasins[j]);
                    p++;
                }
            }
        }
        
    /// Resultat
        Liste.sort(stocks, "getMontant", "DESC");
        etatStock.setStocks(stocks);
        return etatStock;
    }
    
}