package com.with.inquery.dto;

import java.util.Date;

import org.apache.ibatis.type.Alias;
@Alias("inquery")
public class InqueryDTO {
	private int inquery_idx;
	private String member_id;
	private String subject;
	private Date inquery_date;
	private String inquery_content;
	private String status;
	private String inquery_admin;
	private Date answer_date;
	private String answer_content;
	private int hide;
	
	public int getInquery_idx() {
		return inquery_idx;
	}
	public void setInquery_idx(int inquery_idx) {
		this.inquery_idx = inquery_idx;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public Date getInquery_date() {
		return inquery_date;
	}
	public void setInquery_date(Date inquery_date) {
		this.inquery_date = inquery_date;
	}
	public String getInquery_content() {
		return inquery_content;
	}
	public void setInquery_content(String inquery_content) {
		this.inquery_content = inquery_content;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getInquery_admin() {
		return inquery_admin;
	}
	public void setInquery_admin(String inquery_admin) {
		this.inquery_admin = inquery_admin;
	}
	public Date getAnswer_date() {
		return answer_date;
	}
	public void setAnswer_date(Date answer_date) {
		this.answer_date = answer_date;
	}
	public String getAnswer_content() {
		return answer_content;
	}
	public void setAnswer_content(String answer_content) {
		this.answer_content = answer_content;
	}
	public int getHide() {
		return hide;
	}
	public void setHide(int hide) {
		this.hide = hide;
	}
	
	
}
