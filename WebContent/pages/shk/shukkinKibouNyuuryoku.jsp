<!-- shukkinKibouNyuuryoku.jsp -->
<%@page import="constant.CommonConstant.DayOfWeek"%>
<%@page import="business.logic.utils.CheckUtils"%>
<%@page import="form.common.DateBean"%>
<%@page import="java.util.List"%>
<%@page import="form.mth.TsukibetsuShiftNyuuryokuForm"%>
<%
/**
 * ファイル名：shukkinKibouNyuuryoku.jsp
 *
 * 変更履歴
 * 1.0  2010/09/13 Kazuya.Naraki
 */
%>
<%@page contentType="text/html; charset=Shift_JIS" pageEncoding="Shift_JIS"%>
<%@ page import="constant.RequestSessionNameConstant"%>
<%@ page import="constant.CommonConstant"%>
<%@taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>
<%@taglib uri="http://struts.apache.org/tags-logic" prefix="logic"%>
<%@taglib uri="http://struts.apache.org/tags-html" prefix="html"%>

<bean:size id="dateBeanListSize" name="tsukibetsuShiftNyuuryokuForm" property="dateBeanList"/>
<bean:define id="color" value="" type="java.lang.String"/>
<bean:define id="shainId" name="loginUserDto" property="shainId" type="java.lang.String" />

<%
    int bodyRightDivWidth =0;
    int bodyRightDivHeight =0;
    int bodyLeftDivHeight =0;
    // ボディテーブルの td の幅
    int tdWidth = 200;       /* 修正：長野文字に幅を広げた */
    int tdWidth2 = 150; /* tdWidth2を追加し時間列を調整 */
    // ボディテーブルの tr の縦
    int trHeight = 50;
    // 縦スクロールバーの幅
    int scrollBarSize = 20;

        bodyRightDivWidth = dateBeanListSize * tdWidth+ scrollBarSize;
        bodyRightDivHeight = 402;
        bodyLeftDivHeight = 402;



%>

