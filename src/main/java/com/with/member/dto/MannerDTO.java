package com.with.member.dto;

import java.sql.Date;

import org.apache.ibatis.type.Alias;
@Alias("manner")
public class MannerDTO {
	/*매너점수*/
	private String member_id;
	private String category_id;
	private float avg_score;
	
	/*매너평가*/
	private int assess_idx;
	private int board_idx;
	private String assessor;
	private Date assess_date;
	private int manner_score;
	
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
	public float getAvg_score() {
		return avg_score;
	}
	public void setAvg_score(float avg_score) {
		this.avg_score = avg_score;
	}
	public int getAssess_idx() {
		return assess_idx;
	}
	public void setAssess_idx(int assess_idx) {
		this.assess_idx = assess_idx;
	}
	public int getBoard_idx() {
		return board_idx;
	}
	public void setBoard_idx(int board_idx) {
		this.board_idx = board_idx;
	}
	public String getAssessor() {
		return assessor;
	}
	public void setAssessor(String assessor) {
		this.assessor = assessor;
	}
	public Date getAssess_date() {
		return assess_date;
	}
	public void setAssess_date(Date assess_date) {
		this.assess_date = assess_date;
	}
	public int getManner_score() {
		return manner_score;
	}
	public void setManner_score(int manner_score) {
		this.manner_score = manner_score;
	}
	
	private int kindness;
	private int time;

	public int getKindness() {
		return kindness;
	}
	public void setKindness(int kindness) {
		this.kindness = kindness;
	}
	public int getTime() {
		return time;
	}
	public void setTime(int time) {
		this.time = time;
	}
	
}
