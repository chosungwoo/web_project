<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*" import="java.sql.*"%>
<%
	
	try{
		Class.forName("com.mysql.jdbc.Driver");
	}catch(ClassNotFoundException e){
		e.printStackTrace();
	}
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	
	String dbUrl = "jdbc:mysql://localhost:3306/web_project";
	String dbUser = "root";
	String dbPassword="cjstk2972";
	conn = DriverManager.getConnection (dbUrl, dbUser, dbPassword);
	
	stmt=conn.createStatement();
%>

<!DOCTYPE html>
<html lang ="ko">
	<head>
		<meta charset="utf-8">
		<title>mainpage</title>
		
		<link href="./stylesheets/main.css" rel = "stylesheet" type="text/css">
		<link href="./stylesheets/reset.css" rel = "stylesheet" type="text/css">
		<link href="./stylesheets/bootstrap.min.css" rel = "stylesheet" type="text/css">
		<link href="./stylesheets/joincontent.css" rel = "stylesheet" type="text/css">
		
		<script src = './js/jquery-1.8.3.min.js'></script>
		<script src = './js/bootstrap.min.js'></script>
		<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.6.4/jquery.min.js"></script>
		<script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=false"></script>
		<link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/base/jquery-ui.css" rel="stylesheet" type="text/css"/>
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7/jquery.min.js"></script>
    <script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js"></script> 

    
		<script type="text/javascript">
			$(document).ready(function() {
			    var latlng = new google.maps.LatLng(37.5640, 126.9751);
			    var myOptions = {
			  	      zoom : 19,
			  	      center : latlng,
			  	      mapTypeId : google.maps.MapTypeId.ROADMAP
			  	}
			    var map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);
			    var marker = new google.maps.Marker({
					position : latlng, 
		    		map : map
		    	});

			    var geocoder = new google.maps.Geocoder();

			    google.maps.event.addListener(map, 'click', function(event) {
			    	var location = event.latLng;
			    	geocoder.geocode({
			    		'latLng' : location
			    	}, function(results, status){
			    		if( status == google.maps.GeocoderStatus.OK ) {
			    			$('#address').val(results[0].formatted_address);
			    			$('#lat').html(results[0].geometry.location.lat());
			    			$('#lng').html(results[0].geometry.location.lng());
			    		}
			    		else {
			    			alert("Geocoder failed due to: " + status);
			    		}
			    	});
			    	if( !marker ) {
			    		marker = new google.maps.Marker({
			    			position : location, 
				    		map : map
				    	});
			    	}
			    	else {
			    		marker.setMap(null);
			    		marker = new google.maps.Marker({
			    			position : location, 
				    		map : map
				    	});
			    	}
			    	map.setCenter(location);
			    });

			$("#search").click(function(){
			    var address = $("#address").val();
			    if( address != '') {
			    		geocoder.geocode({
							'address' : address
						}, function(results, status){
							if( status == google.maps.GeocoderStatus.OK ) {
								map.setCenter(results[0].geometry.location);
								if( !marker ) {
						    		marker = new google.maps.Marker({
						    			position : results[0].geometry.location, 
							    		map : map
							    	});
						    	}
						    	else {
						    		marker.setMap(null);
						    		marker = new google.maps.Marker({
						    			position :  results[0].geometry.location, 
							    		map : map
							    	});
						    	}
							}
							else {
								alert("잘못된 장소입니다.");
							}
						});
			    	}
		    });
		    $("#address").keydown(function(event){
		    	if(event.keyCode == 13)
		    		$("#search").click();
		    });
		});
		</script>
	
		<!-- Modal1 -->
		<jsp:include page ="share/modal.jsp">
				<jsp:param name="modal"  value="modal"/>
		</jsp:include>	
	</head>
<!--body-->
	<body>
	<jsp:include page ="share/header.jsp">
				<jsp:param name="header"  value="header"/>
	</jsp:include>	
		<div id="wrap">			
		<br/><br/>
			<div id="container">
					<div id="p_image">
									<div id="map_canvas" style="width: 200px; height: 200px;"></div>	
						</div>
						<div id="introduce">
								
								<h1>제목</h1>
								<p>안녕하세요 ooo입니다. 저희는 친목을 위해 00/00 에 응원을 가려고합니다.</p>
						</div>
						<div id="navbar">
							<ul class="nav nav-tabs">
							  <li class="active">
							    <a href="#intro" data-toggle="tab">Intro</a>
							  </li>
							  <li><a href="#date" data-toggle="tab">일정</a></li>
							 
							</ul>
							<div class="tab-content">
							  <div class="tab-pane active" id="intro"><% 	rs = stmt.executeQuery("SELECT intro, date FROM post, tabcontent where post.p_number=tabcontent.p_number");%>
							  	
							  	<%
							  	
							  	if(rs.next()){
							  		out.println(rs.getString("intro"));
							  									}
							  	%>							  	
							  </div>
							  <div class="tab-pane" id="date">날짜는 <%
							  %>
							  입니다.
							  </div>
							  <div class="tab-pane" id="place">장소는 이곳입니다.
							 </div>
							</div>
						</div>
					</div>
			</div>
			
			
			<div id="footer">
				<p>사이트 소개 | 이용약관 | 개인정보취급방침 | 책임의 한계와 법적 |</p>
					<p>
						Copyright ⓒ MJUCafe. All rights reserved
					</p>
			</div>
		</div>
		
	</body>
</html>

