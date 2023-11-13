<%@page import="model.sortie.Sortie" %>
<%@page errorPage="../../sortie.jsp" %>
<%

    new Sortie().sortir(request.getParameter("date"), request.getParameter("article"), request.getParameter("quantite"), request.getParameter("magasin"));
    response.sendRedirect("/gestion-stock/choix-stock.jsp");

%>