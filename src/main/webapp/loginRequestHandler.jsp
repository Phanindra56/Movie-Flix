<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>

<head>
<!-- Packages import  -->
<%@page import="java.util.ArrayList" %>
<%@page import="java.util.*" %>
<%@page import="com.mongodb.*" %>
<%@page import="com.mongodb.MongoClient" %>
<%@page import="com.mongodb.BasicDBObject" %>
<%@page import="com.mongodb.client.MongoCollection" %>
<%@page import="com.mongodb.client.MongoDatabase" %>
<%@page import="com.mongodb.client.MongoCursor" %>
<%@page import="com.mongodb.client.FindIterable" %>
<%@page import="com.mongodb.client.MongoIterable" %>
<%@page import="com.mongodb.client.AggregateIterable" %>
<%@page import="org.bson.Document" %>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>

<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

 
<%

MongoClient mongoClient = new MongoClient("localhost",27017);
System.out.println("MongoDB Connected... ");

MongoDatabase db= mongoClient.getDatabase("sample_mflix");
System.out.println("Database Connected... ");

MongoCollection<Document> collection = db.getCollection("users");
System.out.println("Collection Connected.... ");

String user = request.getParameter("username");
String pwd = request.getParameter("pwd");


AggregateIterable<Document> iter1 = collection.aggregate(Arrays.asList(
		new Document("$match", new Document("email", user)),
		new Document("$project", new Document("_id",0).append("email", 1).append(
				"password",1).append("name",1))));

MongoCursor<Document> cursor1 = iter1.iterator();
Document res = null;
String p = "";
String name ="";
int val = 0;
while(cursor1.hasNext())
{
	
	res = cursor1.next();
	name = (String) res.get("name");
	p = (String) res.get("password");
	request.setAttribute("name", name);
}
 
if(p.equals(pwd)){
//session.setAttribute("email",loginBean.getEmail());
response.sendRedirect("movies.jsp");
System.out.println("Login Sucessful");
}
 
else{
	System.out.println("Login Failed"); %>
	<script>
		alert("Invalid Login Details");
	</script>
	<%
response.sendRedirect("index.jsp?status=false");
}


%>
</body>
</html>