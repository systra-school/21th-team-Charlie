package form.cmn;


import org.apache.struts.validator.ValidatorForm;

@SuppressWarnings("serial")
public final class LoginForm extends ValidatorForm {

	// 社員ID
	String shainId;
	// パスワード
	String password;
	// ユーザーの有無をチェック　村瀬
	String check;

	/**
	 * @return shainId
	 */
	public String getShainId() {
		return shainId;
	}
	/**
	 * @param shainId セットする shainId
	 */
	public void setShainId(String shainId) {
		this.shainId = shainId;
	}
	/**
	 * @return password
	 */
	public String getPassword() {
		return password;
	}
	/**
	 * @param password セットする password
	 */
	public void setPassword(String password) {
		this.password = password;
	}
	
	public String getCheck() {
		return check;
	}
	/**
	 * @param password セットする password
	 */
	public void setCheck(String check) {
		this.check = check;
	}


}