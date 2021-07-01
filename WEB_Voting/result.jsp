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
		tr:hover {
			background: rgb(218, 218, 218);
		}

		tr:first-child:hover {
			background-color: rgb(58, 58, 58);
		}
		a {
			text-decoration: none;
			color: black;
		}
	</style>
	<link rel="stylesheet" href="externalCSS.css">
	</head>
	<body>
		
		<%
		Class.forName("com.mysql.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.71:3306/kopo36", "root", "wjdthdud12");
		Statement stmt = conn.createStatement();
		
		int total = 0;
		ResultSet rset = stmt.executeQuery("select count(*) from voting;");
		while (rset.next()) {
			total = rset.getInt(1);
		}
		rset.close();
		
		if (total == 0) {
			out.println("결과를 표시할 표가 없습니다. 투표를 먼저 진행해주세요.");
			out.println("<br><a href=vote.jsp target=main>투표하러 가기</a>");
		} else {
			rset = stmt.executeQuery("select *, " 
										+ "(select count(id) from voting where a.id=id group by id), " 
										+ "((select count(id) from voting where a.id=id group by id)/(select count(*) from voting))*100 "
										+ "from candidates1 as a; ");

		%>
		
		<table>
			<tr class="header">
				<td>후보</td>
				<td>득표율</td>
			</tr>

		<%
			String candidate = "";
			int obtainedVotes = 0;
			int percentage = 0;
			
			while (rset.next()) {
			candidate = Integer.toString(rset.getInt(1)) + "번 " + rset.getString(2);
			obtainedVotes = rset.getInt(3);
			percentage = Math.round(rset.getInt(4));
			
			out.println("<tr>");
			out.println("<td><a href=Canresult.jsp?key1=" + rset.getInt(1) + ">" + candidate +"</a></td>");	
			out.println("<td><img src=bar.png width=" + percentage + "% height=10>" + obtainedVotes +"(" + percentage +"%)</td>");
			out.println("</tr>");
			}

		}
		
		rset.close();
		stmt.close();
		conn.close();
		%>
		
		</table>
	</body>
</html>