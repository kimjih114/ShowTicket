package com.kh.showticket.event.model.vo;

public class EventAttachment {

	private int eventAttachment ; 
	private int eventNo ; 
	private String originalFileName; 
	private String renamedFileName;
	public EventAttachment() {
		super();
		// TODO Auto-generated constructor stub
	}
	public EventAttachment(int eventAttachment, int eventNo, String originalFileName, String renamedFileName) {
		super();
		this.eventAttachment = eventAttachment;
		this.eventNo = eventNo;
		this.originalFileName = originalFileName;
		this.renamedFileName = renamedFileName;
	}
	public int getEventAttachment() {
		return eventAttachment;
	}
	public void setEventAttachment(int eventAttachment) {
		this.eventAttachment = eventAttachment;
	}
	public int getEventNo() {
		return eventNo;
	}
	public void setEventNo(int eventNo) {
		this.eventNo = eventNo;
	}
	public String getOriginalFileName() {
		return originalFileName;
	}
	public void setOriginalFileName(String originalFileName) {
		this.originalFileName = originalFileName;
	}
	public String getRenamedFileName() {
		return renamedFileName;
	}
	public void setRenamedFileName(String renamedFileName) {
		this.renamedFileName = renamedFileName;
	}
	@Override
	public String toString() {
		return "EventAttachment [eventAttachment=" + eventAttachment + ", eventNo=" + eventNo + ", originalFileName="
				+ originalFileName + ", renamedFileName=" + renamedFileName + "]";
	}
	
	
	
	
}
