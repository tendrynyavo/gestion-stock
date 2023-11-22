package model.magasin;

import java.sql.Connection;
import java.sql.Date;
import agregation.Liste;
import connection.BddObject;
import model.article.Article;
import model.etat.EtatStock;
import model.etat.ListeStock;
import model.sortie.EtatMouvement;
import model.sortie.Mouvement;

public class Magasin extends BddObject {

    String nom;
    
    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }
    
    public Magasin() throws Exception {
        super();
        this.setTable("magasin");
        this.setPrimaryKeyName("id_magasin");
        this.setConnection("PostgreSQL");
    }

    public Magasin(String id) throws Exception {
        this();
        this.setId(id);
    }

    public static Magasin exists(String idMagasin, Connection connection) throws Exception {
        Magasin magasin = new Magasin(idMagasin);
        return (connection == null) ? (Magasin) magasin.getById() : (Magasin) magasin.getById(connection);
    }

    public Mouvement getLastMouvement(Article article, Connection connection) throws Exception {
        Mouvement mouvement = new Mouvement();
        mouvement.setTable("v_last_mouvement");
        mouvement.setArticle(article);
        mouvement.setMagasin(this);
        Mouvement[] mouvements = (connection == null) ? (Mouvement[]) mouvement.findAll(null) : (Mouvement[]) mouvement.findAll(connection, null);
        return (mouvements.length == 0) ? null : mouvements[0];
    }

    public EtatMouvement[] getEtatMouvements(Article article, Date date, Connection connection) throws Exception {
        String table = String.format("v_etat_stock WHERE date_entree <= '%s' AND code LIKE '%s' AND id_magasin = '%s'", date, article.getCode(), this.getId());
        String type = (article.getType() == 1) ? "ASC" : "DESC";
        BddObject object = ((BddObject) new EtatMouvement().setTable(table));
        return (connection == null) ? (EtatMouvement[]) object.findAll("date_entree, id_entree " + type) : (EtatMouvement[]) object.findAll(connection, "date_entree, id_entree " + type);
    }

    public double getReste(Article article, Date date, Connection connection) throws Exception {
        EtatMouvement[] etats = this.getEtatMouvements(article, date, connection);
        return Liste.sommer(etats, "getReste");
    }

}