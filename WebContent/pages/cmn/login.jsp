<!-- login.jsp -->
<%@page contentType="text/html; charset=Shift_JIS" pageEncoding="Shift_JIS"%>
<%@taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>
<%@taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<%
String check = (String)session.getAttribute("miss");
%>
<html>
<head>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache">
<meta http-equiv="Expires" content="Thu, 01 Dec 1994 16:00:00 GMT">
<html:javascript formName="loginForm" />
<title>ログイン画面</title>
<link href="/kikin_test/pages/css/common.css" rel="stylesheet"
	type="text/css" />

<!-- 文字化け解消 message.jsを呼び出している箇所にcharset="utf-8を追加 -->
<script type="text/javascript" src="/kikin_test/pages/js/message.js"
	charset="utf-8"></script>
<script type="text/javascript" language="Javascript1.1">

	// ID・パスワードが違う場合エラーメッセージを表示
 	var errorMsg = '';
	if ('<%=check %>' == 'miss') {
		errorMsg = getMessage('E-MSG-000002', "");
		alert(errorMsg);
  	}
	</script>
</head>
<body>
	<div class="picture">
		<div id="wrapper">
			<div id="header">
				<div align="center">
					<table>
						<tr>
							<td id="headLeft"></td>
							<td id="headCenter">ログイン　　　　　</td>
							<td id="headRight"></td>
						</tr>
					</table>
				</div>
			</div>


			<div id="gymBody">
				<div align="center">
					<div>ID・パスワードを入力してください。</div>
					<html:form action="/login"
						onsubmit="return validateLoginForm(this)">
						<html:text property="shainId" size="16" value="" />
						<br />
						<html:password property="password" size="16" redisplay="false"
							value="" />
						<br />
						<br />
						<html:submit property="submit" value="ログイン" />
						<html:reset value="リセット" />
					</html:form>
				</div>
			</div>
			<div id="footer">
				<table>
					<tr>
						<td id="footLeft"></td>
						<td id="footCenter"></td>
						<td id="footRight"></td>
					</tr>
				</table>
			</div>

		</div>
	</div>
</body>
</html>