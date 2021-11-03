package com.kh.showticket.event.model.vo;

import java.sql.Date;

public class Event {

	private int eventNo;
	private String eventTitle; 
	private String eventContent;
	private Date eventStartDate; 
	private Date eventEndDate; 
	private Date announcementDate; 
	private String eventStatus;
	private Date eventDetailDate; 
	private String eventTimeMen; 
	private String showId; 
	private String eventKind;
	private String eventImg;
	
	
	public Event() {
		super();
		// TODO Auto-generated constructor stub
	}


	public Event(int eventNo, String eventTitle, String eventContent, Date eventStartDate, Date eventEndDate,
			Date announcementDate, String eventStatus, Date eventDetailDate, String eventTimeMen, String showId,
			String eventKind, String eventImg) {
		super();
		this.eventNo = eventNo;
		this.eventTitle = eventTitle;
		this.eventContent = eventContent;
		this.eventStartDate = eventStartDate;
		this.eventEndDate = eventEndDate;
		this.announcementDate = announcementDate;
		this.eventStatus = eventStatus;
		this.eventDetailDate = eventDetailDate;
		this.eventTimeMen = eventTimeMen;
		this.showId = showId;
		this.eventKind = eventKind;
		this.eventImg = eventImg;
	}


	public int getEventNo() {
		return eventNo;
	}


	public void setEventNo(int eventNo) {
		this.eventNo = eventNo;
	}


	public String getEventTitle() {
		return eventTitle;
	}


	public void setEventTitle(String eventTitle) {
		this.eventTitle = eventTitle;
	}


	public String getEventContent() {
		return eventContent;
	}


	public void setEventContent(String eventContent) {
		this.eventContent = eventContent;
	}


	public Date getEventStartDate() {
		return eventStartDate;
	}


	public void setEventStartDate(Date eventStartDate) {
		this.eventStartDate = eventStartDate;
	}


	public Date getEventEndDate() {
		return eventEndDate;
	}


	public void setEventEndDate(Date eventEndDate) {
		this.eventEndDate = eventEndDate;
	}


	public Date getAnnouncementDate() {
		return announcementDate;
	}


	public void setAnnouncementDate(Date announcementDate) {
		this.announcementDate = announcementDate;
	}


	public String getEventStatus() {
		return eventStatus;
	}


	public void setEventStatus(String eventStatus) {
		this.eventStatus = eventStatus;
	}


	public Date getEventDetailDate() {
		return eventDetailDate;
	}


	public void setEventDetailDate(Date eventDetailDate) {
		this.eventDetailDate = eventDetailDate;
	}


	public String getEventTimeMen() {
		return eventTimeMen;
	}


	public void setEventTimeMen(String eventTimeMen) {
		this.eventTimeMen = eventTimeMen;
	}


	public String getShowId() {
		return showId;
	}


	public void setShowId(String showId) {
		this.showId = showId;
	}


	public String getEventKind() {
		return eventKind;
	}


	public void setEventKind(String eventKind) {
		this.eventKind = eventKind;
	}


	public String getEventImg() {
		return eventImg;
	}


	public void setEventImg(String eventImg) {
		this.eventImg = eventImg;
	}


	@Override
	public String toString() {
		return "Event [eventNo=" + eventNo + ", eventTitle=" + eventTitle + ", eventContent=" + eventContent
				+ ", eventStartDate=" + eventStartDate + ", eventEndDate=" + eventEndDate + ", announcementDate="
				+ announcementDate + ", eventStatus=" + eventStatus + ", eventDetailDate=" + eventDetailDate
				+ ", eventTimeMen=" + eventTimeMen + ", showId=" + showId + ", eventKind=" + eventKind + ", eventImg="
				+ eventImg + "]";
	}
	
}
