package com.example.demo.VO;

public class BoardVO {
	private int num;
	private String author;
	private String wdate;
	private String title;
	private String contents;
	private int hit;
	private int like_n;
	private int pnum;
	
	public BoardVO() {
		// TODO Auto-generated constructor stub
	}

	public BoardVO( int num,String author,String wdate, String title,String contents, int hit, int like_n, int pnum) {
		this.num = num;
		this.author = author;
		this.wdate = wdate;
		this.title = title;
		this.contents=contents;	
		this.hit = hit;
		this.like_n = like_n;
		this.pnum = pnum;
	}

	public int getLike_n() {
		return like_n;
	}

	public void setLike_n(int like_n) {
		this.like_n = like_n;
	}

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public String getAuthor() {
		return author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}

	public String getWdate() {
		return wdate;
	}

	public void setWdate(String wdate) {
		this.wdate = wdate;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}

	public int getHit() {
		return hit;
	}

	public void setHit(int hit) {
		this.hit = hit;
	}

	public int getlike_n() {
		return like_n;
	}

	public void setlike_n(int like_n) {
		this.like_n = like_n;
	}

	public int getPnum() {
		return pnum;
	}

	public void setPnum(int pnum) {
		this.pnum = pnum;
	}
	
}
