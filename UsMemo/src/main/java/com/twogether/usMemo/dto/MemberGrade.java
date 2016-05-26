package com.twogether.usMemo.dto;

public class MemberGrade {
	
	//멤버등급 프라이머리키
	private int	num;
	//보드 넘버
	private int	bNum;
	//회원 아이디
	private String memId;
	//회원 등급
	private int grade;
	private String star;
	
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public int getbNum() {
		return bNum;
	}
	public void setbNum(int bNum) {
		this.bNum = bNum;
	}
	public String getmemId() {
		return memId;
	}
	public void setmemId(String memId) {
		this.memId = memId;
	}
	public int getGrade() {
		return grade;
	}
	public void setGrade(int grade) {
		this.grade = grade;
	}
	public String getStar() {
		return star;
	}
	public void setStar(String star) {
		this.star = star;
	}

	
	
	

}
