package model.article;

import connection.BddObject;

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

    public void setCode(String code) {
        this.code = code;
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

}