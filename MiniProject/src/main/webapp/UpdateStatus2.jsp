<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>

<%
String requestId = request.getParameter("requestId");
String newStatus = request.getParameter("newStatus");
String approvalPerson = request.getParameter("approvalPerson"); 

Connection con = null;
PreparedStatement ps = null;

try {
    Class.forName("com.mysql.jdbc.Driver");
    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/miniproject", "root", "bhopal");
    String query = "UPDATE approval SET status=? , approval_person=?, approval_date=NOW() WHERE request_id=?";
    ps = con.prepareStatement(query);
    ps.setString(1, newStatus);
    ps.setString(2, approvalPerson);
    ps.setString(3, requestId);
   
    int rowsUpdated = ps.executeUpdate();
    if (rowsUpdated > 0) {
        response.setStatus(200); // OK status
    } else {
        response.setStatus(500); // Internal Server Error
    }
} catch (Exception e) {
    e.printStackTrace();
    response.setStatus(500); // Internal Server Error
} finally {
    try {
        if (ps != null) ps.close();
        if (con != null) con.close();
    } catch (SQLException e) {
        e.printStackTrace();
        response.setStatus(500); // Internal Server Error
    }
}
%>    