 /*
 * ファイル名：TsukibetsuShiftNyuuryokuKihonHaneiAction.java
 *
 * 変更履歴
 * 1.0  2010/09/04 Kazuya.Naraki
 */
package action.mth;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.Comparator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import business.dto.LoginUserDto;
import business.dto.bse.KihonShiftDto;
import business.dto.mst.ShiftMstMntDto;
import business.dto.mth.TsukibetsuShiftDto;
import business.logic.bse.KihonShiftLogic;
import business.logic.comparator.MethodComparator;
import business.logic.mth.TsukibetsuShiftLogic;
import business.logic.utils.CheckUtils;
import business.logic.utils.ComboListUtilLogic;
import business.logic.utils.CommonUtils;
import constant.CommonConstant;
import constant.RequestSessionNameConstant;
import form.bse.KihonShiftHanreiBean;
import form.bse.KihonShiftMstMntBean;
import form.common.DateBean;
import form.mth.TsukibetsuShiftNyuuryokuBean;
import form.mth.TsukibetsuShiftNyuuryokuForm;

/**
 * 説明：月別シフト入力基本シフト反映アクションクラス
 * @author naraki
 */
public class TsukibetsuShiftNyuuryokuKihonHaneiAction extends TsukibetsuShiftNyuuryokuAbstractAction{


    // ログ出力クラス
    private Log log = LogFactory.getLog(this.getClass());

    /**
     * 基本シフト確認のアクション
     *
     * @param mapping アクションマッピング
     * @param form アクションフォーム
     * @param req リクエスト
     * @param res レスポンス
     * @return アクションフォワード
     * @author nishioka
     */
    public ActionForward execute(ActionMapping mapping, ActionForm form,
            HttpServletRequest req, HttpServletResponse res) throws Exception {
        log.info(new Throwable().getStackTrace()[0].getMethodName());

        // セッション
        HttpSession session = req.getSession();

        // フォワードキー
        String forward = "";

        // ログインユーザ情報をセッションより取得
        LoginUserDto loginUserDto = (LoginUserDto) session.getAttribute(RequestSessionNameConstant.SESSION_CMN_LOGIN_USER_INFO);

        // フォーム
        TsukibetsuShiftNyuuryokuForm tsukibetsuShiftForm = (TsukibetsuShiftNyuuryokuForm) form;
        
        // 対象年月
        String yearMonth = tsukibetsuShiftForm.getYearMonth();
        
        // 対象年月の月情報を取得する。
        List<DateBean> dateBeanList = CommonUtils.getDateBeanList(yearMonth);
        
        // 基本シフトマスタロジック
        KihonShiftLogic kihonShiftLogic = new KihonShiftLogic();
        // 設定済み基本シフトデータの取得
        Map<String, KihonShiftDto> kihonShiftDataMap = kihonShiftLogic.getKihonShiftData();
      
        //月別シフト ロジック生成
        TsukibetsuShiftLogic tsukibetsuShiftLogic = new TsukibetsuShiftLogic();
        
        // セレクトボックス（シフトマスタ）の取得
        ComboListUtilLogic comboListUtils = new ComboListUtilLogic();
        Map<String, String> shiftCmbMap = comboListUtils.getComboShift(true);
        Map<String, String> yearMonthCmbMap = comboListUtils.getComboYearMonth(CommonUtils.getFisicalDay(CommonConstant.yearMonthNoSl), 3, ComboListUtilLogic.KBN_YEARMONTH_NEXT, false);
        
        // シフトIDを取得する
        Map<String,List<TsukibetsuShiftDto>> tsukibetsuShiftDtoMap = tsukibetsuShiftLogic.getMonthlyData(dateBeanList, kihonShiftDataMap, shiftCmbMap, loginUserDto);
        List<TsukibetsuShiftNyuuryokuBean> tsukibetsuShiftBeanList = new ArrayList<TsukibetsuShiftNyuuryokuBean>();
        
        if (CheckUtils.isEmpty(tsukibetsuShiftDtoMap)) {
            // データなし
            TsukibetsuShiftNyuuryokuBean tsukibetsuShiftBean = new TsukibetsuShiftNyuuryokuBean();
            tsukibetsuShiftBean.setShainId(loginUserDto.getShainId());
            tsukibetsuShiftBean.setShainName(loginUserDto.getShainName());
            tsukibetsuShiftBean.setRegistFlg(true);

            tsukibetsuShiftBeanList.add(tsukibetsuShiftBean);
        } else {
            // データあり
            tsukibetsuShiftBeanList = dtoToBean(tsukibetsuShiftDtoMap, loginUserDto);
        }
        
        // フォームにデータをセットする
        tsukibetsuShiftForm.setShiftCmbMap(shiftCmbMap);
        tsukibetsuShiftForm.setYearMonthCmbMap(yearMonthCmbMap);
        tsukibetsuShiftForm.setTsukibetsuShiftNyuuryokuBeanList(tsukibetsuShiftBeanList);
        tsukibetsuShiftForm.setDateBeanList(dateBeanList);
        tsukibetsuShiftForm.setYearMonth(yearMonth);
        // ページング用
        tsukibetsuShiftForm.setOffset(0);
        tsukibetsuShiftForm.setCntPage(1);
        tsukibetsuShiftForm.setMaxPage(CommonUtils.getMaxPage(tsukibetsuShiftDtoMap.size(), SHOW_LENGTH));
        
        
        forward = CommonConstant.SUCCESS;

        return mapping.findForward(forward);
    }


