package com.kh.showticket.member.model.vo;

import java.sql.Date;

import lombok.Data;

@Data
public class MyPoint {
	private int pointNo;
	private String memberId;
	private String pointReason;
	private int pointAccount;
	private String saveUse;
	private Date saveUseDate;
}
