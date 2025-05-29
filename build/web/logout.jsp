<%-- 
    Document   : logout
    Created on : 27 May 2025, 4:53:34 am
    Author     : hp
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
        <%
            session.invalidate(); // End the session

            // Prevent caching after logout
            response.setHeader("Cache-Control", "no-store, no-cache, must-revalidate");
            response.setHeader("Pragma", "no-cache");
            response.setHeader("Expires", "0");

            response.sendRedirect("index.jsp");
        %>
    </body>
</html>
