package model.etat;

import java.sql.Connection;
import java.sql.Date;

import com.google.gson.Gson;

import agregation.Liste;
import connection.BddObject;
import model.article.Article;
import model.magasin.Magasin;
import model.sortie.EtatMouvement;
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

    public EtatStock(Date initiale, Date finale) {
        this.setInitiale(initiale);
        this.setFinale(finale);
    }

    public static EtatStock getEtatStock(String initiale, String finale, String code, String codeMagasin) throws Exception {
        EtatStock etatStock = new EtatStock(initiale, finale);
        try (Connection connection = BddObject.getPostgreSQL()) {
            /// Donnée
            Article[] articles = (Article[]) ((BddObject) new Article().setTable(String.format("article WHERE code LIKE '%s'", code))).findAll(connection, null);
            Magasin[] magasins = (Magasin[]) ((BddObject) new Magasin().setTable(String.format("magasin WHERE nom LIKE '%s'", codeMagasin))).findAll(connection, null);
            ListeStock[] stocks = new ListeStock[articles.length * magasins.length];
            int p = 0;
            for (int i = 0; i < articles.length; i++) {
                for (int j = 0; j < magasins.length; j++) {
                    double initial = magasins[j].getReste(articles[i], Date.valueOf(initiale), connection);
                    EtatMouvement[] etats = magasins[j].getEtatMouvements(articles[i], Date.valueOf(finale), connection);
                    stocks[p] = new ListeStock(articles[i].getCode(), articles[i].getNom(), articles[i].getUnite(), initial, Liste.sommer(etats, "getReste"), Liste.sommer(etats, "getMontant"), magasins[j]);
                    p++;
                }
            }
            etatStock.setStocks(stocks);
        }
        return etatStock;
    }

    public static void main(String[] args) throws Exception {
        EtatStock etatStock = EtatStock.getEtatStock("2021-12-02", "2021-12-03", "%", "%");
        System.out.println(new Gson().toJson(etatStock));
    }
    
}