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
	.row{
	padding-top:10px;
	margin-bottom: 4px;
	padding-bottom:10px;
	}
	
	.highLight{
	background:#edf3ff;
	border-bottom: 1px solid #DEDEDE;
	}
	
	</style>
<script>
$(document).on('click','.like',function(event){
	
	event.preventDefault();
	var elem = $(this);
	var picID= ${map.photo.photoID};
	var lik_url="../hit";
	var likeVal = {
			"photoID": picID
	};
	
	$.ajax({
		
		url: lik_url,
		data: likeVal,
		dataType:'json',
		type: 'post',
		success: function(data){
			if(data.flag== 'true'){
				console.log('true');
				$(elem).attr('src','data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAACWklEQVRIS7WVzWsTYRDGn3k3aSvFVhDBg6WCpRo3hEA1MbHR3UihBw8ejOBBD+Kppwoe9C/Qi3gSDx5EEATjQfDUqk005kNL8atJmiqoeJEKIhYrabLvyCY2NDbJRrvd2+77zPzm3eGZIWzwQxucH+sG3I1EFLPIE9Go0ajYOsDDoaHeDuevcYY4DuJBM8AACgpwzyHKV4eThUXzW8Y/0FOkjnPMdFIKmDoWkuch6M5qnamtARK+PYMGKZMQ6G/y2z5KoYw6S8tsKMoEgJ2NdBL8wWnI0dCLufkaYMLj6e7sKr2GIna16okk+dk8Fyz6WukM4F3vcpd338zMUuUGsYB6gYBLdjaciM8fTuWuVABxv/oSAl47AczGtJ6Z81UAUwF1SQCb7ARIicXw82xPFeBXfwiBzXYCAHzT0tmtKz14SkDITgAzx/RMLlwFHFDPEuGGnQAQn9FSuZtVgKY5qPg1CcBnC4Qps9DnGjbdXTNabL+6nRxIABhYJ+Q9lxHSp7Nf6pxsvjwOuvoV5meAsuN/IKYRGQgdSeU/rcSvGXZTBz27UTISQsG2f4JIY0E6Og6Fk28Kq+MaTtNYUPWSIWMQYktbECm/syJ0PZV99be+6bh+EnAHGcYkILpbQ+RPkGNES71NN9K13Adxv3sEzA+goLMhxECRhTyqZ/KPmhVhuXBiAdcxkohCCEddEinLLBDR0/n7rW5oCagMw6D7lGS+Jf7sDwkwEZ3WU7O3rXrUFqAKUcfAuFZJyDSmZWavWyVf4wOrgHhg70UGsZ7OXrbSNvVBu4Ht6n4DPJrOGc32WOUAAAAASUVORK5CYII=');
				$(elem).next().replaceWith("<b> "+ data.count +" Like </b>")
			}else {
				console.log('false');
				$(elem).attr('src','data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAB7ElEQVRIS7XVS8iNURTG8d9HhDKRgUspKbmEcksYuBRKDCSFFAZkgAwoZUa5xMB1QKKYoFzKBKWIohDFRAYykEvKRAZyaWntOh3nnPc733fsyVt7P3v997vXWs/u8p9HV4P4A7EIE3LtFe7ge512UOrGt9LVA9bjIJ7jSW6cgcnYiQs5twH78SJ1EWc6JqXuYjlMLWA31mEVXtaddgou4yz6Vugu4QyORIwCmIlrmIYPTdIyMk/7C1PxsYluBJ5iKZ4VQFDv4VRFzlcgANcrdFsxC2sL4DPiGt53qKhG4TGGF8BPDMCPDgH64xv6FcA7LMCbDgHG4hZGF8D5SAiOdQiwI0t2YwHMx4mcjCT2ZvRBNOdm3C+A+EZSDme99wawGtswG79rG20e4qomZoJ6Ahmcp1+DB7WNVoJFi3/B9p5Ex0mER4WV/B31XjQk/WULbrYJWY7j2U9fmwFifi6u5vd1NyHjIqEIyKPaPY3sOtY3pSvOwacKyDA8xD6cq9c2A4RuL5ZhYealEWco7uJK6v/RtALE2iEsweIGPhXuejuNb0+UZKMTtAKUIoh3IpomnDRsOEY8LmHvR7N3mt5iFaBsXJlWfiArb1fm6UZVEXQXEHHG4DTCeaMI3lYFb9QH3dnTlqadP2grcBH/AU5hWxnr9PQbAAAAAElFTkSuQmCC');
				$(elem).next().replaceWith("<b> "+ data.count +" Like </b>")
			}
			
		}
	})
	
});




	$(document).on('click', '.comment', function(event) {
		event.preventDefault();
		var location = $(this).parent().parent();
		var clean = $(this).parent().prev().children();
		var text = $(this).parent().prev().children().val();
		var com_url = "add";
		var picID = ${map.photo.photoID};
		var commentText = {
			"comText" : text,
			"photoID" : picID
		};

		$.ajax({

			url : com_url,
			data : commentText,
			dataType : 'json',
			type : 'post',
			success : function(data) {
				console.log(location)
				console.log(data);
				$(location).before("<div class='row highLight'><div class='col-sm-1'><b>"+data.user+"</b></div><div class='col-sm-11'>"+data.comment+"</div></div>");
				$(clean).val("");
			},
			error : function(req, status, err) {
				console.log('Something went wrong', status, err);
			}

		})

	});
