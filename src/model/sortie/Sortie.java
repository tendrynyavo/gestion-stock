package model.sortie;

import java.sql.Date;
import connection.BddObject;
import connection.annotation.ColumnName;
import model.article.Article;
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

    public void setDate(Date date) {
        this.date = date;
    }

    public void setQuantite(double quantite) {
        this.quantite = quantite;
    }

    public void setMagasin(Magasin magasin) {
        this.magasin = magasin;
    }

    public void setArticle(Article article) {
        this.article = article;
    }
    
    public Sortie() throws Exception {
        super();
        this.setTable("sortie");
        this.setPrimaryKeyName("id_sortie");
        this.setConnection("PostgreSQL");
    }

}
