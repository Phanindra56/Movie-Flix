<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<style>
	li a{
		color: white;
		text-align:center;
	}
	li a:hover{
		background-color:rgb(255,255,255);
		
	}
	.long a:hover{
		font-size: 18px;
		text-decoration:underline;
		color: orange;
	}
	
	
</style>
<link rel="stylesheet" href="css/stylefile.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.0.0-beta/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.5.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto">

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
<title>Popular</title>
</head>
<body>
<header style="padding:0.2%">
<nav  class="navbar navbar-dark bg-dark"> 
	<div style="width:100%; height: 50px;" class="nav justify-content-center"">
		<div style="width:25%;float:left;padding:1%">
			<li class="nav-item">
				<p style="font-weight:bold;color:white"> mflix </p>
			</li>
		</div>
		<div style="width:35%;float:left;padding:0.5%">
			<li>
				<form class="form-inline my-2 my-lg-0" action="listMovies.jsp">
			      <input class="form-control mr-sm-2" type="search" placeholder="Search for movie title" 
			      aria-label="Search" size="30" name="moviename">
			      <button class="btn btn-outline-success my-2 my-sm-0" type="submit">
        			<i class="fa fa-search"></i>
        		
        		</button>
			    </form>
			</li>
		</div>
		<div style="width:40%;float:right">
			<div style="width:25%;float:left">
				<li class="nav-item">
					<a class="nav-link" href="movies.jsp">Home</a>
				</li>
			</div>
			<div style="width:25%;float:left">
				<li class="nav-item">
					<a class="nav-link" href="popular.jsp">Popular</a>
				</li>
			</div>
			<div style="width:25%;float:left">
				<li class="nav-item">
					<a class="nav-link"  href="theater.jsp">Theater </a>
				</li>
			</div>
			<div style="width:25%;float:left">
				<li class="nav-item">
					<a class="nav-link"  href="logout.jsp">Logout</a>
				</li>
			</div>
		</div>
	</div>
</nav>
</header>
<br>
<br>
<div style="width:100%">
	<%
	MongoClient mongoClient = new MongoClient("localhost",27017);
	System.out.println("MongoDB Connected... ");

	MongoDatabase db= mongoClient.getDatabase("sample_mflix");
	System.out.println("Database Connected... ");

	MongoCollection<Document> movies = db.getCollection("movies");
	System.out.println("Collection Connected... ");
	
	AggregateIterable<Document> iter1 = movies.aggregate(Arrays.asList(
			new Document("$match", new Document("imdb.rating", new Document("$ne", ""))),
			new Document("$sort", new Document("imdb.rating", -1).append("tomatoes.viewer.rating", -1)),
			new Document("$limit", 10),
			new Document("$project", new Document("title",1).append("_id", 0))));

	MongoCursor<Document> cursor1 = iter1.iterator();
	Document result = null;
	ArrayList ar=new ArrayList();
	while(cursor1.hasNext())
	{
		result = cursor1.next();
		System.out.println(result.get("title"));
		ar.add(result.get("title"));
	}
	AggregateIterable<Document> iter = movies.aggregate(Arrays.asList(
			new Document("$match", new Document("title", new Document("$in", ar))),
			new Document("$project", new Document("title",1).append("poster",1))));
	
	MongoCursor<Document> cursor = iter.iterator();
	Document res = null;
	String a = "";
	String b = "";
	
	while(cursor.hasNext())
	{	
		res = cursor.next();
		a= (String)res.get("poster");
		b = (String) res.get("title");
	%>
	<div style="width:25%;float:left;padding:2%" class="long" >
		<a href="moviedetails.jsp?id=<%=b%>" style="text-decoration:none">
		<img src="<%=a %>" alt="<%=b %>" style="width:80%;height:250px;padding:1%"> 
		<p style="color:green;font-size:20px"> <%=b %> </p> 
		</a>
	</div>
	<%
	}
	%>
</div>

<div>
</div>
</body>
</html>