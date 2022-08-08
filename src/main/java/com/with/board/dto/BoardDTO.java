package com.with.board.dto;

import java.sql.Date;

public class BoardDTO {

	private int board_idx;
	private String member_id;
	private String category_id;
	private int hit;
	private Date write_date;
	private String subject;
	private String content;
	private Date deadline;
	private String appoint_place;
	private String appoint_coords;
	private String gender;
	private int member_cnt;
	private int recruit_end;
	private int hide;
	public int getBoard_idx() {
		return board_idx;
	}
	public void setBoard_idx(int board_idx) {
		this.board_idx = board_idx;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String getCategory_id() {
		return category_id;
	}
	public void setCategory_id(String category_id) {
		this.category_id = category_id;
	}
	public int getHit() {
		return hit;
	}
	public void setHit(int hit) {
		this.hit = hit;
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
	public Date getDeadline() {
		return deadline;
	}
	public void setDeadline(Date deadline) {
		this.deadline = deadline;
	}
	public String getAppoint_place() {
		return appoint_place;
	}
	public void setAppoint_place(String appoint_place) {
		this.appoint_place = appoint_place;
	}
	public String getAppoint_coords() {
		return appoint_coords;
	}
	public void setAppoint_coords(String appoint_coords) {
		this.appoint_coords = appoint_coords;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public int getMember_cnt() {
		return member_cnt;
	}
	public void setMember_cnt(int member_cnt) {
		this.member_cnt = member_cnt;
	}
	public int getRecruit_end() {
		return recruit_end;
	}
	public void setRecruit_end(int recruit_end) {
		this.recruit_end = recruit_end;
	}
	public int getHide() {
		return hide;
	}
	public void setHide(int hide) {
		this.hide = hide;
	}
	
	
	
	
}
