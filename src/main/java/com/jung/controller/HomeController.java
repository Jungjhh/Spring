package com.jung.controller;

import java.util.Locale;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping(value="/")
public class HomeController {
	
	
	
	@RequestMapping(value="test", method=RequestMethod.GET)
	public void ajaxTest() {
		
	}
	
	
	@RequestMapping(value="home", method=RequestMethod.GET)
	public void home() {
		
	}
	
	@RequestMapping(value="/doA", method=RequestMethod.GET)
	public String doA(Locale locale, Model model) {
		
		System.out.println("doA..........");
		
		
		return "home";
	}
	
	@RequestMapping(value="/doB", method=RequestMethod.GET)
	public String doB(Locale locale, Model model) {
		
		System.out.println("doB..........");
		
		model.addAttribute("result", "DOB RESULT");
		
		return "home";
	}
	
}
