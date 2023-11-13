<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="model.magasin.Magasin" %>
<%@page isErrorPage="true" %>
<%

  Magasin[] magasins = (Magasin[]) new Magasin().findAll(null);
  String error = (exception == null) ? "" : exception.getMessage();

%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/gestion-stock/assets/bootstrap/css/bootstrap.min.css">
    <title>Sortie</title>
</head>
<style>
    body {
        background-color: rgb(237, 237, 237);
    }
</style>
<body>
    <form class="container w-50 p-5 shadow-sm rounded-3 mt-5 bg-white" action="/gestion-stock/controller/sortie/sortie.jsp" method="POST">
        <div class="mb-3">
            <label for="date" class="form-label">Date</label>
            <input type="date" class="form-control" name="date">
        </div>
        <div class="mb-3">
            <label for="article" class="form-label">Article</label>
            <input type="text" class="form-control" name="article">
        </div>
        <div class="mb-3">
            <label for="quantite" class="form-label">Quantite</label>
            <input type="number" class="form-control" name="quantite">
        </div>
        <div class="mb-3">
            <label for="magasin" class="form-label">Magasin</label>
            <select class="form-select" name="magasin">
                <% for (Magasin magasin : magasins) { %>
                <option value="<%=magasin.getId() %>"><%=magasin.getNom() %></option>
                <% } %>
            </select>
        </div>
        <h4 class="my-3 text-danger"><%=error %></h4>
        <button type="submit" class="btn btn-outline-info px-5">Sortir</button>
    </form>
</body>
</html>