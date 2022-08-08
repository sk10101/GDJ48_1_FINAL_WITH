package com.with.history.dto;

import java.sql.Date;

public class HistoryDTO {

	private int history_idx;
	private String member_id;
	private int board_idx;
	private int hide;
	private String category_id;
	private Date write_date;
	private String subject;
	private String content;
	private String status;
	private int recruit_end;
	
	public int getHistory_idx() {
		return history_idx;
	}
	public void setHistory_idx(int history_idx) {
		this.history_idx = history_idx;
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
	public int getHide() {
		return hide;
	}
	public void setHide(int hide) {
		this.hide = hide;
	}
	public String getCategory_id() {
		return category_id;
	}
	public void setCategory_id(String category_id) {
		this.category_id = category_id;
	}
	public Date getWrite_date() {
		return write_date;
	}
	public void setWrite_date(Date write_date) {
		this.write_date = write_date;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public int getRecruit_end() {
		return recruit_end;
	}
	public void setRecruit_end(int recruit_end) {
		this.recruit_end = recruit_end;
	}
	
	
}
