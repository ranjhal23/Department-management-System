<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>

<%
String title = request.getParameter("title");
String description = request.getParameter("description");
String raised_by = request.getParameter("username");
String request_date = request.getParameter("request_date");
String request_dept= request.getParameter("request_dept");

Connection con = null;
PreparedStatement ps = null;


try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/miniproject", "root", "bhopal");
    

    String query = "INSERT INTO approval (title, description, request_by,request_date, request_dept) VALUES (?, ?,?,?, ?)";
    ps = con.prepareStatement(query);
    ps.setString(1, title);
    ps.setString(2, description);
    ps.setString(3, raised_by);
    ps.setString(4, request_date);
    ps.setString(5, request_dept);
    
    int rowsInserted = ps.executeUpdate();
    if (rowsInserted > 0) {
        out.println("Request submitted successfully.");
    	
    } else {
        out.println("Failed to submit request.");
    }
} 
catch (Exception e) 
{
    e.printStackTrace();
} 
finally
{
    try {
        if (ps != null) ps.close();
        if (con != null) con.close();
    } 
    catch (SQLException e) {
        e.printStackTrace();
    }
}
%>