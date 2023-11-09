<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="model.magasin.Magasin" %>
<%

  Magasin[] magasins = (Magasin[]) new Magasin().findAll(null);

%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="./assets/bootstrap/css/bootstrap.min.css">
    <title>Sortie</title>
</head>
<style>
    body {
        background-color: rgb(237, 237, 237);
    }
</style>
<body>
    <form class="container w-50 p-5 shadow-sm rounded-3 mt-5 bg-white" action="./controller/sortie/sortie.jsp">
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
            <input type="text" class="form-control" name="quantite">
        </div>
        <div class="mb-3">
            <label for="magasin" class="form-label">Magasin</label>
            <select class="form-select" name="magasin">
                <option selected>Open this select menu</option>
                <% for (Magasin magasin : magasins) { %>
                <option value="<%=magasin.getId() %>"><%=magasin.getNom() %></option>
                <% } %>
            </select>
        </div>
        <button type="submit" class="btn btn-primary">Sortir</button>
    </form>
</body>
</html>