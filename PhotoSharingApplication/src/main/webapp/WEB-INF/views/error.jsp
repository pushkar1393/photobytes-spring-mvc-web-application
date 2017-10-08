<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>

<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<style>
.row{
margin-top:100px;
}
</style>
<title>PicShare</title>
</head>
<body>
<div class="container">
<div class="row">
<div class="col-md-3"></div>
<div class="col-md-3"><h4>Thats a </h4><h2>404</h2>
<br/>
<h5>There was an error while processing your request.Thats all we know</h5>
</div><div class="col-md-3"><img width="500" height="370" src="${contextPath}/pkg/resources/images/error.jpg" alt="error_image"/></div>
</div>
<div class="row">
<div class="col-md-3">
<a href="/pkg" class="btn btn-primary">Go Back</a>
</div>
</div>
</div>
</body>
</html>