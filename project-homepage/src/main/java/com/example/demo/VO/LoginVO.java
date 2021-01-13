package com.example.demo.VO;

public class LoginVO {
	
	private String uid;
	private String upw;
	private String name;
	private String phone;
	
	

	public LoginVO() {
		// TODO Auto-generated constructor stub
	}
	

	public LoginVO(String uid, String upw,String name,String phone) {
		this.uid = uid;
		this.upw = upw;
		this.name =name;
		this.phone =phone;
	}


	public String getUid() {
		return uid;
	}


	public void setUid(String uid) {
		this.uid = uid;
	}


	public String getUpw() {
		return upw;
	}


	public void setUpw(String upw) {
		this.upw = upw;
	}


	public String getName() {
		return name;
	}


	public void setName(String name) {
		this.name = name;
	}


	public String getPhone() {
		return phone;
	}


	public void setPhone(String phone) {
		this.phone = phone;
	}

	
	
	
	
	
}
