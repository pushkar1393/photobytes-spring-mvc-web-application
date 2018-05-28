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
	background: url(${contextPath}"/pkg/resources/images/home.jpg"); background-size : cover;
	height: 85vh;
	background-size: cover;
}

.overlay {
	background-color: rgba(255, 255, 255, 0.4);
	height: 85vh;
}

a {
	margin: 10px;
}

.big{
height : 45pt;
font-family :verdana;
padding: 8pt 0pt 8pt 0pt;
font-size: 15pt;
 border: 2px solid rgba(255, 255, 255, 0.6);
 border-radius: 20pt;
background-color: rgba(255, 255, 255, 0.6);
}

.big:hover{
background-color: rgba(255, 255, 255, 0.9);
}

</style>
<title>PhotoBytes</title>
</head>
<body>
	<c:set var="contextPath" value="${pageContext}" />

	<div class="container-fluid">
		<h2 class="text-center">PhotoBytes</h2>
	</div>
	<div class="banner container-fluid">
		<div class="overlay container-fluid">
			<div class="row text-center">
				<div class="col-xs-4"></div>
				<a class="col-xs-4 btn  big" href="user/register">Register</a>
			</div>
			<div class="row text-center">
				<div class="col-xs-4"></div>
				<a class="col-xs-4 btn big" data-toggle="modal"
					data-target="#loginForm">Login</a>
			</div>
		</div>
	</div>
	<div class="container-fluid">
		<p class="text-center">copyright details</p>
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