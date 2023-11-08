package model.etat;

import java.sql.Date;

public class EtatStock {

    Date initial;
    Date finale;
    ListeStock[] stocks;

    public Date getFinale() {
        return finale;
    }

    public Date getInitial() {
        return initial;
    }

    public ListeStock[] getStocks() {
        return stocks;
    }

    public void setFinale(Date finale) {
        this.finale = finale;
    }

    public void setInitial(Date initial) {
        this.initial = initial;
    }

    public void setStocks(ListeStock[] stocks) {
        this.stocks = stocks;
    }

    public EtatStock getEtatStock(String initiale, String finale, String article, String magasin) {
        return null;
    }
    
}
