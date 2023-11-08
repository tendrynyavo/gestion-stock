<%@page import="model.sortie.Sortie" %>
<%

    new Sortie().sortie(request.getParameter("date"), request.getParameter("article"), request.getParameter("quantite"), request.getParameter("magasin"));

%>