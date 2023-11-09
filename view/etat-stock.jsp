<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="model.etat.EtatStock" %>
<%@page import="model.etat.ListeStock" %>
<%

  EtatStock etatStock = EtatStock.getEtatStock("2021-12-02", "2021-12-03", "%R%", "%M1%");

%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="./assets/bootstrap/css/bootstrap.min.css">
    <title>Etat stock</title>
</head>
<body>
    <div class="container w-75 mt-5">
        <div class="d-flex">
            <h3>Date initial : <%=etatStock.getInitiale() %></h3>
            <h3 class="ms-5">Date finale : <%=etatStock.getFinale() %></h3>
        </div>
        <table class="table">
            <thead>
              <tr>
                <th scope="col">Code</th>
                <th scope="col">Article</th>
                <th scope="col">Unite</th>
                <th scope="col">Quantite Initiale</th>
                <th scope="col">Reste</th>
                <th scope="col">Prix Unitaire Moyenne Pondérée</th>
                <th scope="col">Magasin</th>
                <th scope="col">Montant</th>
              </tr>
            </thead>
            <tbody>
              <% for (ListeStock stock : etatStock.getStocks()) { %>
              <tr>
                <th scope="row"><%=stock.getCode() %></th>
                <td><%=stock.getNom() %></td>
                <td><%=stock.getUnite() %></td>
                <td><%=stock.getQuantite() %></td>
                <td><%=stock.getReste() %></td>
                <td><%=stock.getPrixUnitaireMoyennePonderee() %></td>
                <td><%=stock.getMagasin().getNom() %></td>
                <td><%=stock.getMontant() %></td>
              </tr>
              <% } %>
            </tbody>
          </table>
    </div>
</body>
</html>