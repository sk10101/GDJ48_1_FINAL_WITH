package com.with.member.dto;

import org.apache.ibatis.type.Alias;

@Alias("certificate")
public class CertificateDTO {
	
	private String member_id;
	private String oriFileName;
	private String newFileName;
	
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String getOriFileName() {
		return oriFileName;
	}
	public void setOriFileName(String oriFileName) {
		this.oriFileName = oriFileName;
	}
	public String getNewFileName() {
		return newFileName;
	}
	public void setNewFileName(String newFileName) {
		this.newFileName = newFileName;
	}
	
	
}