<html>
  <head>
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv="Cache-Control" content="no-cache">
    <meta http-equiv="Expires" content="Thu, 01 Dec 1994 16:00:00 GMT">
    <script type="text/javascript" src="/kikin_test/pages/js/common.js"></script>
    <script type="text/javascript" src="/kikin_test/pages/js/checkCommon.js"></script>
    <script type="text/javascript" src="/kikin_test/pages/js/message.js"></script>
    <script type="text/javascript" language="Javascript1.1">

    /**
     * 出勤希望反映
     */
    function submitShukkinKibou() {
        // サブミット
        doSubmit('/kikin_test/tsukibetsuShiftNyuuryokuShukkinKibou.do');
    }

    /**
     * 登録
     */
    function submitRegist() {
        // サブミット
        doSubmit('/kikin_test/syukkinKibouNyuuryokuRegist.do');
    }

    /**
     * 検索
     */
    function submitSearch() {
    	//shukkinKibouNyuuryokuSearchへ飛ぶように修正　西
        //doSubmit('/kikin_test/tsukibetsuShiftNyuuryokuSearch.do');
        doSubmit('/kikin_test/shukkinKibouNyuuryokuSearch.do');
    }

    /**
     * サブウィンドウを開く
     */
    function openWindow(){
        window.open("/kikin_test/shiftHanrei.do?param=", null, "menubar=no, toolbar=no, scrollbars=auto, resizable=yes, width=520px, height=650px");
    }
    
    </script>
    <title>出勤希望日入力</title>

    <link href="/kikin_test/pages/css/common.css" rel="stylesheet" type="text/css" />
  </head>
  <body>

    <div id="wrapper">
      <div id="header">
        <table>
          <tr>
       
            <td id="headLeft">
              <input value="戻る" type="button" class="smlButton"  onclick="doSubmit('/kikin_test/tsukibetsuShiftNyuuryokuBack.do')" />
            </td>
            <td id="headCenter">
              出勤希望日入力
            </td>
            <td id="headRight">
            <!-- 修正＆追加 有吉　htmlタグをコメントアウトinputタグ記載に修正 -->
              <input value="ログアウト" type="button" class="smlButton"  onclick="doSubmit('/kikin_test/logout.do')" />
            </td>
          </tr>
        </table>
      </div>
      <div id="gymBody" style="overflow: hidden;" >
      <div style="margin-left:20px;">
      
         <div id="bodyLeftTbl" ;height:120px; ">
        <html:form action="/tsukibetsuShiftNyuuryokuInit.do" >
          <div style="margin-left:25px;">
            <div style="height: 25px;">
            
              表示年月：
              <bean:define id="sessionYearMonth" name="tsukibetsuShiftNyuuryokuForm" property="yearMonth" type="String"/>
              
              <html:select property="yearMonth" name="tsukibetsuShiftNyuuryokuForm"  onchange="submitSearch()">
              <html:optionsCollection name="tsukibetsuShiftNyuuryokuForm"
                                      property="yearMonthCmbMap"
                                      value="key"
                                      label="value"/>
                                            
              </html:select>
            </div>
            </div>
            
            <!--newテーブル -->
            
            
            
            
            
            
            
            <!-- 右側テーブル --> 
            
            <table width="1450px" cellpadding="0" cellspacing="0" border="1"> 
    
				<tr class="tblHeader">
					<td ></td>
					<td width="40px" align="center">1</td>
					<td width="40px" align="center">2</td>
					<td width="40px" align="center">3</td>
					<td width="40px" align="center">4</td>
					<td width="40px" align="center">5</td>
					<td width="40px" align="center">6</td>
					<td width="40px" align="center">7</td>
					<td width="40px" align="center">8</td>
					<td width="40px" align="center">9</td>
					<td width="40px" align="center">10</td>
					<td width="40px" align="center">11</td>
					<td width="40px" align="center">12</td>
					<td width="40px" align="center">13</td>
					<td width="40px" align="center">14</td>
					<td width="40px" align="center">15</td>
					<td width="40px" align="center">16</td>
					<td width="40px" align="center">17</td>
					<td width="40px" align="center">18</td>
					<td width="40px" align="center">19</td>
					<td width="40px" align="center">20</td>
					<td width="40px" align="center">21</td>
					<td width="40px" align="center">22</td>
					<td width="40px" align="center">23</td>
					<td width="40px" align="center">24</td>
					<td width="40px" align="center">25</td>
					<td width="40px" align="center">26</td>
					<td width="40px" align="center">27</td>
