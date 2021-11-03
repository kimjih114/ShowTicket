package com.kh.showticket.help.model.vo;

import java.sql.Date;
import lombok.Data;

@Data
public class Notice {

	private int noticeNo;
	private String noticeTitle;
	private String noticeContent;
	private Date noticeEnrollDate;
	private String noticeCategory;
	private int noticeCount;
	private String playId;

}
