package com.twogether.usMemo.dto;

public class BoardInfo{
	
	private int bNum;
	private String name;
	private int	memberGrade_num;
	private String memId;
	private int grade;
	private String star;
	private String background_color;
	
	public int getbNum() {
		return bNum;
	}
	public void setbNum(int bNum) {
		this.bNum = bNum;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getMemId() {
		return memId;
	}
	public void setMemId(String memId) {
		this.memId = memId;
	}
	public int getGrade() {
		return grade;
	}
	public void setGrade(int grade) {
		this.grade = grade;
	}
	public int getMemberGrade_num() {
		return memberGrade_num;
	}
	public void setMemberGrade_num(int memberGrade_num) {
		this.memberGrade_num = memberGrade_num;
	}
	public String getStar() {
		return star;
	}
	public void setStar(String star) {
		this.star = star;
	}
	public String getBackground_color() {
		return background_color;
	}
	public void setBackground_color(String background_color) {
		this.background_color = background_color;
	}
	
	

}
