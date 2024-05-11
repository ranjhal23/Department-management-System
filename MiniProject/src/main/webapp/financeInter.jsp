<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Legal Dashboard</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<style>
    .approved {
        color: #007bff !important;
    }
    .declined {
        color: #dc3545 !important;
    }
</style>
</head>
<body>
<% String username = (String) session.getAttribute("username");
if(username == null)
{
	response.sendRedirect("login.jsp");
}
%>

<div class="container">
<div class="row">
          <nav class="navbar navbar-inverse">
             <div class="container-fluid">
                <div class="navbar-header">
                  <p class="navbar-brand">Finance Dashboard </p>
                </div>
                <ul class="nav navbar-nav navbar-right">
                  <li> <a href="logout.jsp"><span class="glyphicon glyphicon-log-out"></span></a></li>
                </ul>
             </div>
          </nav>
  </div>
  <div class="row">
  
  </div>
    <h2>Finance Dashboard</h2>
    <table class="table table-bordered">
        <thead>
            <tr>
                <th>Request ID</th>
                <th>Request Title</th>
                <th>Description</th>
                <th>Request Date</th>
                <th>Request By</th>
                <th>Approval Person</th>
                <th>Approval Date</th>
                <th>Status</th>
            </tr>
        </thead>
        <tbody>
            <% 
            Connection con = null;
            Statement stmt = null;
            ResultSet rs = null;
            try {
                Class.forName("com.mysql.jdbc.Driver");
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/miniproject", "root", "bhopal");
                String query = "SELECT * FROM approval where request_dept='finance'";
                stmt = con.createStatement();
                rs = stmt.executeQuery(query);
                while (rs.next()) {
                    String requestId = rs.getString("request_id");
                    String requestTitle = rs.getString("title");
                    String description = rs.getString("description");
                    String requestDate = rs.getString("request_date");
                    String requestBy = rs.getString("request_by");
                    String approvalPerson = rs.getString("approval_person");
                    String approvalDate = rs.getString("approval_date");
                    String status = rs.getString("status");
            %>
            <tr>
                <td><%=requestId%></td>
                <td><%=requestTitle%></td>
                <td><%=description%></td>
                <td><%=requestDate%></td>
                <td><%=requestBy%></td>
                 <td id="approvalPerson_<%=requestId%>"><%=approvalPerson%></td> 
                <td id="approvalDate_<%=requestId%>"><%=approvalDate%></td>
                <td>
                    <div class="btn-group" role="group"id="status_<%=requestId%>">
                        <button type="button" class="btn btn-info approve-btn" onclick="updateStatus('<%=requestId%>', 'Approved', '<%=username%>')">Approve</button>
                        <button type="button" class="btn btn-danger decline-btn" onclick="updateStatus('<%=requestId%>', 'Declined', '<%=username%>')">Decline</button>
                    </div>
                </td>
            </tr>
            <%
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                try {
                    if (rs != null) rs.close();
                    if (stmt != null) stmt.close();
                    if (con != null) con.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            %>
        </tbody>
    </table>
</div>



<script>
function updateStatus(requestId, newStatus, username) {
    var confirmation = confirm("Are you sure you want to " + newStatus.toLowerCase() + " this request?");
    if (confirmation) {
        var xhr = new XMLHttpRequest();
        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.DONE) {
                if (xhr.status === 200) {
                    document.getElementById("status_" + requestId).innerHTML = newStatus;
                    if (newStatus === "Approved") {
                        document.getElementById("status_" + requestId).classList.add("approved");
                    } else if (newStatus === "Declined") {
                        document.getElementById("status_" + requestId).classList.add("declined");
                    }
                    alert("Request status updated successfully.");
                } else {
                    alert("Failed to update request status.");
                }
            }
        };
        xhr.open("POST", "UpdateStatus2.jsp", true);
        xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
        xhr.send("requestId=" + requestId + "&newStatus=" + newStatus+ "&approvalPerson=" + username);
    }
}

</script>


</body>
</html>