package com.kh.showticket.event.model.exception;

public class EventException extends RuntimeException{

	public EventException() {
		super();
	}

	public EventException(String message, Throwable cause, boolean enableSuppression, boolean writableStackTrace) {
		super(message, cause, enableSuppression, writableStackTrace);
	}

	public EventException(String message, Throwable cause) {
		super(message, cause);
	}

	public EventException(String message) {
		super(message);
	}

	public EventException(Throwable cause) {
		super(cause);
	}
	
}