<%
if (dateBeanListSize >= 28) {
%>
					<td width="40px" align="center">28</td>
<%
}
if (dateBeanListSize >= 29) {
%>
					<td width="40px" align="center">29</td>
<%
}
if (dateBeanListSize >= 30) {
%>
					<td width="40px" align="center">30</td>
<%
}
if (dateBeanListSize == 31) {
%>
					<td width="40px" align="center">31</td>
<%
}
%>
				</tr>
		
				
				
				<tr class="tblHeader">
					<td width="200px" align="center">社員名</td>
					<logic:iterate
						id="dateBeanList"
						name="tsukibetsuShiftNyuuryokuForm"
						property="dateBeanList"
					>
						<bean:define id="youbi" name="dateBeanList" property="youbi" />
						<!-- 祝日のフォントを赤にするための追記　西 -->
						<bean:define id="shukujitsuFlg" name="dateBeanList" property="shukujitsuFlg"/>
						<%
						if (DayOfWeek.SATURDAY.getRyaku().equals(youbi)) {
							color = "fontBlue";
						} else if (DayOfWeek.SUNDAY.getRyaku().equals(youbi)) {
							color = "fontRed";
						 } else if ((boolean)shukujitsuFlg){
                       		color = "fontRed";
						} else {
							color = "fontBlack";
						}
						%>
						<td width="40px" align="center" class="<%=color%>">
						<!-- 祝日の表記を”祝”にするための追記　西 -->
						<%
	                       if ((boolean)shukujitsuFlg){
                   	   %>
                   	    	祝
                   	    <%
	                       } else{
                   	   	%>
							<bean:write property="youbi" name="dateBeanList" />
						<%
	                       }
	                     %>
						</td>
					</logic:iterate>
				</tr>
				<logic:iterate
					offset="offset"
					id="tsukibetsuShiftNyuuryokuBeanList"
					name="tsukibetsuShiftNyuuryokuForm"
					property="tsukibetsuShiftNyuuryokuBeanList"
				>
					<logic:equal value="${shainId }" name="tsukibetsuShiftNyuuryokuBeanList" property="shainId">
					<html:hidden name="tsukibetsuShiftNyuuryokuBeanList" property="registFlg" value="true" indexed="true"/>
						<tr height="20px" class="tblBody">
							<td width="200px" align="center">
								<bean:write property="shainName" name="tsukibetsuShiftNyuuryokuBeanList" />
							</td>
							<td width="40px" align="center" valign="middle">
								<html:select
									property="shiftId01"
									name="tsukibetsuShiftNyuuryokuBeanList"
									indexed="true">
									<html:optionsCollection
										name="tsukibetsuShiftNyuuryokuForm"
										property="shiftCmbMap"
										value="key"
										label="value" />
								</html:select>
							</td>
							<td width="40px" align="center" valign="middle">
								<html:select
									property="shiftId02"
									name="tsukibetsuShiftNyuuryokuBeanList"
									indexed="true">
									<html:optionsCollection
										name="tsukibetsuShiftNyuuryokuForm"
										property="shiftCmbMap"
										value="key"
										label="value" />
								</html:select>
							</td>
							<td width="40px" align="center" valign="middle">
								<html:select
									property="shiftId03"
									name="tsukibetsuShiftNyuuryokuBeanList"
									indexed="true">
									<html:optionsCollection
										name="tsukibetsuShiftNyuuryokuForm"
										property="shiftCmbMap"
										value="key"
										label="value" />
								</html:select>
							</td>
							<td width="40px" align="center" valign="middle">
								<html:select
									property="shiftId04"
									name="tsukibetsuShiftNyuuryokuBeanList"
									indexed="true">
									<html:optionsCollection
										name="tsukibetsuShiftNyuuryokuForm"
										property="shiftCmbMap"
										value="key"
										label="value" />
								</html:select>
							</td>
							<td width="40px" align="center" valign="middle">
								<html:select
									property="shiftId05"
									name="tsukibetsuShiftNyuuryokuBeanList"
									indexed="true">
									<html:optionsCollection
										name="tsukibetsuShiftNyuuryokuForm"
										property="shiftCmbMap"
										value="key"
										label="value" />
								</html:select>
							</td>
							<td width="40px" align="center" valign="middle">
								<html:select
									property="shiftId06"
									name="tsukibetsuShiftNyuuryokuBeanList"
									indexed="true">
									<html:optionsCollection
										name="tsukibetsuShiftNyuuryokuForm"
										property="shiftCmbMap"
										value="key"
										label="value" />
								</html:select>
							</td>
							<td width="40px" align="center" valign="middle">
								<html:select
									property="shiftId07"
									name="tsukibetsuShiftNyuuryokuBeanList"
									indexed="true">
									<html:optionsCollection
										name="tsukibetsuShiftNyuuryokuForm"
										property="shiftCmbMap"
										value="key"
										label="value" />
								</html:select>
							</td>
							<td width="40px" align="center" valign="middle">
								<html:select
									property="shiftId08"
									name="tsukibetsuShiftNyuuryokuBeanList"
									indexed="true">
									<html:optionsCollection
										name="tsukibetsuShiftNyuuryokuForm"
										property="shiftCmbMap"
										value="key"
										label="value" />
								</html:select>
							</td>
							<td width="40px" align="center" valign="middle">
								<html:select
									property="shiftId09"
									name="tsukibetsuShiftNyuuryokuBeanList"
									indexed="true">
									<html:optionsCollection
										name="tsukibetsuShiftNyuuryokuForm"
										property="shiftCmbMap"
										value="key"
										label="value" />
								</html:select>
							</td>
							<td width="40px" align="center" valign="middle">
								<html:select
									property="shiftId10"
									name="tsukibetsuShiftNyuuryokuBeanList"
									indexed="true">
									<html:optionsCollection
										name="tsukibetsuShiftNyuuryokuForm"
										property="shiftCmbMap"
										value="key"
										label="value" />
								</html:select>
							</td>
							<td width="40px" align="center" valign="middle">
								<html:select
									property="shiftId11"
									name="tsukibetsuShiftNyuuryokuBeanList"
									indexed="true">
									<html:optionsCollection
										name="tsukibetsuShiftNyuuryokuForm"
										property="shiftCmbMap"
										value="key"
										label="value" />
								</html:select>
							</td>
							<td width="40px" align="center" valign="middle">
								<html:select
									property="shiftId12"
									name="tsukibetsuShiftNyuuryokuBeanList"
									indexed="true">
									<html:optionsCollection
										name="tsukibetsuShiftNyuuryokuForm"
										property="shiftCmbMap"
										value="key"
										label="value" />
								</html:select>
							</td>
							<td width="40px" align="center" valign="middle">
								<html:select
									property="shiftId13"
									name="tsukibetsuShiftNyuuryokuBeanList"
									indexed="true">
									<html:optionsCollection
										name="tsukibetsuShiftNyuuryokuForm"
										property="shiftCmbMap"
										value="key"
										label="value" />
								</html:select>
							</td>
							<td width="40px" align="center" valign="middle">
								<html:select
									property="shiftId14"
									name="tsukibetsuShiftNyuuryokuBeanList"
									indexed="true">
									<html:optionsCollection
										name="tsukibetsuShiftNyuuryokuForm"
										property="shiftCmbMap"
										value="key"
										label="value" />
								</html:select>
							</td>
							<td width="40px" align="center" valign="middle">
								<html:select
									property="shiftId15" 
									name="tsukibetsuShiftNyuuryokuBeanList"
									indexed="true">
									<html:optionsCollection 
										name="tsukibetsuShiftNyuuryokuForm"
										property="shiftCmbMap" 
										value="key" 
										label="value" />
								</html:select>
							</td>
							<td width="40px" align="center" valign="middle">
								<html:select
									property="shiftId16"
									name="tsukibetsuShiftNyuuryokuBeanList"
									indexed="true">
									<html:optionsCollection
										name="tsukibetsuShiftNyuuryokuForm"
										property="shiftCmbMap"
										value="key"
										label="value" />
								</html:select>
							</td>
							<td width="40px" align="center" valign="middle">
								<html:select
									property="shiftId17"
									name="tsukibetsuShiftNyuuryokuBeanList"
									indexed="true">
									<html:optionsCollection
										name="tsukibetsuShiftNyuuryokuForm"
										property="shiftCmbMap"
										value="key"
										label="value" />
								</html:select>
							</td>
							<td width="40px" align="center" valign="middle">
								<html:select
									property="shiftId18"
									name="tsukibetsuShiftNyuuryokuBeanList"
									indexed="true">
									<html:optionsCollection
										name="tsukibetsuShiftNyuuryokuForm"
										property="shiftCmbMap"
										value="key"
										label="value" />
								</html:select>
							</td>
							<td width="40px" align="center" valign="middle">
								<html:select
									property="shiftId19"
									name="tsukibetsuShiftNyuuryokuBeanList"
									indexed="true">
									<html:optionsCollection
										name="tsukibetsuShiftNyuuryokuForm"
										property="shiftCmbMap"
										value="key"
										label="value" />
								</html:select>
							</td>
							<td width="40px" align="center" valign="middle">
								<html:select
									property="shiftId20"
									name="tsukibetsuShiftNyuuryokuBeanList"
									indexed="true">
									<html:optionsCollection
										name="tsukibetsuShiftNyuuryokuForm"
										property="shiftCmbMap"
										value="key"
										label="value" />
								</html:select>
							</td>
							<td width="40px" align="center" valign="middle">
								<html:select
									property="shiftId21"
									name="tsukibetsuShiftNyuuryokuBeanList"
									indexed="true">
									<html:optionsCollection
										name="tsukibetsuShiftNyuuryokuForm"
										property="shiftCmbMap"
										value="key"
										label="value" />
								</html:select>
							</td>
							<td width="40px" align="center" valign="middle">
								<html:select
									property="shiftId22"
									name="tsukibetsuShiftNyuuryokuBeanList"
									indexed="true">
									<html:optionsCollection
										name="tsukibetsuShiftNyuuryokuForm"
										property="shiftCmbMap"
										value="key"
										label="value" />
								</html:select>
							</td>
							<td width="40px" align="center" valign="middle">
								<html:select
									property="shiftId23"
									name="tsukibetsuShiftNyuuryokuBeanList"
									indexed="true">
									<html:optionsCollection
										name="tsukibetsuShiftNyuuryokuForm"
										property="shiftCmbMap"
										value="key"
										label="value" />
								</html:select>
							</td>
							<td width="40px" align="center" valign="middle">
								<html:select
									property="shiftId24"
									name="tsukibetsuShiftNyuuryokuBeanList"
									indexed="true">
									<html:optionsCollection
										name="tsukibetsuShiftNyuuryokuForm"
										property="shiftCmbMap"
										value="key"
										label="value" />
								</html:select>
							</td>
							<td width="40px" align="center" valign="middle">
								<html:select
									property="shiftId25"
									name="tsukibetsuShiftNyuuryokuBeanList"
									indexed="true">
									<html:optionsCollection
										name="tsukibetsuShiftNyuuryokuForm"
										property="shiftCmbMap"
										value="key"
										label="value" />
								</html:select>
							</td>
							<td width="40px" align="center" valign="middle">
								<html:select
									property="shiftId26"
									name="tsukibetsuShiftNyuuryokuBeanList"
									indexed="true">
									<html:optionsCollection
										name="tsukibetsuShiftNyuuryokuForm"
										property="shiftCmbMap"
										value="key"
										label="value" />
								</html:select>
							</td>
							<td width="40px" align="center" valign="middle">
								<html:select
									property="shiftId27"
									name="tsukibetsuShiftNyuuryokuBeanList"
									indexed="true">
									<html:optionsCollection
										name="tsukibetsuShiftNyuuryokuForm"
										property="shiftCmbMap"
										value="key"
										label="value" />
								</html:select>
							</td>
