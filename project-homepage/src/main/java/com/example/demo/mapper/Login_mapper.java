package com.example.demo.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.http.HttpHeaders;

import com.example.demo.VO.*;

@Mapper
public interface Login_mapper {

	ArrayList<LoginVO> idCheck(String id);
	
	ArrayList<LoginVO> phoneCheck(String phone);

	boolean create_account(String uid, String upw, String name, String phone);
	
	ArrayList<LoginVO> login(String uid, String upw);

	ArrayList<BoardVO> getList();
	
	String idsearch(String name, String phone);


}