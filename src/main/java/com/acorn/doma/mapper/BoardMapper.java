package com.acorn.doma.mapper;

import java.sql.SQLException;

import org.apache.ibatis.annotations.Mapper;

import com.acorn.doma.cmn.Search;
import com.acorn.doma.cmn.WorkDiv;
import com.acorn.doma.domain.Board;

@Mapper
public interface BoardMapper extends WorkDiv<Board>{

	
	/**
	 * 최신 sequence 조회
	 * @return
	 * @throws SQLException
	 */
	int getSequence() throws SQLException;
	
	/**
	 * 테스트용 데이터 전체 삭제
	 * @return
	 * @throws SQLException
	 */
	int deleteAll() throws SQLException;
	
	/**
	 * 조회 count증가
	 * @param inVO
	 * @return
	 * @throws SQLException
	 */
	int readCntUpdate(Board inVO) throws SQLException;
	
	/**
	 * 다건 데이터 등록
	 * @return
	 * @throws SQLException
	 */
	int multipleSave() throws SQLException;
	
}
