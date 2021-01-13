package com.example.demo.controller;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.tiles.request.ApplicationContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.core.io.ResourceLoader;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.example.demo.VO.BoardVO;
import com.example.demo.mapper.Board_mapper;
import com.example.demo.mapper.Login_mapper;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

@Controller
public class HomePageController {

	@Autowired
	private Board_mapper bm;
	
	@Autowired
	private Login_mapper lm;
	
	@Autowired
	ResourceLoader resourceLoader;
	
	public static boolean login_status=false;
	public static String logid;
	
	@GetMapping("/home")
	public String indexPage(HttpSession session) {
		session.setAttribute("login_status", login_status);
		return "homepage";
	}
	
	@GetMapping("/board/{num}")
	public String board(@PathVariable int num, Model model, HttpSession session) {
		PageHelper.startPage(num, 15);
		PageInfo<BoardVO> list = new PageInfo<BoardVO>(bm.getList());
		model.addAttribute("pageList",list);
		session.setAttribute("login_status", login_status);
		return "board";
	}
	
	@GetMapping("/loginform")
	public String loginform() {
		return "loginform";
	}
	
	@PostMapping("/login")
	public String login(@RequestParam("uid") String uid,
			@RequestParam("upw") String upw,
			Model model, HttpSession session) {
		if(lm.login(uid, upw).isEmpty()) {
			model.addAttribute("login_result",true);
			return "loginform";
		}
		login_status=true;
		logid=uid;
		session.setAttribute("login_status", login_status);
		session.setAttribute("id", logid);
		return "homepage";	//이전페이지로 돌아가면 어떨까
	}
	
	@GetMapping("/upload")
	public String upload_form() {
		return "uploadform";
	}

	@PostMapping("/upload")
	public String upload(@RequestParam("files")MultipartFile[] mfiles,
			HttpServletRequest request,
			@RequestParam("author") String author,
			@RequestParam("title") String title,
			@RequestParam("contents") String contents) {
		ServletContext context = request.getServletContext();
		String savePath = context.getRealPath("/WEB-INF/upload");
		bm.insert(author, title, contents);
		var num = bm.getnum();
		// mfiles[i].getOriginalFilename().substring(0,mfiles[i].getOriginalFilename().lastIndexOf("."))
		// mfiles[i].getOriginalFilename().substring(mfiles[i].getOriginalFilename().lastIndexOf(".") + 1)
		if(mfiles[0].getSize()==0) return "redirect:board/1";
		try {
			for(int i=0; i<mfiles.length;i++) {
				bm.attach(num, mfiles[i].getOriginalFilename().substring(0,mfiles[i].getOriginalFilename().lastIndexOf(".")),mfiles[i].getSize(),mfiles[i].getOriginalFilename().substring(mfiles[i].getOriginalFilename().lastIndexOf(".") + 1));
				mfiles[i].transferTo(
				new File(savePath+"/"+bm.getnum()+"."+ mfiles[i].getOriginalFilename().substring(mfiles[i].getOriginalFilename().lastIndexOf(".") + 1)));			
				}
			return "redirect:board/1";
		} catch (Exception e) {
			return "redirect:board/1";
		}
	}
	
	@GetMapping("/create_account")
	public String create_account_form() {
		return "create_account_form";
	}
	
	@ResponseBody
	@PostMapping("/idCheck")
	public String idcheck(@RequestParam("id") String id) {
		if(lm.idCheck(id).isEmpty()) {
			return "true";		
		}
		return "false";		
	}
	
	@ResponseBody
	@PostMapping("/phoneCheck")
	public String phonecheck(@RequestParam("phone") String phone) {
		if(lm.phoneCheck(phone).isEmpty()) {
			return "true";		
		}
		return "false";		
	}
	
	@PostMapping("/create_account")
	public String create_account(@RequestParam("id") String id,
			@RequestParam("pw") String pw,
			@RequestParam("name") String name,
			@RequestParam("phone") String phone){
		lm.create_account(id, pw, name, phone);
		return "loginform";	//성공적으로 계정이 생성되었습니다.
	}
	
	@GetMapping("/details")
	public String details(Model model, @RequestParam("num") int num, HttpSession session,HttpServletRequest request) {		
		if(bm.didhit(request.getRemoteAddr(), num)==0) {
			bm.countUpdate(num); 
			bm.addhit(request.getRemoteAddr(), num);
		}
		model.addAttribute("list",bm.select(num));
		model.addAttribute("attach",bm.selectatt(num));
		if((boolean) session.getAttribute("login_status")) {
			model.addAttribute("didlike",bm.didlike(num, session.getAttribute("id").toString().trim()));
		}else {
			model.addAttribute("didlike",0);
		}
		return "details";
	}
	
	@GetMapping("/download")
	public ResponseEntity<Resource> download(
			HttpServletRequest request,
			@RequestParam("u_num") int u_num,
			@RequestParam("file_exe") String file_exe){
		org.springframework.core.io.Resource resource = resourceLoader.getResource("WEB-INF/upload/"+u_num+"."+file_exe);
		String contentType =null;
		try {
		contentType =request.getServletContext().getMimeType(resource.getFile().getAbsolutePath());	
		}catch (IOException e) {
			e.printStackTrace();
		}
		if(contentType==null) {
			contentType="application/octet-stream";			//파일다운로드창을 열게 한다.
		}	
		return ResponseEntity.ok().contentType(MediaType.parseMediaType(contentType))
		.header(HttpHeaders.CONTENT_DISPOSITION ,
				"attachment; filename=\"" + bm.select_for_down(u_num)+"."+file_exe+"\"").body(resource);
	}
	
