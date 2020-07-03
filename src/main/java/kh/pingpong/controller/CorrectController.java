package kh.pingpong.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kh.pingpong.dao.CorrectDAO;
import kh.pingpong.dto.CorrectCDTO;
import kh.pingpong.dto.CorrectDTO;
import kh.pingpong.service.CorrectService;

@Controller
@RequestMapping("/correct")
public class CorrectController {
	@Autowired
	private CorrectDAO dao;
	
	@Autowired
	private CorrectService cservice;
	

	@RequestMapping("/correct_list")
	public String signUp(Model model, HttpServletRequest request) throws Exception{
		int cpage =1;
		List<CorrectDTO> list = cservice.selectAll();
		try {
		cpage =Integer.parseInt(request.getParameter("cpage"));
		} catch (Exception e) {}
		String navi = cservice.correct_paging(cpage);
		model.addAttribute("navi", navi);
		model.addAttribute("list", list);
		return "/correct/correct_list";
	}
	
	@RequestMapping("/correct_write")
	public String correct_write() {
		return "/correct/correct_write";
	}
	
	@RequestMapping("/writeProc")
	public String writeProc(CorrectDTO dto) throws Exception{
		System.out.println("test :" +dto.getContents());
		cservice.insert(dto);
		return "redirect:/correct/correct_list";
	}
	
	@RequestMapping("/correct_view")
	public String view(CorrectDTO dto, CorrectCDTO cdto, Model model) throws Exception{
		boolean in = false;
		dto = cservice.selectOne(dto.getSeq(),in);
		System.out.println("test :" +dto.getSeq());
		List<CorrectCDTO> ccdto = cservice.selectcAll(dto.getSeq());
		model.addAttribute("dto", dto);
		model.addAttribute("cdto", ccdto);
		return "/correct/correct_view";
	}
	
	
	@RequestMapping("/correct_modify")
	public String modify(CorrectDTO dto, Model model) throws Exception {
	dto = cservice.selectOne(dto.getSeq(), true);
		model.addAttribute("dto",dto);
	return "/correct/correct_modify";
	}
	
	
	@RequestMapping("/modifyProc")
	public String modifyP(CorrectDTO dto, Model model) throws Exception {
		System.out.println("modify" +dto.getSeq());
		model.addAttribute("seq",dto.getSeq());
		cservice.modify(dto);
		return "redirect:/correct/correct_view";
	}
	
	
	
	@ResponseBody
	@RequestMapping("/commentProc")
	public String commentProc(CorrectDTO dto,CorrectCDTO cdto, Model model) throws Exception{
		System.out.println(cdto.getWriter());
		System.out.println("testtt :" + cdto.getContents());
		int result = cservice.commentInsert(cdto);
		System.out.println("test :" + cdto.getContents());
		model.addAttribute("parent_seq", cdto.getParent_seq());
		cservice.countrep(cdto);
		if(result > 0) {
			return String.valueOf(true);
		}else {
			return String.valueOf(false);
		}
	}
	
	@ResponseBody
	@RequestMapping("/like")
	public String like(CorrectDTO dto) throws Exception {
		System.out.println("like : " +dto.getSeq());
		int result = cservice.like(dto);
		if(result > 0) {
			return String.valueOf(true);
		}else {
			return String.valueOf(false);
		}
	}
	
	@ResponseBody
	@RequestMapping("/hate")
	public String hate(CorrectDTO dto) throws Exception {
		System.out.println("hate : " +dto.getSeq());
		int result = cservice.hate(dto);
		if(result > 0) {
			return String.valueOf(true);
		}else {
			return String.valueOf(false);
		}
	}
	
	@ResponseBody
	@RequestMapping("/delete")
	public String delete(CorrectDTO dto) throws Exception {
		System.out.println("그 시퀀스값 :"+ dto.getSeq());
		int result = cservice.delete(dto);
		System.out.println(dto.getSeq());
		if(result > 0) {
			return String.valueOf(true);
		}else {
			return String.valueOf(false);
		}
	}
	
	
}