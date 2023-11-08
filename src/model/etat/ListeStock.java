package model.etat;

import model.article.Article;
import model.magasin.Magasin;

public class ListeStock extends Article {

    double quantite;
    double reste;
    double montant;
    Magasin magasin;

    public double getQuantite() {
        return quantite;
    }

    public double getReste() {
        return reste;
    }

    public Magasin getMagasin() {
        return magasin;
    }

    public double getMontant() {
        return montant;
    }

    public void setQuantite(double quantite) {
        this.quantite = quantite;
    }

    public void setReste(double reste) {
        this.reste = reste;
    }

    public void setMontant(double montant) {
        this.montant = montant;
    }

    public void setMagasin(Magasin magasin) {
        this.magasin = magasin;
    }

    public ListeStock() throws Exception {
        super();
    }
    
}
