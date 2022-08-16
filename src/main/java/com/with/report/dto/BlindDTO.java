package com.with.report.dto;

import java.util.Date;

public class BlindDTO {
	
	private int blind_idx;
	private String category_id;
	private String member_id;
	private Date write_date;
	private int board_idx;
	private String subject;
	private Date blind_date;
	private String blind_reason;
	private String blindCancel_id;
	private String blindCancel_reason;
	private int cancel;
	
	public Date getWrite_date() {
		return write_date;
	}
	public void setWrite_date(Date write_date) {
		this.write_date = write_date;
	}
	public int getBlind_idx() {
		return blind_idx;
	}
	public void setBlind_idx(int blind_idx) {
		this.blind_idx = blind_idx;
	}
	public String getCategory_id() {
		return category_id;
	}
	public void setCategory_id(String category_id) {
		this.category_id = category_id;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public int getBoard_idx() {
		return board_idx;
	}
	public void setBoard_idx(int board_idx) {
		this.board_idx = board_idx;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public Date getBlind_date() {
		return blind_date;
	}
	public void setBlind_date(Date blind_date) {
		this.blind_date = blind_date;
	}
	public String getBlind_reason() {
		return blind_reason;
	}
	public void setBlind_reason(String blind_reason) {
		this.blind_reason = blind_reason;
	}
	public String getBlindCancel_id() {
		return blindCancel_id;
	}
	public void setBlindCancel_id(String blindCancel_id) {
		this.blindCancel_id = blindCancel_id;
	}
	public String getBlindCancel_reason() {
		return blindCancel_reason;
	}
	public void setBlindCancel_reason(String blindCancel_reason) {
		this.blindCancel_reason = blindCancel_reason;
	}
	public int getCancel() {
		return cancel;
	}
	public void setCancel(int cancel) {
		this.cancel = cancel;
	}
	

	
}
