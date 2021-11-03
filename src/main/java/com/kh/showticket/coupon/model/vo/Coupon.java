package com.kh.showticket.coupon.model.vo;

import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class Coupon {
	private int couponNo;
	private String couponTitle;
	private int couponPrice;
	private int couponTime;
	private String couponCount;
	private String showId;
	
}
