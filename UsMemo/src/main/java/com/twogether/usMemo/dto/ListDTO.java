package com.twogether.usMemo.dto;

public class ListDTO {
	
	private int num, bNum;
	private Integer llink,rlink;
	//��� �� link�� ���� null�� ����� ���� �����Ƿ�, null ó���� ������ IntegerŸ���� �����.
	//int�� null�� ������� ����. Primitive �ڷ��� Ÿ����.
	//Integer�� null��� ����. Wrapper Ŭ������ ��ü��.
	//�� ���̴� java������ �ڵ����� ��ȯ���ֱ� ������ �װ� ���� ���ϴ�. 
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
