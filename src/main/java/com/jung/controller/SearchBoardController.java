package com.jung.controller;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.jung.domain.BoardVO;
import com.jung.domain.PageMaker;
import com.jung.domain.SearchCriteria;
import com.jung.service.BoardService;

@Controller
@RequestMapping("/sboard/*")
public class SearchBoardController {
	private static final Logger logger = LoggerFactory.getLogger(SearchBoardController.class);

	@Inject
	private BoardService service;

	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public void listPage(@ModelAttribute("cri") SearchCriteria cri, Model model) throws Exception {

		logger.info(cri.toString());

		model.addAttribute("list", service.listSearchCriteria(cri));

		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);

		pageMaker.setTotalCount(service.listSearchCount(cri));
		System.out.println(pageMaker);

		model.addAttribute("pageMaker", pageMaker);
	}

	@RequestMapping(value = "/readPage", method = RequestMethod.GET)
	public void readPage(int bno, @ModelAttribute("cri") SearchCriteria cri, Model model) throws Exception {

		model.addAttribute(service.read(bno));
	}

	
	@RequestMapping(value="/removePage", method=RequestMethod.POST)
	public String remove(@RequestParam("bno") int bno, RedirectAttributes rttr, SearchCriteria cri) throws Exception {
		
		service.remove(bno);
		
		rttr.addAttribute("page", cri.getPage());
		rttr.addAttribute("perPageNum", cri.getPerPageNum());
		rttr.addAttribute("keyword", cri.getKeyword());
		rttr.addAttribute("searchType", cri.getSearchType());
		
		rttr.addFlashAttribute("msg", "remove");
		
		return "redirect:/sboard/list";
	}
	
	@RequestMapping(value="/modifyPage", method=RequestMethod.GET)
	public void modifyPagingGET(int bno, Model model, @ModelAttribute("cri") SearchCriteria cri) throws Exception {
		
		model.addAttribute(service.read(bno));
	}
	@RequestMapping(value="/modifyPage", method=RequestMethod.POST)
	public String modifyPagingPOST(BoardVO vo, RedirectAttributes rttr, SearchCriteria cri) throws Exception {
		
		service.modify(vo);

		rttr.addAttribute("page", cri.getPage());
		rttr.addAttribute("perPageNum", cri.getPerPageNum());
		rttr.addAttribute("keyword", cri.getKeyword());
		rttr.addAttribute("searchType", cri.getSearchType());
		
		rttr.addFlashAttribute("msg", "modify");
		
		return "redirect:/sboard/list";
	}
	
	@RequestMapping(value="/register", method=RequestMethod.GET)
	public void registerGET() throws Exception{
		
	}
	
	@RequestMapping(value="/register", method=RequestMethod.POST)
	public String registerPOST(BoardVO vo, RedirectAttributes rttr) throws Exception{
		
		service.register(vo);
		
		rttr.addFlashAttribute("msg", "regist");
		
		return "redirect:/sboard/list";
		
	}
	
	@RequestMapping("/getAttach/{bno}")
	@ResponseBody
	public List<String> getAttach(@PathVariable("bno") Integer bno) throws Exception{
		
		return service.getAttach(bno);
	}
	
	
}
