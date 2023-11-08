package model.sortie;

import connection.BddObject;
import model.entree.Entree;

public class Mouvement extends BddObject {

    Sortie sortie;
    Entree entree;
    double quantite;

    public Sortie getSortie() {
        return sortie;
    }

    public Entree getEntree() {
        return entree;
    }

    public double getQuantite() {
        return quantite;
    }

    public Mouvement() throws Exception {
        super();
        this.setTable("mouvement");
        this.setConnection("PostgreSQL");
    }
    
}