</script>
<title>PhotoBytes</title>
</head>
<body>
<div class="container-fluid">
		<c:import url="header.jsp"></c:import>
	</div>
	<div class="container">
		
		<div class="thumbnail space" style="width: 70%; margin: 0 auto">
		<div class="row">
			<div class="col-xs-4"><h4>${map.photo.user.username}</h4></div>
			<div class="col-xs-4"></div>
			<div class="col-xs-4 text-right"><h4><small><span class="glyphicon glyphicon-time"/> ${map.photo.uploadDate}</small></h4></div>
		</div>
			<img class="img img-responsive" src="${map.photo.fileName}" alt="images"
				style="" />
			<div class="caption">
				<div class="row">
					<div class="col-sm-2">
					<c:choose>
					<c:when test="${map.flag}">
						<span><img name="${map.photo.photoID}" class="like"
							src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAACWklEQVRIS7WVzWsTYRDGn3k3aSvFVhDBg6WCpRo3hEA1MbHR3UihBw8ejOBBD+Kppwoe9C/Qi3gSDx5EEATjQfDUqk005kNL8atJmiqoeJEKIhYrabLvyCY2NDbJRrvd2+77zPzm3eGZIWzwQxucH+sG3I1EFLPIE9Go0ajYOsDDoaHeDuevcYY4DuJBM8AACgpwzyHKV4eThUXzW8Y/0FOkjnPMdFIKmDoWkuch6M5qnamtARK+PYMGKZMQ6G/y2z5KoYw6S8tsKMoEgJ2NdBL8wWnI0dCLufkaYMLj6e7sKr2GIna16okk+dk8Fyz6WukM4F3vcpd338zMUuUGsYB6gYBLdjaciM8fTuWuVABxv/oSAl47AczGtJ6Z81UAUwF1SQCb7ARIicXw82xPFeBXfwiBzXYCAHzT0tmtKz14SkDITgAzx/RMLlwFHFDPEuGGnQAQn9FSuZtVgKY5qPg1CcBnC4Qps9DnGjbdXTNabL+6nRxIABhYJ+Q9lxHSp7Nf6pxsvjwOuvoV5meAsuN/IKYRGQgdSeU/rcSvGXZTBz27UTISQsG2f4JIY0E6Og6Fk28Kq+MaTtNYUPWSIWMQYktbECm/syJ0PZV99be+6bh+EnAHGcYkILpbQ+RPkGNES71NN9K13Adxv3sEzA+goLMhxECRhTyqZ/KPmhVhuXBiAdcxkohCCEddEinLLBDR0/n7rW5oCagMw6D7lGS+Jf7sDwkwEZ3WU7O3rXrUFqAKUcfAuFZJyDSmZWavWyVf4wOrgHhg70UGsZ7OXrbSNvVBu4Ht6n4DPJrOGc32WOUAAAAASUVORK5CYII="
							alt="like_button" /><b> ${map.count} Like</b></span></c:when>
							<c:otherwise><span><img name="${photo.photoID}" class="like"
							src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAB7ElEQVRIS7XVS8iNURTG8d9HhDKRgUspKbmEcksYuBRKDCSFFAZkgAwoZUa5xMB1QKKYoFzKBKWIohDFRAYykEvKRAZyaWntOh3nnPc733fsyVt7P3v997vXWs/u8p9HV4P4A7EIE3LtFe7ge512UOrGt9LVA9bjIJ7jSW6cgcnYiQs5twH78SJ1EWc6JqXuYjlMLWA31mEVXtaddgou4yz6Vugu4QyORIwCmIlrmIYPTdIyMk/7C1PxsYluBJ5iKZ4VQFDv4VRFzlcgANcrdFsxC2sL4DPiGt53qKhG4TGGF8BPDMCPDgH64xv6FcA7LMCbDgHG4hZGF8D5SAiOdQiwI0t2YwHMx4mcjCT2ZvRBNOdm3C+A+EZSDme99wawGtswG79rG20e4qomZoJ6Ahmcp1+DB7WNVoJFi3/B9p5Ex0mER4WV/B31XjQk/WULbrYJWY7j2U9fmwFifi6u5vd1NyHjIqEIyKPaPY3sOtY3pSvOwacKyDA8xD6cq9c2A4RuL5ZhYealEWco7uJK6v/RtALE2iEsweIGPhXuejuNb0+UZKMTtAKUIoh3IpomnDRsOEY8LmHvR7N3mt5iFaBsXJlWfiArb1fm6UZVEXQXEHHG4DTCeaMI3lYFb9QH3dnTlqadP2grcBH/AU5hWxnr9PQbAAAAAElFTkSuQmCC"
							alt="like_button" /><b> ${map.count} Like</b></span>
							</c:otherwise>
							</c:choose>
					</div>
				</div>
				<c:forEach items="${map.photo.comments}" var="com">
				<div class="row highLight">
				<div class="col-sm-1"><b>${com.user.username}</b></div>
				<div class="col-sm-11">${com.commentContent}</div></div>
				</c:forEach>
				<div class="row noColor">
					<div class="col-md-10">
						<input type="text" name="addComment" class="form-control"
							placeholder="Enter comment">
					</div>
					<div class="col-md-2">
						<a href="#" class="comment btn btn-primary">Post</a>
					</div>
				</div>
			</div>

		</div>


	</div>
</body>
</html>