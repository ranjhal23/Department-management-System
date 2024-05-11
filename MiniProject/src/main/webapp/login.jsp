<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Login Page</title>
<%@ include file="cdn.jsp" %>
</head>
<body>
   <div class="conatiner">
       <div class="col-md-4"></div>
       <div class="col-md-4">
       <br/><br/>
          <fieldset>
           <br/>
             <legend> Login Details</legend>
             <form method="post" action="loginController.jsp">
                  <input type="text" name="username" class="form-control" placeholder="Enter username"/><br/>
                  <br/>
			      <input type="password" name="password" class="form-control" placeholder="Enter password"/><br/>
			      <br/>
			        <select name="role" class="form-control">
			       <option value="legal">Legal</option>
	                <option value="management">Management</option>
	                <option value="finance">Finance</option>
	                
			  </select><br/>
			  <input type="submit" class="btn btn-primary" value="Login"/>
             </form>
          </fieldset>
       </div>
       <div class="col-md-4"></div>
   </div>
</body>
</html>