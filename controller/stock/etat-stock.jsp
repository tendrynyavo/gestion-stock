<%@page contentType="application/json; charset=UTF-8"%>
<%@page import="com.google.gson.Gson" %>
<%@page import="com.google.gson.GsonBuilder" %>
<%@page import="model.etat.EtatStock" %>
<%

    EtatStock etatStock = EtatStock.getEtatStock("2021-12-02", "2021-12-04", "%RR%", "%M1%");
    Gson gson = new GsonBuilder().setPrettyPrinting().create();
    out.print(gson.toJson(etatStock));

%>