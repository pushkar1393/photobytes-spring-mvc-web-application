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
<style type="text/css">
.space{
margin-top:10px !important;
margin-bottom:40px !important
}
</style>
</head>
<body>
	<div class="container-fluid">
		<c:import url="header.jsp"></c:import>
	</div>
	<div class="container">
		<c:choose>
			<c:when test="${empty requestScope.feeds}">
				<h3>No feeds to display</h3>
			</c:when>
			<c:otherwise>
				<c:forEach items="${requestScope.feeds}" var="feed">

					<div class="thumbnail space" style="width: 70%; margin: 0 auto">

						<div class="row">
							<div class="col-xs-4">
								<h4>${feed.user.username}</h4>
							</div>
							<div class="col-xs-2"></div>
							<div class="col-xs-6 text-right">
								<h4><small><span class="glyphicon glyphicon-time"/> ${feed.uploadDate}</small></h4>
							</div>
						</div>
						<img class="img img-responsive" src="${feed.fileName}"
							alt="images" />
						<div class="caption">
							<div class="row">
								<span><img name="${feed.photoID}" class="like"
									src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAB7ElEQVRIS7XVS8iNURTG8d9HhDKRgUspKbmEcksYuBRKDCSFFAZkgAwoZUa5xMB1QKKYoFzKBKWIohDFRAYykEvKRAZyaWntOh3nnPc733fsyVt7P3v997vXWs/u8p9HV4P4A7EIE3LtFe7ge512UOrGt9LVA9bjIJ7jSW6cgcnYiQs5twH78SJ1EWc6JqXuYjlMLWA31mEVXtaddgou4yz6Vugu4QyORIwCmIlrmIYPTdIyMk/7C1PxsYluBJ5iKZ4VQFDv4VRFzlcgANcrdFsxC2sL4DPiGt53qKhG4TGGF8BPDMCPDgH64xv6FcA7LMCbDgHG4hZGF8D5SAiOdQiwI0t2YwHMx4mcjCT2ZvRBNOdm3C+A+EZSDme99wawGtswG79rG20e4qomZoJ6Ahmcp1+DB7WNVoJFi3/B9p5Ex0mER4WV/B31XjQk/WULbrYJWY7j2U9fmwFifi6u5vd1NyHjIqEIyKPaPY3sOtY3pSvOwacKyDA8xD6cq9c2A4RuL5ZhYealEWco7uJK6v/RtALE2iEsweIGPhXuejuNb0+UZKMTtAKUIoh3IpomnDRsOEY8LmHvR7N3mt5iFaBsXJlWfiArb1fm6UZVEXQXEHHG4DTCeaMI3lYFb9QH3dnTlqadP2grcBH/AU5hWxnr9PQbAAAAAElFTkSuQmCC"
									alt="like_button" /></span>
							</div>
						</div>

					</div>
				</c:forEach>
			</c:otherwise>
		</c:choose>
	</div>
</body>
</html>