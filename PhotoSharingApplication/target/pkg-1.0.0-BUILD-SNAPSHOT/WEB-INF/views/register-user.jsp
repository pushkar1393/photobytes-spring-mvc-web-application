<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
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
.banner{
	background: url(${contextPath}"/pkg/resources/images/register.jpg");
}
.row {
	margin: 10px 100px 0px 100px;
}
.btn {
height: 40pt;
transition: 0.3s;
}
.text-center {
padding:15pt;
}
.row {
padding:7pt;
}
</style>
<title>PhotoBytes</title>
</head>
<body>
	<c:set var="contextPath" value="${pageContext.request.contextPath}" />
	<br />
	<div class="banner container-fluid">
		<h2 class="text-center">Register a New User</h2>

		<form:form action="${contextPath}/user/register" commandName="user"
			method="post">

			<div class="row">
				<div class="col-xs-6 col-xs-offset-3">
					<form:input path="firstName" placeholder="First Name"
						class="form-control" required="required" />
					<form:errors path="firstName" />
				</div>
			</div>

			<div class="row">
				<div class="col-xs-6 col-xs-offset-3">
					<form:input path="lastName" placeholder="Last Name"
						class="form-control" required="required" />
					<form:errors path="lastName" />
				</div>
			</div>


			<div class="row">
				<div class="col-xs-6 col-xs-offset-3">
					<form:input path="username" placeholder="Username"
						class="form-control" required="required" />
					<font color="red"><form:errors path="username" /></font>
				</div>
			</div>
			<div class="row">
				<div class="col-xs-6 col-xs-offset-3">
					<form:password path="password" placeholder="Password"
						class="form-control" required="required" />
					<form:errors path="password" />
				</div>
			</div>

			<div class="row">
				<div class="col-xs-6 col-xs-offset-3">
					<form:input path="email" placeholder="Email Address"
						class="form-control" type="email" required="required" />
					<form:errors path="email" />
				</div>
			</div>
			<div class="row">
				<div class="col-xs-6 col-xs-offset-3">
					<form:input path="dateOfBirth" type="date" class="form-control"
						required="required" />
					<form:errors path="dateOfBirth" />
				</div>
			</div>

			<div class="row">
				<div class="col-xs-6 col-xs-offset-3">
					<form:select path="sex" class="form-control" required="required">
						<form:option value="Male">Male</form:option>
						<form:option value="Female">Female</form:option>
					</form:select>
					<form:errors path="sex" />
				</div>
			</div>

			<div class="row">
				<div class="col-xs-6 col-xs-offset-3">
					<input type="submit" value="Register"
						class="btn btn-primary form-control" />
				</div>
			</div>
		</form:form>
	</div>
</body>
</html>