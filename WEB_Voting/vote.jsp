<meta htty-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<%@ page errorPage="error.jsp" %>

<script>
function checkSubmitValue(form) {
	var e = form.elements;
	for ( var i = 0; i < e.length; i++ ) {
		if ( e[i].tagName == 'select'  && e[i].value == '' ) {
			alert('빈칸을 확인해주세요');
			return false;
		}
	}
	return true;
}
</script>

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
<link rel="stylesheet" href="externalCSS.css">
</head>
<body>

<%
		Class.forName("com.mysql.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.71:3306/kopo36", "root", "wjdthdud12");
		Statement stmt = conn.createStatement();
		
		ResultSet rset = stmt.executeQuery("select count(*) from candidates1;");
		int temp = 0;
		while (rset.next()) {
			temp = rset.getInt(1);
		}
		rset.close();
		
		if(temp == 0) {
		out.println("등록된 후보가 없습니다. 후보를 먼저 등록해주세요.");
		out.println("<br><a href=signup.jsp target=main>후보 등록하러 가기</a>");

		} else {
		
%>
	<table>
		<tr class="header">
			<td colspan="3">투표 진행</td>
		</tr>
		<form method="post" action="voteAdd.jsp" onsubmit="return checkSubmitValue(this)">
		<tr>
			<td>
			후보 
			<select name="selectCan" >
			<option value="" selected disabled hidden>==선택하세요==</option>							

<%
			rset = stmt.executeQuery("select * from candidates1;");

			while (rset.next()) {
				out.println("<option value=" + rset.getInt(1) + ">");
				out.println(rset.getInt(1) +"번 " + rset.getString(2));
				out.println("</option>");
			}
			rset.close();
		

%>
		</select>
		</td>
		<td>
		연령대
		<select name="selectAge" width="30">
		<option value="" selected disabled hidden>==선택하세요==</option>
		<option value="1">10대</option>
		<option value="2">20대</option>
		<option value="3">30대</option>
		<option value="4">40대</option>
		<option value="5">50대</option>
		<option value="6">60대</option>
		<option value="7">70대</option>
		<option value="8">80대</option>
		<option value="9">90대</option>
		
		</select>
		</td>
		<td>
		<input type="submit" value="투표하기">
		</td>
	</tr>
	</form>
<% 
	} 
%>
	
</body>
</html>
