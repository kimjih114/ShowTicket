package com.kh.showticket.help.model.vo;






public class Faq {

private int faqNo;
private String question;
private String answer;
private String type;

public Faq() {}

public Faq(int faqNo, String question, String answer, String type) {
	super();
	this.faqNo = faqNo;
	this.question = question;
	this.answer = answer;
	this.type = type;
}

public int getfaqNo() {
	return faqNo;
}

public void setfaqNo(int faqNo) {
	this.faqNo = faqNo;
}

public String getQuestion() {
	return question;
}

public void setQuestion(String question) {
	this.question = question;
}

public String getAnswer() {
	return answer;
}

public void setAnswer(String answer) {
	this.answer = answer;
}

public String getType() {
	return type;
}

public void setType(String type) {
	this.type = type;
}

@Override
public String toString() {
	return "Faq [faqNo=" + faqNo + ", question=" + question + ", answer=" + answer + ", type=" + type + "]";
}



}
