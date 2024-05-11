package com.database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

public class DBConnection {
	 public static Connection takeConnection() {
    	 Connection con=null;
    	 try {
    		 Class.forName("com.mysql.cj.jdbc.Driver");
    		 con= DriverManager.getConnection("jdbc:mysql://localhost:3306/miniproject", "root", "bhopal");
    		 
    	 }
    	 catch(Exception e) {
    		 e.printStackTrace();
    	 }
    	 return con;
     }
	  
}
