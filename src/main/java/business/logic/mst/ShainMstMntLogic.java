/**
 * ファイル名：ShainMstMntLogic.java
 *
 * 変更履歴
 * 1.0  2010/08/24 Kazuya.Naraki
 */
package business.logic.mst;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import business.db.dao.mst.ShainMstMntDao;
import business.dto.LoginUserDto;
import business.dto.mst.ShainMstMntDto;
import business.logic.utils.CheckUtils;
import business.logic.utils.CommonUtils;
import constant.DbConstant.M_shain;

/**
 * 説明：社員マスタメンテナンス処理のロジック
 * @author naraki
 *
 */
public class ShainMstMntLogic {

    /**
     * 社員マスタの更新系の処理を行う
     * @param shainMstMntDtoList 更新対象社員マスタDtoリスト
     *
     * @param loginUserDto ログインユーザーDto
     * @author naraki
     */
    public void updateMshain(List<ShainMstMntDto> shainMstMntDtoList, LoginUserDto loginUserDto) throws Exception{

        // 社員マスタDao
        ShainMstMntDao shainMstMntDao = new ShainMstMntDao();
        // コネクション
        Connection connection = shainMstMntDao.getConnection();

        // トランザクション処理
        connection.setAutoCommit(false);

        try {
            for (int i = 0; i < shainMstMntDtoList.size(); i++) {

                ShainMstMntDto shainMstMntDto = shainMstMntDtoList.get(i);
                boolean deleteFlg = shainMstMntDto.getDeleteFlg();

                if (deleteFlg) {
                    // 削除
                    shainMstMntDao.deleteShainMst(shainMstMntDto.getShainId());
                } else {
                    // 更新
                    shainMstMntDao.updateShainMst(shainMstMntDto, loginUserDto);
                }

            }
        } catch (Exception e) {
            // ロールバック処理
            connection.rollback();

            // 切断
            connection.close();

            throw e;
        }

        // コミット
        connection.commit();
        // 切断
        connection.close();

    }

    /**
     * 社員マスタの登録処理を行う
     * @param mshainDtoList 更新対象社員マスタDtoリスト
     *
     * @param loginUserDto ログインユーザーDto
     * @author naraki
     */
    public void registMshain(ShainMstMntDto shainMstMntDto, LoginUserDto loginUserDto) throws Exception{

        // 社員マスタDao
        ShainMstMntDao shainMstMntDao = new ShainMstMntDao();

        // 社員ＩＤを採番する。
        CommonUtils commonUtils = new CommonUtils();
        String nextShainID = commonUtils.getNextId(M_shain.TABLE_NAME.getName());

        shainMstMntDto.setShainId(nextShainID);

        // 登録
        shainMstMntDao.registShainMst(shainMstMntDto, loginUserDto);

    }

    /**
     * 社員マスタ情報を取得する。
     * ↓＠param追記、引数にboolean flg追記　西
     * @param ログインユーザー情報
     * @param ログインユーザーのレコードを削除するか true→削除する、false→削除しない
     * @return 社員マスタリスト
     * @author naraki
     */
    public List<ShainMstMntDto> getShainData(LoginUserDto loginUserDto, boolean flg) throws SQLException{

        // 社員マスタDao
        ShainMstMntDao shainMstMntDao = new ShainMstMntDao();

        // 社員情報を取得する。
        List<ShainMstMntDto> mShainList = shainMstMntDao.getShainAllList();

        // 自分をリストから省く
        // 削除対象　↓if文追記　西
        
        ShainMstMntDto removeMshainDto = null;
        if(flg) {
        	for (ShainMstMntDto mshainDto : mShainList) {
        		String shainId = mshainDto.getShainId();
        		
        		if (loginUserDto.getShainId().equals(shainId)) {
        			removeMshainDto = mshainDto;
        			break;
        		}
        	}
        }

        if (!CheckUtils.isEmpty(removeMshainDto)) {
            // 削除対象が空でない場合
            mShainList.remove(removeMshainDto);
        }

        return mShainList;
    }
}
