package com.example.demo.VO;

public class Board_attachVO {
	private int num;
	private String filename;
	private long filesize;
	private String file_exe;
	private int u_num;
	

	public Board_attachVO() {
		// TODO Auto-generated constructor stub
	}
	

	public Board_attachVO(int num, String filename, long filesize, String file_exe, int u_num) {
		this.num = num;
		this.filename = filename;
		this.filesize = filesize;
		this.file_exe = file_exe;
		this.u_num = u_num;
	}


	public int getU_num() {
		return u_num;
	}


	public void setU_num(int u_num) {
		this.u_num = u_num;
	}


	public String getFile_exe() {
		return file_exe;
	}


	public void setFile_exe(String file_exe) {
		this.file_exe = file_exe;
	}


	public int getNum() {
		return num;
	}


	public void setNum(int num) {
		this.num = num;
	}


	public String getFilename() {
		return filename;
	}


	public void setFilename(String filename) {
		this.filename = filename;
	}


	public long getFilesize() {
		return filesize;
	}


	public void setFilesize(long filesize) {
		this.filesize = filesize;
	}
	
	
}
