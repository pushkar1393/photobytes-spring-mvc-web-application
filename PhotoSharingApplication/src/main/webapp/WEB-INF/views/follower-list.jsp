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
</head>
<body>
	<div class="container-fluid">
		<c:import url="header.jsp"></c:import>
	</div>
	<c:set var="contextPath" value="${pageContext.request.contextPath}" />
	<div class="container">
		<h2 class="text-center">Followers</h2>

		<c:choose>
			<c:when test="${empty requestScope.followerlist}">
				<h4>You are alone</h4>
			</c:when>
			<c:otherwise>
				<table class="table table-stripped table-hover">
					<tr>
						<th>User Name</th>
						<th></th>
					</tr>
					<c:forEach items="${requestScope.followerlist}" var="follower">
						<tr>
							<td>${follower.username}</td>
							<td><a class="btn btn-default"
								href="view/${follower.personID}">View Profile</a></td>
						</tr>
					</c:forEach>
				</table>
			</c:otherwise>
		</c:choose>

	</div>
</body>
</html>