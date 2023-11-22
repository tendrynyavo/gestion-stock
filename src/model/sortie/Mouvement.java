package model.sortie;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

import agregation.Liste;
import connection.BddObject;
import connection.annotation.ColumnName;
import model.article.Article;
import model.magasin.Magasin;

public class Mouvement extends BddObject {

    @ColumnName("date_entree")
    Date date;
    @ColumnName("prix_unitaire")
    Double prixUnitaire;
    Double quantite;
    Article article;
    Magasin magasin;
    Integer status;
    @ColumnName("id_entree")
    Mouvement source;

    public Mouvement getSource() {
        return source;
    }

    public void setSource(Mouvement source) {
        this.source = source;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public Integer getStatus() {
        return status;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public void setDate(String date) throws IllegalArgumentException {
        try {
            this.setDate(Date.valueOf(date));
        } catch (IllegalArgumentException e) {
            throw new IllegalArgumentException("Date invalide");
        }
    }

    public Double getPrixUnitaire() {
        return prixUnitaire;
    }

    public void setPrixUnitaire(Double prixUnitaire) throws IllegalArgumentException {
        if (prixUnitaire < 0) throw new IllegalArgumentException("Prix Unitaire invalide");
        this.prixUnitaire = prixUnitaire;
    }

    public Double getQuantite() {
        return quantite;
    }

    public void setQuantite(Double quantite) throws IllegalArgumentException {
        if (quantite < 0) throw new IllegalArgumentException("Quantite invalide");
        this.quantite = quantite;
    }

    public void setQuantite(String quantite) throws IllegalArgumentException {
        if (quantite == null || quantite.isEmpty()) throw new IllegalArgumentException("Quantite est vide");
        this.setQuantite(Double.parseDouble(quantite));
    }

    public double getMontant() {
        return this.getQuantite() * this.getPrixUnitaire();
    }

    public Article getArticle() {
        return article;
    }

    public void setArticle(Article article) {
        this.article = article;
    }

    public Magasin getMagasin() {
        return magasin;
    }

    public void setMagasin(Magasin magasin) {
        this.magasin = magasin;
    }

    public Mouvement() throws Exception {
        super();
        this.setTable("mouvement");
        this.setPrimaryKeyName("id_sortie");
        this.setSerial(false);
        this.setConnection("PostgreSQL");
    }

    public Mouvement(String quantite, String date) throws Exception {
        this();
        this.setQuantite(quantite);
        this.setDate(date);
    }

    public Mouvement(String id, Mouvement mouvement, double quantite) throws Exception {
        this();
        this.setId(id);
        this.setSource(mouvement);
        this.setQuantite(quantite);
    }

    public Mouvement[] decomposer() throws Exception {
        // Donnée de l'etat de stock actuelle par rapport article, magasin
        EtatMouvement[] etats = this.getMagasin().getEtatMouvements(this.getArticle(), this.getDate(), null);
        double somme = this.getQuantite(); // Quantite initial de la sortie
        double reste = Liste.sommer(etats, "getReste"); // Reste en stock de l'article
        // Vérification de la suffisance de l'article
        if (somme > reste)
            throw new IllegalArgumentException(String.format("Stock de %s insuffisant avec reste : %s %s", this.getArticle().getNom(), reste, this.getArticle().getUnite()));
        List<Mouvement> mouvements = new ArrayList<>();
        for (EtatMouvement etat : etats) {
            somme -= etat.getReste();
            if (somme <= 0) {
                mouvements.add(new Mouvement(this.getId(), etat, somme + etat.getReste()));
                return mouvements.toArray(new Mouvement[0]);
            }
            mouvements.add(new Mouvement(this.getId(), etat, etat.getReste()));
        }
        return mouvements.toArray(new Mouvement[0]);
    }
    
}