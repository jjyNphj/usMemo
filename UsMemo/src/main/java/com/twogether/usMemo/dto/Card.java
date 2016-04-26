package com.twogether.usMemo.dto;

import java.util.Date;

public class Card {
	
	private int num,lNum;
	private String name,content,attach,memId;
	private Date n_date;
	private Integer llink, rlink;
	
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public int getlNum() {
		return lNum;
	}
	public void setlNum(int lNum) {
		this.lNum = lNum;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getAttach() {
		return attach;
	}
	public void setAttach(String attach) {
		this.attach = attach;
	}
	public Date getN_date() {
		return n_date;
	}
	public void setN_date(Date n_date) {
		this.n_date = n_date;
	}
	public String getMemId() {
		return memId;
	}
	public void setMemId(String memId) {
		this.memId = memId;
	}
	public Integer getRlink() {
		return rlink;
	}
	public void setRlink(Integer rlink) {
		this.rlink = rlink;
	}
	public Integer getLlink() {
		return llink;
	}
	public void setLlink(Integer llink) {
		this.llink = llink;
	}
	
	
	
	
}