    /**
     * dtoデータをBeanのリストへ変換する
     * @param shiftMstMntDtoList 勤務実績マップ key 稼働日, val 勤務実績Dto
     * @return
     * @author nishioka
     * @throws ParseException
     */
    private List<KihonShiftHanreiBean> hanreiDataToBean(
            List<ShiftMstMntDto> shiftMstMntDtoList
    ) throws ParseException {

        // 戻り値
        List<KihonShiftHanreiBean> rtnList = new  ArrayList<KihonShiftHanreiBean>(shiftMstMntDtoList.size());

        for (ShiftMstMntDto shiftMstMntDto: shiftMstMntDtoList) {

            // 勤務実績Bean
            KihonShiftHanreiBean kihonShiftHanreiBean = new KihonShiftHanreiBean();
            kihonShiftHanreiBean.setShiftName(shiftMstMntDto.getShiftName());
            kihonShiftHanreiBean.setSymbol(shiftMstMntDto.getSymbol());
            kihonShiftHanreiBean.setTimeZone(shiftMstMntDto.getStartTime() + "&nbsp;&#xFF5E;&nbsp;" + shiftMstMntDto.getEndTime());
            kihonShiftHanreiBean.setKyukei(shiftMstMntDto.getBreakTime());

            rtnList.add(kihonShiftHanreiBean);
        }

        return rtnList;
    }
    /**
     * dtoデータをBeanのリストへ変換する
     * @param kihonShiftDtoMap 基本シフトマップ key 社員ID, val 基本シフトDto
     * @return
     * @author nishioka
     * @throws ParseException
     */
    private List<KihonShiftMstMntBean> listDataDtoToBean(
            Map<String, KihonShiftDto> kihonShiftDtoMap,
            LoginUserDto loginUserDto) throws ParseException {

        // 戻り値
        List<KihonShiftMstMntBean> rtnList = new  ArrayList<KihonShiftMstMntBean>(kihonShiftDtoMap.size());

        Collection <KihonShiftDto> values = kihonShiftDtoMap.values();
        for (KihonShiftDto kihonShiftDto: values) {

            // 基本シフトBean
            KihonShiftMstMntBean kihonShiftMstMntBean = new KihonShiftMstMntBean();
            kihonShiftMstMntBean.setShainId(kihonShiftDto.getShainId());
            kihonShiftMstMntBean.setShainName(kihonShiftDto.getShainName());

            kihonShiftMstMntBean.setShiftIdOnMonday(kihonShiftDto.getShiftIdOnMonday());
            kihonShiftMstMntBean.setShiftIdOnTuesday(kihonShiftDto.getShiftIdOnTuesday());
            kihonShiftMstMntBean.setShiftIdOnWednesday(kihonShiftDto.getShiftIdOnWednesday());
            kihonShiftMstMntBean.setShiftIdOnThursday(kihonShiftDto.getShiftIdOnThursday());
            kihonShiftMstMntBean.setShiftIdOnFriday(kihonShiftDto.getShiftIdOnFriday());
            kihonShiftMstMntBean.setShiftIdOnSaturday(kihonShiftDto.getShiftIdOnSaturday());
            kihonShiftMstMntBean.setShiftIdOnSunday(kihonShiftDto.getShiftIdOnSunday());

            rtnList.add(kihonShiftMstMntBean);
        }

        return rtnList;
    }
    
    /**
     * DtoからBeanへ変換する
     * @param tsukibetsuShiftDtoMap
     * @param loginUserDto
     * @return 一覧に表示するリスト
     * @author naraki
     * @throws InvocationTargetException
     * @throws IllegalAccessException
     * @throws IllegalArgumentException
     */
    private List<TsukibetsuShiftNyuuryokuBean> dtoToBean(Map<String, List<TsukibetsuShiftDto>> tsukibetsuShiftDtoMap
                                                      , LoginUserDto loginUserDto)
                                                                        throws IllegalArgumentException,
                                                                        IllegalAccessException,
                                                                        InvocationTargetException {
        Collection<List<TsukibetsuShiftDto>> collection = tsukibetsuShiftDtoMap.values();

        List<TsukibetsuShiftNyuuryokuBean> tsukibetsuShiftBeanList = new ArrayList<TsukibetsuShiftNyuuryokuBean>();

        for (List<TsukibetsuShiftDto> tsukibetsuShiftDtoList : collection) {

            // 実行するオブジェクトの生成
            TsukibetsuShiftNyuuryokuBean tsukibetsuShiftBean = new TsukibetsuShiftNyuuryokuBean();

            // メソッドの取得
            Method[] methods = tsukibetsuShiftBean.getClass().getMethods();

            // メソッドのソートを行う
            Comparator<Method> asc = new MethodComparator();
            Arrays.sort(methods, asc); // 配列をソート

            int index = 0;
            int listSize = tsukibetsuShiftDtoList.size();

            String shainId = "";
            String shainName = "";

            for (int i = 0; i < methods.length; i++) {
                // "setShiftIdXX" のメソッドを動的に実行する
                if (methods[i].getName().startsWith("setShiftId") && listSize > index) {
                    TsukibetsuShiftDto tsukibetsuShiftDto = tsukibetsuShiftDtoList.get(index);
                    // メソッド実行
                    methods[i].invoke(tsukibetsuShiftBean, tsukibetsuShiftDto.getShiftId());

                    shainId = tsukibetsuShiftDto.getShainId();
                    shainName = tsukibetsuShiftDto.getShainName();

                    index ++;
                }
            }

            tsukibetsuShiftBean.setShainId(shainId);
            tsukibetsuShiftBean.setShainName(shainName);
            tsukibetsuShiftBean.setRegistFlg(false);

            tsukibetsuShiftBeanList.add(tsukibetsuShiftBean);

        }

        return tsukibetsuShiftBeanList;
    }
    
}
