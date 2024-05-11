<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<%@ include file="cdn.jsp" %>
<%@ page import="java.util.Date ,java.sql.*, com.database.DBConnection" %>
</head>
<body>
   <%
      String username= (String)session.getAttribute("username");
      if(username==null){
    	  response.sendRedirect("login.jsp");
      }
      else{
    	  
   %>
   <div class="container">
         <div class="row">
          <nav class="navbar navbar-inverse">
             <div class="container-fluid">
                <div class="navbar-header">
                  <p class="navbar-brand">Management Dashboard </p>
                </div>
                <ul class="nav navbar-nav navbar-right">
                  <li> <a href="logout.jsp"><span class="glyphicon glyphicon-log-out"></span></a></li>
                </ul>
             </div>
          </nav>
         </div>
         <div class="row">
         <div class="col-md-10">
          <h2>Request Form</h2>
        <form action="submitRequest.jsp" method="post">
            <div class="form-group">
                <label for="title">Title:</label>
                <input type="text" class="form-control" id="title" name="title" required>
            </div>
            <div class="form-group">
                <label for="description">Description:</label>
                <textarea class="form-control" style="height: 150px;"  id="description" name="description" required></textarea>
            </div>
            <div class="form-group">
                <label for="request_dept">Department:</label>
                <input type="text" class="form-control" id="request_dept" name="request_dept" required>
            </div>
             <input type="text" name="username" value="<%= username %>" hidden/>
              <input type="text" name="request_date" value="<%= new Date() %>" hidden/>
              
            <button type="submit" class="btn btn-primary">Submit Request</button>
        </form>
         </div>
         </div>
         <div class="row">
         <h2> Request Status</h2>
         <br/>
          <div class="col-md-12">
           <table class=" table table-hover">
           <tr>
			<th>Request Id</th>
			<th>Title</th>
			<th>Description</th>
			<th>Request Date</th>
			<th>Request Department</th>
			<th>Approval Person</th>
			<th>Approval Date</th>
			<th>Status</th>
		</tr>
		<%
		try
		{
			Connection con = DBConnection.takeConnection();	
			String query = "select * from approval order by request_id";
			PreparedStatement ps = con.prepareStatement(query);
			ResultSet rs = ps.executeQuery();
			while(rs.next())
			{
				out.println("<tr>");
				//out.println("<td>"+rs.getString(0)+"</td>");
				out.println("<td>"+rs.getString(1)+"</td>");
				out.println("<td>"+rs.getString(2)+"</td>");
				out.println("<td>"+rs.getString(3)+"</td>");
				out.println("<td>"+rs.getString(5)+"</td>");
				out.println("<td>"+rs.getString(6)+"</td>");
				out.println("<td>"+rs.getString(7)+"</td>");
				out.println("<td>"+rs.getString(8)+"</td>");
				out.println("<td>"+rs.getString(9)+"</td>");
				
				out.println("</tr>");
			}
			con.close();
		}
		catch(Exception e)
		{
			out.println(e);
		}
		
		%>
        </table>
             
          </div>
        
         </div>
        
    </div>
  
<%
}
%>
</body>
</html>