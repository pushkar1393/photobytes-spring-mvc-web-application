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
.row {
	margin: 15px 0px 0px 0px;
}

.banner {
	background: url(${contextPath}"/pkg/resources/images/home.jpg");
	background-size : cover;

}

.overlay {
	background-color: rgba(255, 255, 255, 0.2);
	height: 100vh;
}

a {
	padding: 10px;
	font-family: verdana
}

.btn-primary {
transition: 0.3s;
}

.text-left{
color: #fff;
padding: 5pt 0pt 5pt 0pt;
margin: 25pt 0pt 0pt 0pt;
float:left;
}

header .container-fluid {
margin : 0pt 20pt;
border-bottom: 1px solid #ffff;
}

h1{
font-size:50px;
width: 50vw;
}

.navbar .btn{
color: #fff;
font-size: 15pt;
width: inherit;
}

li{
list-style-type: none;
padding-top:1px;
}
.navbar li>a {
padding-bottom: 10px;
transition: 0.3s;
}
li a:hover {
border-bottom: 2px solid #fff;
border-radius: 0px;
text-shadow:0 0 2px rgba(0,0,255,0.5);
}

.navbar{
float:right;
width:inherit;
margin: 41pt 30pt 0pt 0pt;
border-bottom:0px solid transparent;
}

.clearfix {
clear:both;
}
</style>
<title>PhotoBytes</title>
</head>
<body>
	<c:set var="contextPath" value="${pageContext}" />
	<div class="banner">
	<div class="overlay">
	<header>
	<div class="container-fluid">
		<h1 class="text-left">PhotoBytes</h1>
		<nav>
			<ul class="navbar navbar-nav ">
				<li><a class="col-xs-4 btn" href="user/register">Register</a></li>
				<li>	<a class="col-xs-4 btn" data-toggle="modal"
					data-target="#loginForm">Login</a></li>
			</ul>
		</nav>
	</div>
	</header>
	<section class="clearfix">
		
		</section>
	<footer>
	<div class="container-fluid  sticky-bottom">
		<p class="text-center">copyright details</p>
	</div>
	</footer>
	</div>
</div>

	<!-- login form modal -->

	<div id="loginForm" class="modal fade" role="dialog">
		<div class="modal-dialog">

			<div class="modal-content">
				<form action="user/login" method="post">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title">Login Form</h4>
					</div>
					<div class="modal-body">

						<div class="row">
							<div class="col-md-8 col-md-offset-2">
								<input name="username" class="form-control" required="required"
									placeholder="username" />
							</div>
						</div>

						<div class="row">
							<div class="col-md-8 col-md-offset-2">
								<input type="password" class="form-control" name="password"
									placeholder="password" required="required" />
							</div>
						</div>

						<div class="row">
							<div class="col-md-8 col-md-offset-2">
								<input type="submit" class="form-control btn btn-primary"
									value="submit" />
							</div>
						</div>

					</div>
				</form>
			</div>

		</div>
	</div>
</body>
</html>