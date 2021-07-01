<meta htty-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>

<html>
	<head>
		<style>
			@font-face {
			font-family: 'NanumBarunGothic';
			font-style: normal;
			font-weight: 400;
			src: url('//cdn.jsdelivr.net/font-nanumlight/1.0/NanumBarunGothicWeb.eot');
			src: url('//cdn.jsdelivr.net/font-nanumlight/1.0/NanumBarunGothicWeb.eot?#iefix') format('embedded-opentype'), url('//cdn.jsdelivr.net/font-nanumlight/1.0/NanumBarunGothicWeb.woff') format('woff'), url('//cdn.jsdelivr.net/font-nanumlight/1.0/NanumBarunGothicWeb.ttf') format('truetype');
			}

			body{
				font-family: 'NanumBarunGothic';
			}
		</style>
	</head>
	<body>
		<%
		request.setCharacterEncoding("UTF-8");
		
		String newName = request.getParameter("canName");
		String newNum = request.getParameter("canNum");

		Class.forName("com.mysql.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.71:3306/kopo36", "root", "wjdthdud12");
		Statement stmt = conn.createStatement();
		
		stmt.execute("insert into candidates1 (id, name) values (" + newNum + ", " +
													"'" + newName + "');"); 
													
		stmt.close();
		conn.close();
		%>
		
		<h3>후보 추가 입력 완료</h3>
		<p>입력한 후보가 추가 되었습니다.</p>
		<button onClick="location.href = document.referrer;">뒤로 가기</button>
		
	</body>
</html>