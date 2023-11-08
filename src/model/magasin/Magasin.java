package model.magasin;

import connection.BddObject;

public class Magasin extends BddObject {

    String nom;
    
    public Magasin() throws Exception {
        super();
        this.setTable("magasin");
        this.setPrimaryKeyName("id_magasin");
        this.setConnection("PostgreSQL");
    }

}
