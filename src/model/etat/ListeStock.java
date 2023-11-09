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

    public double getPrixUnitaireMoyennePonderee() {
        if (this.getReste() == 0) return 0;
        return this.getMontant() / this.getReste();
    }

    public ListeStock() throws Exception {
        super();
    }

    public ListeStock(String code, String nom, String unite, double initial, double reste, double montant, Magasin magasin) throws Exception {
        this.setCode(code);
        this.setNom(nom);
        this.setUnite(unite);
        this.setQuantite(initial);
        this.setReste(reste);
        this.setMontant(montant);
        this.setMagasin(magasin);
    }
    
}