package com.kh.showticket.common;

import java.util.Date;

import lombok.Data;

@Data
public class MusicalAndShow {
	private double reviewStar; //별점
	
	private String id;	//공연ID
	private String name; //공연명
	private String startDate; //공연시작일
	private String endDate; //공연종료일
	private String hallId; //공연시설ID
	private String hallName; // 공연시설명
	private String cast; //출연진
	private String runtime; //공연 런타임
	private String age; //공연 관람 연령
	private String price; //티켓 가격
	private String poster; //포스터 이미지 경로
	private String genre; //공연장르(연극, 뮤지컬)
	private String state; //공연상태
	private String[] urls; //소개이미지목록
	private String time; //공연시간
	
}
