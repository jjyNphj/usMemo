package com.twogether.usMemo.dto;

public class ListDTO {
	
	private int num, bNum;
	private Integer llink,rlink;
	//기능 상 link의 값에 null을 사용할 일이 있으므로, null 처리가 가능한 Integer타입을 사용함.
	//int는 null을 사용하지 못함. Primitive 자료형 타입임.
	//Integer는 null사용 가능. Wrapper 클래스의 객체임.
	//둘 사이는 java에서는 자동으로 변환해주기 때문에 그것 또한 편리하다. 
	private String name;
	
	
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
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Integer getLlink() {
		return llink;
	}
	public void setLlink(Integer llink) {
		this.llink = llink;
	}
	public Integer getRlink() {
		return rlink;
	}
	public void setRlink(Integer rlink) {
		this.rlink = rlink;
	}


}
