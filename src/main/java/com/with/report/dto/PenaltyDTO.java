package com.with.report.dto;

import java.sql.Date;

import org.apache.ibatis.type.Alias;

@Alias("penalty")
public class PenaltyDTO {

	public int penalty_idx;
	public String member_id;
	public String penalty_admin;
	public Date penalty_date;
	public Date penalty_end;
	public String pntCancel_id;
	public String pntCancel_reason;
	public String penalty_reason;
	public int cancel;
	
	
	
	public int getCancel() {
		return cancel;
	}
	public void setCancel(int cancel) {
		this.cancel = cancel;
	}
	public String getPenalty_reason() {
		return penalty_reason;
	}
	public void setPenalty_reason(String penalty_reason) {
		this.penalty_reason = penalty_reason;
	}
	public int getPenalty_idx() {
		return penalty_idx;
	}
	public void setPenalty_idx(int penalty_idx) {
		this.penalty_idx = penalty_idx;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String getPenalty_admin() {
		return penalty_admin;
	}
	public void setPenalty_admin(String penalty_admin) {
		this.penalty_admin = penalty_admin;
	}
	public Date getPenalty_date() {
		return penalty_date;
	}
	public void setPenalty_date(Date penalty_date) {
		this.penalty_date = penalty_date;
	}
	public Date getPenalty_end() {
		return penalty_end;
	}
	public void setPenalty_end(Date penalty_end) {
		this.penalty_end = penalty_end;
	}
	public String getPntCancel_id() {
		return pntCancel_id;
	}
	public void setPntCancel_id(String pntCancel_id) {
		this.pntCancel_id = pntCancel_id;
	}
	public String getPntCancel_reason() {
		return pntCancel_reason;
	}
	public void setPntCancel_reason(String pntCancel_reason) {
		this.pntCancel_reason = pntCancel_reason;
	}
	
	
}
