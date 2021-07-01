<meta htty-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<%@ page errorPage="error.jsp" %>

<script LANGUAGE="JavaScript">

function koreanCheck(msg){
	var reg=/[a-z0-9]|[ \[\]{}()<>?|`~!@#$%^&*-_+=,.;:\"'\\]/g;
	if(reg.test(msg)){
		alert('이름 칸에 공백없이 한글만 입력해주세요');
		document.inputForm.name1.value='';
		document.inputForm.name1.focus();
	}
}

function checkSubmitValue(form) {
	var e = form.elements;
	for ( var i = 0; i < e.length; i++ ) {
		if ( e[i].tagName == 'INPUT'  && e[i].value == '' ) {
			alert('빈칸에 값을 입력해 주세요');
			return false;
		}
	}
	return true;
}

//-->
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
		<table>
			<tr class="header">
				<td colspan="3">등록된 후보</td>
			</tr>
		<%
		Class.forName("com.mysql.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.71:3306/kopo36", "root", "wjdthdud12");
		Statement stmt = conn.createStatement();
		ResultSet rset = stmt.executeQuery("select * from candidates1;");

		while (rset.next()) {
			out.println("<tr>");
			out.println("<form method=&rdquo;post&rdquo; action=deleteCan.jsp>");
			out.println("<td>기호 : <input type=text name=canNum value=" + Integer.toString(rset.getInt(1)) +" readonly></td>");	
			out.println("<td>이름 : <input type=text value=" + rset.getString(2) + " readonly></td>");
			out.println("<td><input type=submit value=삭제></td>");
			out.println("</form>");
			out.println("</tr>");
		}
		rset.close();
		
		int nextNum = 0; 
		int maxNum = 0;
		rset = stmt.executeQuery("select max(id) from candidates1;");
		
		while(rset.next()) {
			maxNum = rset.getInt(1);
		}
		
		if (maxNum == 0) {
			nextNum = 1; 
		} else {		
			nextNum = maxNum + 1; 
		}
		rset.close();
		
		stmt.close();
		conn.close();
		%>
		<tr class="header">
			<td colspan="3">새로운 후보 등록</td>
		</tr>

			<form method="post" action="./addCan.jsp" onsubmit='return checkSubmitValue(this)'>
				<tr>
					<td>기호 : <input type="number" value=<%=nextNum %> name="canNum" readonly></td>
					<td>이름 : <input type="text" name="canName" onblur=koreanCheck(this.value)></td>
					<td><input type="submit" value="추가"></td>
				</tr>
			</form>
		</table>
	</body>
</html>