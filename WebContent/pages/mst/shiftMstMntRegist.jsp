<!-- shiftMstMntRegist.jsp -->
<%@page import="business.logic.utils.CheckUtils"%>
<%@page import="form.mst.ShiftMstMntBean"%>
<%@page import="java.util.List"%>
<%@page import="form.mst.ShiftMstMntForm"%>
<%
/**
 * �t�@�C�����FshiftMstMntRegist.jsp
 *
 * �ύX����
 * 1.0  2010/09/13 Kazuya.Naraki
 */
%>
<%@page contentType="text/html; charset=Shift_JIS" pageEncoding="Shift_JIS"%>
<%@ page import="constant.RequestSessionNameConstant"%>
<%@ page import="constant.CommonConstant"%>
<%@taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>
<%@taglib uri="http://struts.apache.org/tags-logic" prefix="logic"%>
<%@taglib uri="http://struts.apache.org/tags-html" prefix="html"%>

<html>
  <head>
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv="Cache-Control" content="no-cache">
    <meta http-equiv="Expires" content="Thu, 01 Dec 1994 16:00:00 GMT">
    <script type="text/javascript" src="/kikin_test/pages/js/common.js"></script>
    <script type="text/javascript" src="/kikin_test/pages/js/checkCommon.js"></script>
    <script type="text/javascript" src="/kikin_test/pages/js/message.js" charset="utf-8"></script>
    <script type="text/javascript" language="Javascript1.1">

    /**
     * �o�^�������s��
     */
    function shiftMstMntRegist() {

    	//�J�n���ԋ󔒃G���[���b�Z�[�W�@�ǉ��F����
    	var startTimeNullErrMsg = '';    	
    	//�I�����ԋ󔒃G���[���b�Z�[�W�@�ǉ��F����
    	var endTimeNullErrMsg = '';
    	//�x�e���ԋ󔒃G���[���b�Z�[�W�@�ǉ��F����
    	var breakTimeNullErrMsg = '';
    	
        // �J�n���ԃG���[���b�Z�[�W
        var startTimeErrMsg = '';
        // �I�����ԃG���[���b�Z�[�W
        var endTimeErrMsg = '';
        // �x�e���ԃG���[���b�Z�[�W
        var breakTimeErrMsg = '';
        // �G���[���b�Z�[�W
        var errorMsg = '';
        // From - To �G���[���b�Z�[�W
        var fromToErrMsg = '';
     	// �G���[���b�Z�[�W
     	var errorMsg = '';

        // ���ԃ`�F�b�N
        with (document.forms[0]) {
          // �J�n���Ԃ��擾����B
          var varStartTime = startTime.value;
          // �I�����Ԃ��擾����B
          var varEndTime = endTime.value;
          // �x�e���Ԃ��擾����B
          var varBreakTime = breakTime.value;

          // �w�i�F���N���A����
          startTime.style.backgroundColor = 'white';
          endTime.style.backgroundColor = 'white';
          breakTime.style.backgroundColor = 'white';
          
          
          //�󔒓o�^���ɃG���[�\���@����
          if (!checkRequired(varStartTime)) {
                var strArr = ['�J�n����'];
                startTimeNullErrMsg = getMessage('E-MSG-000001', strArr);
                startTime.style.backgroundColor = 'red';
            }
          
          if (!checkRequired(varEndTime)) {
              var strArr = ['�I������'];
              endTimeNullErrMsg = getMessage('E-MSG-000001', strArr);
              endTime.style.backgroundColor = 'red';
          }
          
          if (!checkRequired(varBreakTime)) {
              var strArr = ['�x�e����'];
              breakTimeNullErrMsg = getMessage('E-MSG-000001', strArr);
              breakTime.style.backgroundColor = 'red';
          }

      	 
          if (!checkTime(varStartTime)) {
              var strArr = ['�J�n����'];
              startTimeErrMsg = getMessage('E-MSG-000004', strArr);
              startTime.style.backgroundColor = 'red';
          }

          if (!checkTime(varEndTime)) {
              var strArr = ['�I������'];
              endTimeErrMsg = getMessage('E-MSG-000004', strArr);
              endTime.style.backgroundColor = 'red';
          }

          if (!checkTime(varBreakTime)) {
              var strArr = ['�x�e����'];
              breakTimeErrMsg = getMessage('E-MSG-000004', strArr);
              breakTime.style.backgroundColor = 'red';
          }
          

          // from - to �̃`�F�b�N
          if (!checkTimeCompare(varStartTime, varEndTime)) {
        	  //�J�n���ԁ��I�����Ԃ̎��G���[�\������Ȃ������̂��C���@�L�g
            if (checkTime(varStartTime) && checkTime(varEndTime)) {
            	fromToErrMsg = getMessageCodeOnly('E-MSG-000005');
                startTime.style.backgroundColor = 'red';
                endTime.style.backgroundColor = 'red';
            }
          }
        }

        // �G���[���b�Z�[�W
        errorMsg = startTimeNullErrMsg + endTimeNullErrMsg + breakTimeNullErrMsg + startTimeErrMsg + endTimeErrMsg + breakTimeErrMsg + fromToErrMsg;

        if (errorMsg) {
            alert(errorMsg);
            // �G���[
            return false;
        }
        // �T�u�~�b�g
        doSubmit('/kikin_test/shiftMstMntRegist.do');
    }
    

    </script>

    <title>�V�t�g�}�X�^�����e�i���X���</title>

    <link href="/kikin_test/pages/css/common.css" rel="stylesheet" type="text/css" />
  </head>
  <body>
    <div id="wrapper">
      <div id="header">
        <table>
          <tr>
            <td id="headLeft">
              <input value="�߂�" type="button" class="smlButton"  onclick="doSubmit('/kikin_test/shiftMstMntRegistBack.do')" />
            </td>
            <td id="headCenter">
              �V�t�g�}�X�^�����e�i���X�i�V�K�o�^�j
            </td>
            <td id="headRight">
              <!-- �C�����ǉ� �L�g�@html�^�O���R�����g�A�E�ginput�^�O�L�ڂɏC�� --> 
				<input value="���O�A�E�g" type="button" class="smlButton" onclick="doSubmit('/kikin_test/logout.do')" />
            </td>
          </tr>
        </table>
      </div>
      <div id="gymBody">
        <html:form action="/shiftMstMntRegist">
          <div style="width: 630px; margin-left:300px;">
            <table class="tblHeader" border="1" cellpadding="0" cellspacing="0">
              <tr>
                <td width="120px" align="center">
                  �V�t�g��
                </td>
                <td width="70px" align="center">
                  �V���{��
                </td>
                <td width="230px" align="center">
                  ����
                </td>
                <td width="100px" align="center">
                  �x�e
                </td>
              </tr>
            </table>
          </div>
          <div style="overflow: auto; height: 400px; width: 630px; margin-left:300px;">
            <table class="tblBody" border="1" cellpadding="0" cellspacing="0">
              <tr>
                <td width="120px"  align="center">
                  <html:text property="shiftName" size="10" maxlength="10" />
                </td>
                <td width="70px"  align="center">
                  <html:text property="symbol" size="2" maxlength="2" />
                </td>
                <td width="230px"  align="center">
                  <table width="100%" >
                    <tr>
                      <td align="center">
                        <html:text property="startTime" size="5" maxlength="5" />
                      </td>
                      <td align="center">
                          &#xFF5E;
                      </td>
                      <td align="center">
                        <html:text property="endTime" size="5" maxlength="5" />
                      </td>
                    </tr>
                  </table>
                </td>
                <td width="100px"  align="center">
                  <html:text property="breakTime" size="5" maxlength="5" />
                </td>
              </tr>
            </table>
          </div>
        </html:form>
      </div>
      <div id="footer">
        <table>
          <tr>
            <td id="footLeft">
              �@
            </td>
            <td id="footCenter">
              �@
            </td>
            <td id="footRight">
                <input value="�o�^" type="button" class="smlButton"  onclick="shiftMstMntRegist()" />
            </td>
          </tr>
        </table>
      </div>
    </div>
  </body>
</html>