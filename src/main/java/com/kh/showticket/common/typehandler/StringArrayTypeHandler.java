package com.kh.showticket.common.typehandler;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.ibatis.type.JdbcType;
import org.apache.ibatis.type.TypeHandler;

/**
 * TypeHandler<T> 인터페이스를 구현
 * T 타입 변수는 java타입을 기술한다.
 * 3개의 getter, 1개의 setter를 오버라이딩함.
 * 
 * getter
 * - ResultSet에서 columnName으로 가져오기
 * - ResultSet에서 columnIndex로 가져오기
 * - 프로시져용 CallableStatement용 가져오기
 * 
 * setter
 * - java:String[] => jdbc: 문자형(String)
 *
 *
 */

public class StringArrayTypeHandler implements TypeHandler<String[]> {

	@Override
	public void setParameter(PreparedStatement ps, int i, String[] parameter, JdbcType jdbcType) throws SQLException {
		
		if(parameter != null ) {
			ps.setString(i, String.join(",", parameter));
		}
		else {
			ps.setString(i, "");
		}
	}

	@Override
	public String[] getResult(ResultSet rs, String columnName) throws SQLException {
		String str = rs.getString(columnName);
		String[] strArr = null;
		if(str != null) strArr = str.split(",");
		return strArr;
	}

	@Override
	public String[] getResult(ResultSet rs, int columnIndex) throws SQLException {
		String str = rs.getString(columnIndex);
		String[] strArr = null;
		if(str != null) strArr = str.split(",");
		return strArr;
	}

	@Override
	public String[] getResult(CallableStatement cs, int columnIndex) throws SQLException {
		String str = cs.getString(columnIndex);
		String[] strArr = null;
		if(str != null) strArr = str.split(",");
		return strArr;
	}

}
