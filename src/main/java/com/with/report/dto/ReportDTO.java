package com.with.report.dto;

import java.sql.Date;

import org.apache.ibatis.type.Alias;

@Alias("report")
public class ReportDTO {

	//신고내역 테이블
	public int report_idx;
	public int board_idx;
	public String reporter_id;
	public Date report_date;
	public String report_content;
	public String report_admin;
	public String report_reason;
	public String status;
	public int getReport_idx() {
		return report_idx;
	}
	public void setReport_idx(int report_idx) {
		this.report_idx = report_idx;
	}
	public int getBoard_idx() {
		return board_idx;
	}
	public void setBoard_idx(int board_idx) {
		this.board_idx = board_idx;
	}
	public String getReporter_id() {
		return reporter_id;
	}
	public void setReporter_id(String reporter_id) {
		this.reporter_id = reporter_id;
	}
	public Date getReport_date() {
		return report_date;
	}
	public void setReport_date(Date report_date) {
		this.report_date = report_date;
	}
	public String getReport_content() {
		return report_content;
	}
	public void setReport_content(String report_content) {
		this.report_content = report_content;
	}
	public String getReport_admin() {
		return report_admin;
	}
	public void setReport_admin(String report_admin) {
		this.report_admin = report_admin;
	}
	public String getReport_reason() {
		return report_reason;
	}
	public void setReport_reason(String report_reason) {
		this.report_reason = report_reason;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
	
	//공통 게시판 테이블
	public String member_id;
	public String category_id;
	public String subject;
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
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	
	//패널티 게시판
	public Date penalty_date;
	public Date penalty_end;
	public String penalty_reason;
	public String getPenalty_reason() {
		return penalty_reason;
	}
	public void setPenalty_reason(String penalty_reason) {
		this.penalty_reason = penalty_reason;
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
	
}
