package model.article;

import java.sql.Connection;
import connection.BddObject;
import model.magasin.Magasin;
import model.sortie.Mouvement;

public class Article extends BddObject {

    String code;
    String nom;
    int type;
    String unite;
    
    public String getCode() {
        return code;
    }

    public String getNom() {
        return nom;
    }

    public int getType() {
        return type;
    }

    public String getUnite() {
        return unite;
    }

    public Article setCode(String code) throws IllegalArgumentException {
        if (code.isEmpty()) throw new IllegalArgumentException("Code est vide");
        this.code = code;
        return this;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public void setType(int type) {
        this.type = type;
    }

    public void setUnite(String unite) {
        this.unite = unite;
    }

    public Article() throws Exception {
        super();
        this.setTable("article");
        this.setPrimaryKeyName("id_article");
        this.setConnection("PostgreSQL");
    }

    // Fonction métier
    public static void sortir(String code, String quantite, String idMagasin, String date) throws Exception {
        try (Connection connection = BddObject.getPostgreSQL()) {
            Article article = Article.checkCodeExists(code, connection);
            if (article == null) throw new IllegalArgumentException("Article n'éxiste pas");
            Mouvement mouvement = article.sortir(quantite, idMagasin, date, connection);
            mouvement.insert(connection);
        }
    }

    public static Article checkCodeExists(String code, Connection connection) throws Exception {
        Article article = new Article();
        article.setCode(code);
        Article[] articles = (connection == null) ? (Article[]) article.findAll(null) : (Article[]) article.findAll(connection, null);
        return (articles.length > 0) ? articles[0] : null;
    }

    public Mouvement sortir(String quantite, String idMagasin, String date, Connection connection) throws Exception {
        boolean connect = false;
        Mouvement mouvement = new Mouvement(quantite, date);
        try {
            if (connection == null) { connection = this.getConnection(); connect = true; }
            Magasin magasin = Magasin.exists(idMagasin, connection); // Prendre le magasin
            if (magasin == null) throw new IllegalArgumentException("Magasin n'éxiste pas");
        
        /// Contrôle de date antérieure
            Mouvement lastMouvement = magasin.getLastMouvement(this, connection); // Prendre la dernière date de validation d'une sortie
            if (lastMouvement != null && lastMouvement.getDate().after(mouvement.getDate()))
                throw new IllegalArgumentException(String.format("Date antérieure non valide car dernier mouvement a été le %s", lastMouvement.getDate()));
        
        /// Contrôle de la quantite de stock
            double reste = magasin.getReste(this, mouvement.getDate(), connection); // Prendre le reste en stock de cette article
            if (mouvement.getQuantite() > reste)
                throw new IllegalArgumentException(String.format("Stock de %s insuffisant avec reste : %s %s", this.getNom(), reste, this.getUnite()));
            mouvement.setMagasin(magasin);
            mouvement.setArticle(this);
            mouvement.setStatus(0);
        } finally {
            if (connect) connection.close();
        }
        return mouvement;
    }

    public static void main(String[] args) throws Exception {
        Article article = new Article();
        article.setId("ART001");
        article.setCode("RR");
        article.setNom("Riz Rouge");
        article.setUnite("kg");
        Mouvement mouvement = article.sortir("450", "MG001", "2021-12-11", (Connection) null);
        System.out.println(mouvement.getQuantite() + " " + mouvement.getArticle().getNom() + " " + mouvement.getStatus() + " " + mouvement.getMagasin().getNom());
    }

}