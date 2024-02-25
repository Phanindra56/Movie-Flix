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
	
	table {
	  border: 1px solid #ccc;
	  border-collapse: collapse;
	  margin: 0;
	  padding: 0;
	  width: 100%;
	  table-layout: fixed;
	}
	
	table caption {
	  font-size: 1.5em;
	  margin: .5em 0 .75em;
	}
	
	table tr {
	  
	  border: 1px solid #ddd;
	  padding: .35em;
	}
	
	table th,
	table td {
	border: 1px solid #ddd;
	  padding: .625em;
	  text-align: center;
	  color:black;
	  font-size:18px;
	}
	
	table th {
	  font-size: 20px;
	  letter-spacing: .1em;
	  text-transform: uppercase;
	  color: green;
	}
	
	div.polaroid {
  height: 400px;
  box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
  text-align: center;
  border: 0.5px solid white;
  border-radius: 1% 1%;
}

.movie{
padding-left:2%;
padding-top:0.5%;
font-size:20px; 
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
<title>Movies based Details</title>
</head>
<body>
<br>
<%
String id_new = request.getParameter("id");
MongoClient mongoClient = new MongoClient("localhost",27017);
System.out.println("MongoDB Connected... MD page");

MongoDatabase db= mongoClient.getDatabase("sample_mflix");
System.out.println("Database Connected... ");

MongoCollection<Document> movies = db.getCollection("movies");
System.out.println("Collection Connected... ");

System.out.println(id_new);


AggregateIterable<Document> iter1 = movies.aggregate(Arrays.asList(
		new Document("$match", new Document("title", id_new))
		/*new Document("$project", new Document("_id",1).append("title", 1).append(
			   "runtime",1).append("type",1).append("languages",1).append("directors",1
			    ).append("genres",1))*/
		));

MongoCursor<Document> cursor1 = iter1.iterator();
Document result = null;
if(cursor1.hasNext())
{	
	System.out.println("Line in ---------------");
	result = cursor1.next();
	System.out.println(result);
}

%>
<h1 align="center" style="color:green"> Details of the Movie </h1>
<br> <br>
<div style="width:90%" align="center" >
	<div style="width: 40%; float:left;height: 400px;" >
		<img src="<%=result.get("poster")%>" 
		style="height:400px;padding:1%;box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);" >
	</div>
	<div style="width:60%; float:left; height: 400px; background-color:rgba(255,255,255,0.6)" >
		<p align="left" class="movie" ><b>Title&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		:</b> <%=id_new %></p>
		<p align="left" class="movie" ><b>Cast&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		:</b> <%=result.get("cast") %></p>
		<p align="left" class="movie" ><b>Genres&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		:</b> <%=result.get("genres")%></p>
		<p align="left" class="movie" ><b>Plot&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		:</b> <%=result.get("plot")%></p>
		<p align="left" class="movie" ><b>Languages&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</b> <%=result.get("languages") %></p>
		<p align="left" class="movie" ><b>Release Date&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</b> <%=result.get("released") %></p>
		<p align="left" class="movie" ><b>Writers&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		:</b> <%=result.get("writers") %></p>
		<p align="left" class="movie" ><b>Imdb Rating&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; :</b> <%=result.get("imdb.rating") %></p>
		<p align="left" class="movie" ><b>Num mflix Comments&nbsp;:</b> <%=result.get("num_mflix_comments") %></p>

	</div>
</div>


</body>
</html>