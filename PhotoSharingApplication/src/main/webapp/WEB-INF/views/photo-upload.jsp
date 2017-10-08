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
.btn{
margin:0 auto;
}
</style>
<script>
	$(document).ready(function() {

		$('#read').change(function() {
			readURL(this);

		});

		function readURL(input) {
			if (input.files && input.files[0]) {
				var reader = new FileReader();

				reader.onload = function(e) {
					$('#one').attr('src', e.target.result);
				}

				reader.readAsDataURL(input.files[0]);
			}
		}

	});
</script>
<title>PicShare</title>
</head>
<body>
	<div class="container-fluid">
		<c:import url="header.jsp"></c:import>
	</div>
	<c:set var="contextPath" value="${pageContext.request.contextPath}" />
	<div class="continer">

		<h2 class="text-center">Image Upload</h2>

		<div class="row">
			<div class="col-md-4"></div>
			<div class="col-md-4" id="loc">
				<img id="one" src="" width="430" height="300" />
			</div>
		</div>
		<div class="row">
			<div class="col-md-4"></div>
			<div class="col-md-4">
				<form:form commandName="photo" method="post"
					enctype="multipart/form-data">
					<input type="file" class="form-control loader" id="read" name="pic" />

					<input type="submit" class="btn btn-primary" value="Upload Button" />
				</form:form>
			</div>
		</div>

	</div>
</body>
</html>