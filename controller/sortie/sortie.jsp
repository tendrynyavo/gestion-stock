<%@page import="model.sortie.Sortie" %>
<%

    new Sortie().sortir(request.getParameter("date"), request.getParameter("article"), request.getParameter("quantite"), request.getParameter("magasin"));
    response.sendRedirect("/gestion-stock/sortie.jsp");

%>