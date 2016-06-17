package com.twogether.usMemo.dto;

import java.util.Date;

public class ActivityData {
	private int num,activity_name_num,bNum,value_num,to_num,from_num,activity_num,activity_data_num;
	private String memId,value_string,last_activity;
	private Date write_time;
	
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public int getActivity_name_num() {
		return activity_name_num;
	}
	public void setActivity_name_num(int activity_name_num) {
		this.activity_name_num = activity_name_num;
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
	public int getActivity_num() {
		return activity_num;
	}
	public void setActivity_num(int activity_num) {
		this.activity_num = activity_num;
	}
	public int getActivity_data_num() {
		return activity_data_num;
	}
	public void setActivity_data_num(int activity_data_num) {
		this.activity_data_num = activity_data_num;
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
	public String getLast_activity() {
		return last_activity;
	}
	public void setLast_activity(String last_activity) {
		this.last_activity = last_activity;
	}
	public Date getWrite_time() {
		return write_time;
	}
	public void setWrite_time(Date write_time) {
		this.write_time = write_time;
	}
	
	
	
}
