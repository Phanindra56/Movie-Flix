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
	
	.main {
    width: 60%;
    margin: 50px auto;
}

/* Bootstrap 4 text input with search icon */

.has-search .form-control {
    padding-left: 2.375rem;
}

.input-group>.form-control{
	height: 50px;
}

.has-search .form-control-feedback {
    position: absolute;
    z-index: 2;
    display: block;
    width: 2.375rem;
    height: 2.375rem;
    line-height: 2.375rem;
    text-align: center;
    pointer-events: none;
    color: #aaa;
}
	
</style>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.5.0/Chart.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.1.3/css/bootstrap.min.css">
<link rel="stylesheet" href=" https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">


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
<title>Theater by location</title>
</head>
<body>
<header style="padding:0.2%">
<nav  class="navbar navbar-dark bg-dark"> 
	<div style="width:100%; height: 50px;" class="nav justify-content-center"">
		<div style="width:60%;float:left;padding:1%">
			<li class="nav-item">
				<p style="font-weight:bold;color:white;font-align:left"> mflix </p>
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

<form action="theaterdetails.jsp">
<div class="main">
  <div class="input-group">
    <input type="text" class="form-control" placeholder="Search by city for theater details" name="searchT" id="ttid">
    <div class="input-group-append">
      <button class="btn btn-secondary" type="submit">
        <i class="fa fa-search"></i>
      </button>
    </div>
  </div>
</form>
</body>
</html>