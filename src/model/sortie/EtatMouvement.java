package model.sortie;

import java.sql.Date;
import connection.annotation.ColumnName;

public class EtatMouvement extends Mouvement {

    double sortie;
    @ColumnName("date_sortie")
    Date dateLastSortie;
    @ColumnName("date_validation")
    Date dateValidation;

    public Date getDateValidation() {
        return dateValidation;
    }

    public void setDateValidation(Date dateValidation) {
        this.dateValidation = dateValidation;
    }

    public double getSortie() {
        return sortie;
    }

    public void setSortie(double sortie) {
        this.sortie = sortie;
    }

    public Date getDateLastSortie() {
        return dateLastSortie;
    }

    public void setDateLastSortie(Date dateLastSortie) {
        this.dateLastSortie = dateLastSortie;
    }

    public double getReste() {
        return this.getQuantite() - this.getSortie();
    }

    public EtatMouvement() throws Exception {
        super();
        this.setTable("v_etat_stock");
        this.setPrimaryKeyName("id_entree");
    }
    
}
