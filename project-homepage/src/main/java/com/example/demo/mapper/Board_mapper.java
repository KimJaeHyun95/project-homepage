package com.example.demo.mapper;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import com.example.demo.VO.*;

@Mapper
public interface Board_mapper {


	boolean insert(String author, String title, String contents);

	int getnum();

	boolean attach(int num, String filename, long filesize, String file_exe);

	ArrayList<BoardVO> getList();
	
	boolean countUpdate(int num);

	BoardVO select(int num);
	
	ArrayList<Board_attachVO> selectatt(int num);
	
	boolean delete(int num);

	boolean deleteatt(int num);

	boolean update(int num,  String title, String contents);

	List<BoardVO> search(String sas, String sen);
		
	boolean comment(int pnum, String author, String title, String contents);

	boolean deleteoneatt(int num, String filename);
	
	boolean like(int num, String id);

	boolean	likec(int num);
	
	boolean like_cancle(int num, String id);

	boolean	likec_cancle(int num);
	
	int didlike(int num, String id);
	
	String select_for_down(int u_num);
	
	int didhit(String ip, int num);

	boolean addhit(String ip, int num);

	int like_n(int num);

}