	@PostMapping("/delete")
	public String delete(@RequestParam("num") int num) {	
		bm.delete(num); 
		return "redirect:/board/1";
	}
	
	@PostMapping("/update_a")						//ajax_req을 포스트로 받으면 실핼되는것	
	public String update_a(Model model, @RequestParam("num") int num) {
		model.addAttribute("list",bm.select(num));
		return "update_form";
	}
	
	@PostMapping("/update")						//ajax_req을 포스트로 받으면 실핼되는것	
	public String update(@RequestParam("num") int num,
			@RequestParam("files")MultipartFile[] mfiles,
			HttpServletRequest request,
			@RequestParam("title") String title,
			@RequestParam("contents") String contents) {
		ServletContext context = request.getServletContext();
		String savePath = context.getRealPath("/WEB-INF/upload");
		bm.deleteatt(num);
		bm.update(num,title, contents);
		if(mfiles[0].getSize()==0) return "redirect:/board/1";
			try {
				for(int i=0; i<mfiles.length;i++) {
					bm.attach(num, mfiles[i].getOriginalFilename().substring(0,mfiles[i].getOriginalFilename().lastIndexOf(".")),mfiles[i].getSize(),mfiles[i].getOriginalFilename().substring(mfiles[i].getOriginalFilename().lastIndexOf(".") + 1));
					mfiles[i].transferTo(
							new File(savePath+"/"+bm.getnum()+"."+ mfiles[i].getOriginalFilename().substring(mfiles[i].getOriginalFilename().lastIndexOf(".") + 1)));			
					
				}
				return "redirect:/board/1";
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				return "redirect:/board/1";
			}
	}
	
	public String sas_p;
	public String sen_p;
	
	@PostMapping("/search/{num}")
	public String search(@RequestParam("search_as") String sas,
			@RequestParam("search") String sen,Model model,@PathVariable int num) {
		sas_p=sas;
		sen_p=sen;
		PageHelper.startPage(num, 15);
		PageInfo<BoardVO> list = new PageInfo<BoardVO>(bm.search(sas, sen));
		model.addAttribute("pageList",list);
		return "search_result";
	}
	
	@GetMapping("/search/{num}")
	public String search_page(Model model,@PathVariable int num) {
		PageHelper.startPage(num, 15);
		PageInfo<BoardVO> list = new PageInfo<BoardVO>(bm.search(sas_p, sen_p));
		model.addAttribute("pageList",list);
		return "search_result";
	}
 	
	@GetMapping("comment_a/{num}")
	public String comment_a(Model model, @PathVariable int num) {
		model.addAttribute("list",bm.select(num));
		return "comment_form";
	}
	
	@PostMapping("comment")						//ajax_req을 포스트로 받으면 실핼되는것	
	public String make_comment(@RequestParam("files")MultipartFile[] mfiles,
			HttpServletRequest request,
			@RequestParam("pnum") int pnum,
			@RequestParam("author") String author,
			@RequestParam("title") String title,
			@RequestParam("contents") String contents) {
		ServletContext context = request.getServletContext();
		String savePath = context.getRealPath("/WEB-INF/upload");
		bm.comment(pnum,author, title, contents);
		var num = bm.getnum();
		if(mfiles[0].getSize()==0)	return "redirect:/board/1";
			try {
				for(int i=0; i<mfiles.length;i++) {
					bm.attach(num, mfiles[i].getOriginalFilename().substring(0,mfiles[i].getOriginalFilename().lastIndexOf(".")),mfiles[i].getSize(),mfiles[i].getOriginalFilename().substring(mfiles[i].getOriginalFilename().lastIndexOf(".") + 1));
					mfiles[i].transferTo(
							new File(savePath+"/"+bm.getnum()+"."+ mfiles[i].getOriginalFilename().substring(mfiles[i].getOriginalFilename().lastIndexOf(".") + 1)));			
					
				}
				return "redirect:/board/1";
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				return "redirect:/board/1";
			}
	}
	
	@GetMapping("/forgot")
	public String forgot() {
		return "forgot";
	}
	
	@ResponseBody
	@PostMapping("/idSearch")
	public String idSearch(@RequestParam("name") String name,
			@RequestParam("phone") String phone) {
		if(lm.idsearch(name, phone).isEmpty()) {
			return "no id";		
		}
		return lm.idsearch(name, phone);		
	}
	
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		login_status=false;
		logid=null;
		session.setAttribute("login_status", login_status);
		session.setAttribute("id", logid);
		return "homepage";
	}
	
	@PostMapping("/delteatt")						
	public String delteatt(@RequestParam("num") int num, @RequestParam("filename") String filename) {
		bm.deleteoneatt(num, filename); 
		return "redirect:/details?num="+num;
	}
	
	@ResponseBody
	@PostMapping("/like")
	public int like(@RequestParam("num") int num,@RequestParam("id") String id) {
		bm.like(num, id);
		bm.likec(num);
		return bm.like_n(num);
	}
	
	@ResponseBody
	@PostMapping("/like_cancle")
	public int like_cancle(@RequestParam("num") int num,@RequestParam("id") String id) {
		bm.like_cancle(num, id);
		bm.likec_cancle(num);
		return bm.like_n(num);
	}


}
