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
<title>Movies List Page</title>
</head>
<body>
<% %>
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


<div >
<table>
<thead>
	<tr>
		<th>Title</th>
		<th>RunTime</th>
		<th>Type</th>
		<th>Languages</th>
		<th>Directors</th>
		<th>Genres</th>
	</tr>
</thead>
<%

MongoClient mongoClient = new MongoClient("localhost",27017);
System.out.println("MongoDB Connected... ");

MongoDatabase db= mongoClient.getDatabase("sample_mflix");
System.out.println("Database Connected... ");

MongoCollection<Document> movies = db.getCollection("movies");
System.out.println("Collection Connected... ");


String search = request.getParameter("moviename");
Document regexQuery = new Document();
regexQuery.append("$regex", ".*(?i)" + search + ".*");

BasicDBObject query = new BasicDBObject("title", regexQuery);
AggregateIterable<Document> iter1 = movies.aggregate(Arrays.asList(
		new Document("$match", query),
		new Document("$project", new Document("_id",1).append("title", 1).append(
			   "runtime",1).append("type",1).append("languages",1).append("directors",1
			    ).append("genres",1))
		//new Document("$unwind", "$languages"),
		//new Document("$unwind", "$directors"),
		//new Document("$unwind", "$genres")
		));

MongoCursor<Document> cursor1 = iter1.iterator();
Document result = null;
while(cursor1.hasNext())
{
	result = cursor1.next();
	//System.out.println(result);
	//String g1 = (String)result.get("_id");
	//System.out.println(g1);
%>
	
		<tr>
			<td ><a href="moviedetails.jsp?id=<%=result.get("title")%>"><%=result.get("title")%></a> </td>
			<td><%=result.get("runtime") %> </td>
			<td><%=result.get("type") %> </td>
			<td><%=result.get("languages") %> </td>
			<td><%=result.get("directors") %> </td>
			<td><%=result.get("genres") %> </td>
		</tr>
		<%
		}
		%>
	</table>


</div>

</body>
</html>