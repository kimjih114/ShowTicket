package com.kh.showticket.event.model.vo;

public class Prizewinner {

	private int prizewinnerNo;
	private int peventNo; 
	private String prizewinnerName; 
	private String prizePhone;
	public Prizewinner() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Prizewinner(int prizewinnerNo, int peventNo, String prizewinnerName, String prizePhone) {
		super();
		this.prizewinnerNo = prizewinnerNo;
		this.peventNo = peventNo;
		this.prizewinnerName = prizewinnerName;
		this.prizePhone = prizePhone;
	}
	public int getPrizewinnerNo() {
		return prizewinnerNo;
	}
	public void setPrizewinnerNo(int prizewinnerNo) {
		this.prizewinnerNo = prizewinnerNo;
	}
	public int getPeventNo() {
		return peventNo;
	}
	public void setPeventNo(int peventNo) {
		this.peventNo = peventNo;
	}
	public String getPrizewinnerName() {
		return prizewinnerName;
	}
	public void setPrizewinnerName(String prizewinnerName) {
		this.prizewinnerName = prizewinnerName;
	}
	public String getPrizePhone() {
		return prizePhone;
	}
	public void setPrizePhone(String prizePhone) {
		this.prizePhone = prizePhone;
	}
	@Override
	public String toString() {
		return "Prizewinner [prizewinnerNo=" + prizewinnerNo + ", peventNo=" + peventNo + ", prizewinnerName="
				+ prizewinnerName + ", prizePhone=" + prizePhone + "]";
	}
	
	
	
	
}
