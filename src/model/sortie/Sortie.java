package model.sortie;

import java.sql.Connection;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;
import connection.BddObject;
import connection.annotation.ColumnName;
import model.article.Article;
import model.entree.Entree;
import model.magasin.Magasin;

public class Sortie extends BddObject {

    @ColumnName("date_sortie")
    Date date;
    double quantite;
    Magasin magasin;
    Article article;

    public Date getDate() {
        return date;
    }

    public double getQuantite() {
        return quantite;
    }

    public Magasin getMagasin() {
        return magasin;
    }

    public Article getArticle() {
        return article;
    }

    public void setDate(Date date) throws IllegalArgumentException {
        if (date.before(new Date(System.currentTimeMillis()))) throw new IllegalArgumentException("Date est invalide");
        this.date = date;
    }

    public void setDate(String date) throws IllegalArgumentException {
        if (date.isEmpty()) throw new IllegalArgumentException("Date est vide");
        this.setDate(Date.valueOf(date));
    }

    public void setQuantite(double quantite) throws IllegalArgumentException {
        if (quantite < 0) throw new IllegalArgumentException("Quantite est invalide");
        this.quantite = quantite;
    }

    public void setQuantite(String quantite) throws IllegalArgumentException {
        if (quantite.isEmpty()) throw new IllegalArgumentException("Quantite est vide");
        this.setQuantite(Double.parseDouble(quantite));
    }

    public void setMagasin(Magasin magasin) {
        this.magasin = magasin;
    }

    public void setMagasin(String magasin) throws Exception {
        if (magasin.isEmpty()) throw new IllegalArgumentException("Aucun magasin choisi");
        this.setMagasin(new Magasin(magasin));
    }

    public void setArticle(Article article) {
        this.article = article;
    }
    
    public Sortie() throws Exception {
        super();
        this.setTable("sortie");
        this.setPrimaryKeyName("id_sortie");
        this.setPrefix("S");
        this.setCountPK(5);
        this.setFunctionPK("nextval('seq_sortie')");
        this.setConnection("PostgreSQL");
    }

    public Sortie(String date, Article article, String quantite, String magasin) throws Exception {
        this();
        this.setDate(date);
        this.setQuantite(quantite);
        this.setMagasin(magasin);
        this.setArticle(article);
    }

    public void sortir(String date, String article, String quantite, String magasin) throws Exception {
        Connection connection = null;
        try {
            connection = this.getConnection();
            Mouvement[] mouvements = sortir(date, article, quantite, magasin, connection);
            for (Mouvement mouvement : mouvements) {
                mouvement.insert(connection);
            }
            connection.commit();
        } catch (Exception e) {
            if (connection != null) {
                connection.rollback();
            }
            throw e;
        } finally {
            if (connection != null) {
                connection.close();
            }
        }
    }

    public Mouvement[] sortir(String date, String article, String quantite, String magasin, Connection connection) throws Exception {
        boolean connect = false;
        try {
            if (connection == null) {
                connection = this.getConnection(); 
                connect = true;
            }
            Article[] articles = (Article[]) new Article().setCode(article).findAll(connection, null);
            if (articles.length == 0) throw new IllegalArgumentException(String.format("Article avec le code %s n'existe pas", article));
            // Insertion de la sortie
            Sortie sortie = new Sortie(date, articles[0], quantite, magasin);
            sortie.insert(connection);
            String type = (articles[0].getType() == 1) ? "ASC" : "DESC"; // Type pour savoir FIFO ou LIFO
            
            // Donnée de l'etat de stock actuelle par rapport article, magasin
            Entree[] etats = (Entree[]) ((BddObject) new Entree().setTable(String.format("v_etat_stock WHERE date_entree <= '%s' AND id_article = '%s' AND id_magasin = '%s'", date, articles[0].getId(), magasin))).findAll(connection, "date_entree " + type);
            double somme = sortie.getQuantite();
            double reste = 0;
            List<Mouvement> mouvements = new ArrayList<>();
            for (Entree entree : etats) {
                somme -= entree.getQuantite(); reste += entree.getQuantite();
                if (somme <= 0) {
                    mouvements.add(new Mouvement(sortie.getId(), entree, somme + entree.getQuantite()));
                    return mouvements.toArray(new Mouvement[0]);
                }
                mouvements.add(new Mouvement(sortie.getId(), entree, entree.getQuantite()));
            }
            throw new IllegalArgumentException(String.format("Stock de %s insuffisant avec reste : %s %s", articles[0].getNom(), reste, articles[0].getUnite()));
        } finally {
            if (connect) {
                connection.commit(); connection.close();
            }
        }
    }

}