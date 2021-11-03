package com.kh.showticket.coupon.model.vo;

import java.sql.Date;

import lombok.Data;

@Data
public class MyCoupon {
	private int myCouponNo;
	private String memberId;
	private Date couponStartDate;
	private Date couponEndDate;
	private int coupon_no;

}
