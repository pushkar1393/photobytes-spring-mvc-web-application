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
		<h2 class="text-center">${requestScope.model.follower.username}'s
			Collection</h2>
		<table class="table table-striped table-hover">
			<tr>
				<th>First Name</th>
				<th>Last Name</th>
				<th>Followers</th>
				<th>Following</th>
			</tr>
			<tr>
				<td>${requestScope.model.follower.firstName}</td>
				<td>${requestScope.model.follower.lastName}</td>
				<td>${fn: length(requestScope.model.follower.followers)}</td>
				<td>${fn: length(requestScope.model.followinglist)}</td>
			</tr>
			<tr>
				<td colspan="4">${requestScope.model.follower.bio}</td>
			</tr>
		</table>
		<c:choose>
			<c:when test="${not requestScope.model.follows}">
				<h4>User is Private. You need to follow</h4>
			</c:when>

			<c:otherwise>
				<c:forEach items="${requestScope.model.follower.photo}" var="pic">
					<div class="col-md-4">
						<div class="thumbnail">
							<img class="img img-responsive" src="${pic.fileName}"
								alt="images" style="width: 100%" />
							<div class="caption">
								<div class="row">
									<span><img id="${pic.photoID}" class="like"
										src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAB7ElEQVRIS7XVS8iNURTG8d9HhDKRgUspKbmEcksYuBRKDCSFFAZkgAwoZUa5xMB1QKKYoFzKBKWIohDFRAYykEvKRAZyaWntOh3nnPc733fsyVt7P3v997vXWs/u8p9HV4P4A7EIE3LtFe7ge512UOrGt9LVA9bjIJ7jSW6cgcnYiQs5twH78SJ1EWc6JqXuYjlMLWA31mEVXtaddgou4yz6Vugu4QyORIwCmIlrmIYPTdIyMk/7C1PxsYluBJ5iKZ4VQFDv4VRFzlcgANcrdFsxC2sL4DPiGt53qKhG4TGGF8BPDMCPDgH64xv6FcA7LMCbDgHG4hZGF8D5SAiOdQiwI0t2YwHMx4mcjCT2ZvRBNOdm3C+A+EZSDme99wawGtswG79rG20e4qomZoJ6Ahmcp1+DB7WNVoJFi3/B9p5Ex0mER4WV/B31XjQk/WULbrYJWY7j2U9fmwFifi6u5vd1NyHjIqEIyKPaPY3sOtY3pSvOwacKyDA8xD6cq9c2A4RuL5ZhYealEWco7uJK6v/RtALE2iEsweIGPhXuejuNb0+UZKMTtAKUIoh3IpomnDRsOEY8LmHvR7N3mt5iFaBsXJlWfiArb1fm6UZVEXQXEHHG4DTCeaMI3lYFb9QH3dnTlqadP2grcBH/AU5hWxnr9PQbAAAAAElFTkSuQmCC"
										alt="like_button" /></span>
								</div>
								<div class="row">
								<a href="../../photo/comment/${pic.photoID}">Add/View Comments</a>
								</div>
								<p>${photo.photoID}</p>
							</div>
						</div>
					</div>
				</c:forEach>
			</c:otherwise>
		</c:choose>


	</div>
</body>
</html>