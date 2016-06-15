package com.twogether.usMemo.dto;

import java.sql.Date;

public class ActivityData {
	private int num,format_num,activity_name_num,bNum,value_num,to_num,from_num;
	private String memId,value_string,activity_name,format,name,nickname,profile_image,email;
	private Date write_time;
	
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
	public int getValue_num() {
		return value_num;
	}
	public void setValue_num(int value_num) {
		this.value_num = value_num;
	}
	public int getTo_num() {
		return to_num;
	}
	public void setTo_num(int to_num) {
		this.to_num = to_num;
	}
	public int getFrom_num() {
		return from_num;
	}
	public void setFrom_num(int from_num) {
		this.from_num = from_num;
	}
	public String getMemId() {
		return memId;
	}
	public void setMemId(String memId) {
		this.memId = memId;
	}
	public String getValue_string() {
		return value_string;
	}
	public void setValue_string(String value_string) {
		this.value_string = value_string;
	}
	public Date getWrite_time() {
		return write_time;
	}
	public void setWrite_time(Date write_time) {
		this.write_time = write_time;
	}
	public int getFormat_num() {
		return format_num;
	}
	public void setFormat_num(int format_num) {
		this.format_num = format_num;
	}
	public String getActivity_name() {
		return activity_name;
	}
	public void setActivity_name(String activity_name) {
		this.activity_name = activity_name;
	}
	public String getFormat() {
		return format;
	}
	public void setFormat(String format) {
		this.format = format;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getProfile_image() {
		return profile_image;
	}
	public void setProfile_image(String profile_image) {
		this.profile_image = profile_image;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public int getActivity_name_num() {
		return activity_name_num;
	}
	public void setActivity_name_num(int activity_name_num) {
		this.activity_name_num = activity_name_num;
	}
	
	
	
}
