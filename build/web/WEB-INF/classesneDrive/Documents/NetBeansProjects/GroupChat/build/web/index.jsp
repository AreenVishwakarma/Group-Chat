<%-- 
    Document   : Login
    Created on : 22 May 2025, 4:51:53 pm
    Author     : hp
--%>

<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script type="text/javascript">
            history.pushState(null, null, window.location.href);
            window.onpopstate = function () {
                history.pushState(null, null, window.location.href);
            };
        </script>
        <style>
            .form-box {
              max-width: 300px;
              background: #f1f7fe;
              overflow: hidden;
              border-radius: 16px;
              color: #010101;
            }

            .form {
              position: relative;
              display: flex;
              flex-direction: column;
              padding: 32px 24px 24px;
              gap: 16px;
              text-align: center;
            }

            /*Form text*/
            .title {
              font-weight: bold;
              font-size: 1.6rem;
            }

            .subtitle {
              font-size: 1rem;
              color: #666;
            }

            /*Inputs box*/
            .form-container {
              overflow: hidden;
              border-radius: 8px;
              background-color: #fff;
              margin: 1rem 0 .5rem;
              width: 100%;
            }

            .input {
              background: none;
              border: 0;
              outline: 0;
              height: 40px;
              width: 100%;
              border-bottom: 1px solid #eee;
              font-size: .9rem;
              padding: 8px 15px;
            }

            .form-section {
              padding: 16px;
              font-size: .85rem;
              background-color: #e0ecfb;
              box-shadow: rgb(0 0 0 / 8%) 0 -1px;
            }

            .form-section a {
              font-weight: bold;
              color: #0066ff;
              transition: color .3s ease;
            }

            .form-section a:hover {
              color: #005ce6;
              text-decoration: underline;
            }

            /*Button*/
            .form button {
              background-color: #0066ff;
              color: #fff;
              border: 0;
              border-radius: 24px;
              padding: 10px 16px;
              font-size: 1rem;
              font-weight: 600;
              cursor: pointer;
              transition: background-color .3s ease;
            }

            .form button:hover {
              background-color: #005ce6;
            }
        </style>
    </head>
    <body>
        <%
            response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
            response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
            response.setDateHeader("Expires", 0); // Proxies.
        %>
<!--        <h1>Login</h1>
        <form method="post">
            Name: <input type="text" name="uname">
            Email <input type="email" name="email">
            Password <input type="password" name="password">
            <input type="submit" value="submit">
        </form>-->
    <center>        
        <div class="form-box">
        <form class="form" method="post">
            <span class="title">Sign up</span>
            <span class="subtitle">Create a free account with your email.</span>
            <div class="form-container">
                <input type="text" class="input" placeholder="Full Name" name="uname">
                <input type="email" class="input" placeholder="Email" name="email">
                <input type="password" class="input" placeholder="Password" name="password">
            </div>
            <button>Sign up</button>
        </form>
        <div class="form-section">
          <p>Have an account? <a href="">Log in</a> </p>
        </div>
        </div>
    </center>
        <%
    if("POST".equalsIgnoreCase(request.getMethod())){
        try {
            String name = request.getParameter("uname");
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/groupchat", "root", "");

            // Step 1: Check if user already exists by email
            String checkQuery = "SELECT * FROM login WHERE email = ? and password = ?";
            PreparedStatement checkPs = con.prepareStatement(checkQuery);
            checkPs.setString(1, email);
            checkPs.setString(2, password);
            ResultSet rs = checkPs.executeQuery();

            HttpSession sess = request.getSession();
            sess.setAttribute("Email", email);
            sess.setAttribute("Name", name);

            if(rs.next()) {
                // User exists, redirect without inserting
                response.sendRedirect("ShowChat.jsp");
            } else {
//                // User does not exist, insert new user
//                String mess = "INSERT INTO login(name, email, password) VALUES(?, ?, ?)";
//                PreparedStatement ps = con.prepareStatement(mess);
//                ps.setString(1, name);
//                ps.setString(2, email);
//                ps.setString(3, password);
//
//                int rows = ps.executeUpdate();
//                if (rows > 0) {
//                    response.sendRedirect("ShowChat.jsp");
//                } else {
//                    response.getWriter().print("Error while registering user.");
//                }
//                ps.close();
                String checkQuery1 = "SELECT * FROM login WHERE email = ?";
                PreparedStatement checkPs1 = con.prepareStatement(checkQuery1);
                checkPs1.setString(1, email);
                ResultSet rs1 = checkPs1.executeQuery();
                if(rs1.next()){
                    response.getWriter().print("email already exist");
                }else{
                    String mess = "INSERT INTO login(name, email, password) VALUES(?, ?, ?)";
                    PreparedStatement ps = con.prepareStatement(mess);
                    ps.setString(1, name);
                    ps.setString(2, email);
                    ps.setString(3, password);
    
                    int rows = ps.executeUpdate();
                    if (rows > 0) {
                        response.sendRedirect("ShowChat.jsp");
                    } else {
                        response.getWriter().print("Error while registering user.");
                    }
                    ps.close();
                }
            }
            rs.close();
            checkPs.close();
            con.close();
        } catch (Exception e) {
            response.getWriter().write("Error: " + e.getMessage());
        }
    }
%>
    </body>
</html>