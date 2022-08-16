package com.with.member.dto;

import java.sql.Date;

import org.apache.ibatis.type.Alias;
@Alias("member")
public class MemberDTO {
	private String member_id;
	private int university_idx;
	private String member_pw;
	private String name;
	private String gender;
	private String email;
	private String phone;
	private String member_class;
	private String member_status;
	private Date reg_date;
	private int certficate_chk;
	private int hide;
	/* 회원 차단 */
	private String block_member;
	public String getBlock_member() {
		return block_member;
	}
	public void setBlock_member(String block_member) {
		this.block_member = block_member;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public int getUniversity_idx() {
		return university_idx;
	}
	public void setUniversity_idx(int university_idx) {
		this.university_idx = university_idx;
	}
	public String getMember_pw() {
		return member_pw;
	}
	public void setMember_pw(String member_pw) {
		this.member_pw = member_pw;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getMember_class() {
		return member_class;
	}
	public void setMember_class(String member_class) {
		this.member_class = member_class;
	}
	public String getMember_status() {
		return member_status;
	}
	public void setMember_status(String member_status) {
		this.member_status = member_status;
	}
	public Date getReg_date() {
		return reg_date;
	}
	public void setReg_date(Date reg_date) {
		this.reg_date = reg_date;
	}
	public int getCertficate_chk() {
		return certficate_chk;
	}
	public void setCertficate_chk(int certficate_chk) {
		this.certficate_chk = certficate_chk;
	}
	public int getHide() {
		return hide;
	}
	public void setHide(int hide) {
		this.hide = hide;
	}
	
	//제한이가 추가한 dto 대학교 테이블
	//public int university_idx;
	public String university_name;
	public String university_location;
	public String university_addr;
	public String getUniversity_name() {
		return university_name;
	}
	public void setUniversity_name(String university_name) {
		this.university_name = university_name;
	}
	public String getUniversity_location() {
		return university_location;
	}
	public void setUniversity_location(String university_location) {
		this.university_location = university_location;
	}
	public String getUniversity_addr() {
		return university_addr;
	}
	public void setUniversity_addr(String university_addr) {
		this.university_addr = university_addr;
	}
	
	
//	정현민 추가
	private int chkManner;

	public int getChkManner() {
		return chkManner;
	}
	public void setChkManner(int chkManner) {
		this.chkManner = chkManner;
	}
	
	
}
