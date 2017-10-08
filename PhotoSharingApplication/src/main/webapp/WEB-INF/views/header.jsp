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
<title>PicShare</title>
<style>
.nv {
	background: #d6e5ff;
	padding: 10px 0px 10px 0px;
	border-bottom: 1px solid #0e1116;
	border-top: 1px solid #0e1116;
}

h1 a:hover{

text-decoration: none;
}
</style>
</head>
<body>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
	<div class="container-fluid">

		<h1><a href="${contextPath}/user/login">Hi, ${user.firstName}</a></h1>
	</div>
	<c:set var="contextPath" value="${pageContext.request.contextPath}" />
	<div class="row nv">
		<nav>
			<div class="col-md-3"></div>
			<div class="col-md-2 text-center">
				<a href="${contextPath}/photo/upload">Upload photo</a>
			</div>
			<div class="col-md-1 text-center">
				<a href="${contextPath}/photo/gallery">My Gallery</a>
			</div>
			<div class="col-md-2 text-center">
				<a href="${contextPath}/user/available">Explore Users</a>
			</div>
			<div class="col-md-1 text-center">
				<a href="${contextPath}/follow/followers">Followers</a>
			</div>
			<div class="col-md-1 text-center">
				<a href="${contextPath}/follow/following">Following</a>
			</div>
			<div class="col-md-1 text-center">
				<a href="${contextPath}/logout"> Log Out</a>
			</div>
		</nav>
	</div>

</body>
</html>