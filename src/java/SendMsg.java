/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Collection;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

/**
 *
 * @author hp
 */
//@WebServlet(urlPatterns = {"/SendMsg"})
//public class SendMsg extends HttpServlet {
//
//    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        response.setContentType("text/html;charset=UTF-8");
//        // Prevent back navigation
//        response.getWriter().println("<script type=\"text/javascript\">"
//                + "history.pushState(null, null, location.href);"
//                + "window.onpopstate = function () {history.go(1);};"
//                + "</script>");
//        try (PrintWriter out = response.getWriter()) {
//            out.println("<!DOCTYPE html>");
//            out.println("<html>");
//            out.println("<head>");
//            out.println("<title>Servlet SendMsg</title>");
//            out.println("</head>");
//            out.println("<body>");
//            out.println("<h1>Servlet SendMsg at " + request.getContextPath() + "</h1>");
//            out.println("</body>");
//            out.println("</html>");
//        }
//    }
//
//
//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        processRequest(request, response);
//    }
//
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        // Prevent back navigation
//        response.setContentType("text/html;charset=UTF-8");
//        response.getWriter().println("<script type=\"text/javascript\">"
//                + "history.pushState(null, null, location.href);"
//                + "window.onpopstate = function () {history.go(1);};"
//                + "</script>");
//        try {
//            response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
//            response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
//            response.setDateHeader("Expires", 0); // Proxies.
//            
//            HttpSession session = request.getSession(false);
//            String name = (session != null) ? (String) session.getAttribute("Name") : null;
//            String msg = request.getParameter("message");
//
//            // Trim and check for null or empty values
//            if (name == null || name.trim().isEmpty() || msg == null || msg.trim().isEmpty()) {
//                response.sendRedirect("ShowChat.jsp");
//                return;
//            }
//
//            Class.forName("com.mysql.jdbc.Driver");
//            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/groupchat", "root", "");
//
//            String message = "INSERT INTO chat(sender, message) VALUES(?, ?)";
//            PreparedStatement ps = con.prepareStatement(message);
//            ps.setString(1, name);
//            ps.setString(2, msg);
//            int rows = ps.executeUpdate();
//            if (rows > 0) {
//                response.sendRedirect("ShowChat.jsp");
//            } else {
//                response.getWriter().print("Error while sending message.");
//            }
//            con.close();
//        } catch (ClassNotFoundException | SQLException e) {
//            response.getWriter().println("Error: " + e.getMessage());
//        }
//    }
//
//    @Override
//    public String getServletInfo() {
//        return "Short description";
//    }
//
//}

@WebServlet(urlPatterns = {"/SendMsg"})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 1, // 1MB
    maxFileSize = 1024 * 1024 * 10,      // 10MB per file
    maxRequestSize = 1024 * 1024 * 50    // 50MB total
)
public class SendMsg extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);

        HttpSession session = request.getSession(false);
        String name = (session != null) ? (String) session.getAttribute("Name") : null;
        String msg = request.getParameter("message");

        StringBuilder imageUrls = new StringBuilder();

        // Get reply_to param
        String replyToStr = request.getParameter("reply_to");
        Integer replyTo = null;
        try { replyTo = (replyToStr != null && !replyToStr.isEmpty()) ? Integer.parseInt(replyToStr) : null; } catch(Exception ex) { replyTo = null; }

        // Get all file parts named "images"
        Collection<Part> parts = request.getParts();
        int imgCount = 0;
        for (Part part : parts) {
            if ("images".equals(part.getName()) && part.getSize() > 0) {
                String fileName = System.currentTimeMillis() + "_" + imgCount + "_" + Paths.get(part.getSubmittedFileName()).getFileName();
                String uploadDir = getServletContext().getRealPath("/") + "uploaded_images";
                File dir = new File(uploadDir);
                if (!dir.exists()) dir.mkdirs();

                File file = new File(dir, fileName);
                try (InputStream fileContent = part.getInputStream()) {
                    Files.copy(fileContent, file.toPath(), StandardCopyOption.REPLACE_EXISTING);
                }
                if (imageUrls.length() > 0) imageUrls.append(",");
                imageUrls.append("uploaded_images/").append(fileName);
                imgCount++;
            }
        }

        // Only allow send if message or at least one image present
        if ((name == null || name.trim().isEmpty()) || ((msg == null || msg.trim().isEmpty()) && imageUrls.length() == 0)) {
            response.sendRedirect("ShowChat.jsp");
            return;
        }

        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/groupchat", "root", "");
            String sql = "INSERT INTO chat(sender, message, image_url, reply_to) VALUES(?, ?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, name);
            ps.setString(2, msg);
            ps.setString(3, imageUrls.length() > 0 ? imageUrls.toString() : null);
            if (replyTo != null) ps.setInt(4, replyTo);
            else ps.setNull(4, java.sql.Types.INTEGER);

            int rows = ps.executeUpdate();
            if (rows > 0) {
                response.setStatus(HttpServletResponse.SC_OK);
            } else {
                response.getWriter().print("Error while sending message.");
            }
            con.close();
        } catch (Exception e) {
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}