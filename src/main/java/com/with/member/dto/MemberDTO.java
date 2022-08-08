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
	
}
