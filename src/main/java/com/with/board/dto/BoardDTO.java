package com.with.board.dto;

import java.sql.Date;

import org.apache.ibatis.type.Alias;

import com.fasterxml.jackson.annotation.JsonFormat;


@Alias("board")
public class BoardDTO {
   // 게시판 공통 컬럼 (식사)
   private int board_idx;
   private String member_id;
   private String category_id;
   private int hit;
   
   @JsonFormat(pattern = "yyyy-MM-dd" , timezone = "Asia/Seoul")
   private Date write_date;
   private String subject;
   private String content;
   private String deadline;
   private String appoint_place;
   private String appoint_coords_lat;
   private String appoint_coords_lng;
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
   public String getDeadline() {
      return deadline;
   }
   public void setDeadline(String deadline) {
      this.deadline = deadline;
   }
   public String getAppoint_place() {
      return appoint_place;
   }
   public void setAppoint_place(String appoint_place) {
      this.appoint_place = appoint_place;
   }
   public String getAppoint_coords_lat() {
      return appoint_coords_lat;
   }
   public void setAppoint_coords_lat(String appoint_coords_lat) {
      this.appoint_coords_lat = appoint_coords_lat;
   }
   public String getAppoint_coords_lng() {
      return appoint_coords_lng;
   }
   public void setAppoint_coords_lng(String appoint_coords_lng) {
      this.appoint_coords_lng = appoint_coords_lng;
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
   
   // 택시 게시판 전용 컬럼
   private String destination;
      
   public String getDestination() {
      return destination;
   }
   public void setDestination(String destination) {
      this.destination = destination;
   }

   // 배달 게시판 전용 컬럼
   private String min_delivery;
   private String delivery_fee;
   private String min_fund;
   
   public String getMin_delivery() {
      return min_delivery;
   }
   public void setMin_delivery(String min_delivery) {
      this.min_delivery = min_delivery;
   }
   public String getDelivery_fee() {
      return delivery_fee;
   }
   public void setDelivery_fee(String delivery_fee) {
      this.delivery_fee = delivery_fee;
   }
   public String getMin_fund() {
      return min_fund;
   }
   public void setMin_fund(String min_fund) {
      this.min_fund = min_fund;
   }
   
   // 내가만든모임 전용 dto
   private int applyNo;
   private int apply_idx;
   
   public int getApply_idx() {
	return apply_idx;
}
   public void setApply_idx(int apply_idx) {
	this.apply_idx = apply_idx;
}
	public int getApplyNo() {
		return applyNo;
	}
	public void setApplyNo(int applyNo) {
		this.applyNo = applyNo;
}
	//내가 참여한 모임 전용 dto
	private String investment;
	private String status;
	private Date apply_date;
	
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}


	public Date getApply_date() {
		return apply_date;
	}
	public void setApply_date(Date apply_date) {
		this.apply_date = apply_date;
	}
	public String getInvestment() {
		return investment;
	}
	public void setInvestment(String investment) {
		this.investment = investment;
	}
   
   
}