<%
if (dateBeanListSize >= 28) {
%>
							<td width="40px" align="center" valign="middle">
								<html:select
									property="shiftId28"
									name="tsukibetsuShiftNyuuryokuBeanList"
									indexed="true">
									<html:optionsCollection
										name="tsukibetsuShiftNyuuryokuForm"
										property="shiftCmbMap"
										value="key"
										label="value" />
								</html:select>
							</td>
<%
}
if (dateBeanListSize >= 29) {
%>
							<td width="40px" align="center" valign="middle">
								<html:select
									property="shiftId29"
									name="tsukibetsuShiftNyuuryokuBeanList"
									indexed="true">
									<html:optionsCollection
										name="tsukibetsuShiftNyuuryokuForm"
										property="shiftCmbMap"
										value="key"
										label="value" />
								</html:select>
							</td>
<%
}
if (dateBeanListSize >= 30) {
%>
							<td width="40px" align="center" valign="middle">
								<html:select
									property="shiftId30"
									name="tsukibetsuShiftNyuuryokuBeanList"
									indexed="true">
									<html:optionsCollection
										name="tsukibetsuShiftNyuuryokuForm"
										property="shiftCmbMap"
										value="key"
										label="value" />
								</html:select>
							</td>
<%
}
if (dateBeanListSize >= 31) {
%>
							<td width="40px" align="center" valign="middle">
								<html:select
									property="shiftId31"
									name="tsukibetsuShiftNyuuryokuBeanList"
									indexed="true">
									<html:optionsCollection
										name="tsukibetsuShiftNyuuryokuForm"
										property="shiftCmbMap"
										value="key"
										label="value" />
								</html:select>
							</td>
<%
}
%>
						</tr>
					</logic:equal>
				</logic:iterate>
			</table>
          </div>      

        </html:form>
   
        <table>
      <div id="footer">
           <div style="margin-left:50px;">

          <input value="凡例表示" type="button" class="lngButton"  onclick="openWindow()" />
        </div>

          <tr>
            <td id="footLeft">
            </td>
            <td id="footCenter" style="text-align: right;">
				
            </td>
            <td id="footRight">
            	<input value="出勤希望日参照" type="button" class="lngButton" onclick="window.open('./shukkinKibouKakuninInit.do')" />
            	<input value="登録" type="button" class="smlButton"  onclick="submitRegist()" />
            </td>
          </tr>
        </table>
      </div>
    </div>
       </div>
  </body>
</html>