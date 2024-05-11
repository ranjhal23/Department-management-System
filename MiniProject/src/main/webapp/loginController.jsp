<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
String username = request.getParameter("username");
String password = request.getParameter("password");
String role = request.getParameter("role");
session.setAttribute("username", username);

Connection con = null;
PreparedStatement ps = null;
ResultSet rs = null;

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/miniproject", "root", "bhopal");
    String query = "SELECT * FROM loginT WHERE username=? AND password=? AND role=?";
    ps = con.prepareStatement(query);
    ps.setString(1, username);
    ps.setString(2, password);
    ps.setString(3, role);
    
    rs = ps.executeQuery();

    if (rs.next()) {
        String redirectPage = "";
        if (role.equals("legal")) {
            redirectPage = "legalInter.jsp";
        } else if (role.equals("management")) {
            redirectPage = "managementInter.jsp";
        } else if (role.equals("finance")) {
            redirectPage = "financeInter.jsp";
        }
        // Forward to the appropriate page
        response.sendRedirect(redirectPage);

    } else {
        // Invalid credentials, display error message
        out.println("Invalid credentials");
    }
} catch (Exception e) {
    // Handle exceptions
    e.printStackTrace();
} finally {
    // Close resources
    try {
        if (rs != null) rs.close();
        if (ps != null) ps.close();
        if (con != null) con.close();
    } catch (SQLException e) {
        e.printStackTrace();
    }
}
%>
