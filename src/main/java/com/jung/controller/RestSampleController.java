package com.jung.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.jung.domain.ProductVO;

@RestController
@RequestMapping("/rest")
public class RestSampleController {
	
	@RequestMapping("/Hello")
	public String sayHello() {
		return "Hello World";
	}
	@RequestMapping("/sendVO")
	public ProductVO sendVO() {
		
		ProductVO vo = new ProductVO();
		
		vo.setName("������");
		vo.setPrice(10000);
		
		return vo; 
	}
	@RequestMapping("/sendList")
	public List<ProductVO> sendList(){
		
		List<ProductVO> list = new ArrayList<>();
		
		
		for(int i=0;i<10;i++) {
			ProductVO vo = new ProductVO("����", 9999);
			list.add(vo);
		}
		return list;
	}
	
	@RequestMapping("/sendMap")
	public Map<Integer, ProductVO> sendMap(){
		
		Map<Integer, ProductVO> map = new HashMap<>();
		
		
		for(int i=0;i<10;i++) {
			ProductVO vo = new ProductVO("����", 9999);
			map.put(i, vo);
		}
		return map;
	}
	
	@RequestMapping("/sendErrorAuth")
	public ResponseEntity<Void> sendListAuth(){
		
		return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
	}
	
	@RequestMapping("/sendErrorNot")
	public ResponseEntity<List<ProductVO>> sendListNot(){
		
		List<ProductVO> list = new ArrayList<>();
		for(int i=0;i<10;i++) {
			ProductVO vo = new ProductVO("����", 9999);
			list.add(vo);
		}
		
		return new ResponseEntity<>(list, HttpStatus.NOT_FOUND);	
		
	}

}
