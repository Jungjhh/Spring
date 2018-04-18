package com.jung.controller;

import java.util.List;

import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.jung.domain.BoardVO;
import com.jung.domain.SearchCriteria;
import com.jung.persistence.BoardDAO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(
		locations= {"file:src/main/webapp/WEB-INF/spring/**/root-context.xml"})
public class BoardDAOTest {
	
	@Inject
	private BoardDAO dao;
	
	
	private static Logger logger = LoggerFactory.getLogger(BoardDAOTest.class);
	/*
	@Test
	public void testCreate() throws Exception{
		BoardVO board = new BoardVO();
		board.setTitle("���ο� ��");
		board.setContent("���ο� ��������");
		board.setWriter("user00");
		dao.create(board);
	}
	
	@Test
	public void testRead()throws Exception{
		logger.info(dao.read(8).toString());
	}
	*/
/*	@Test 
	public void testListPage() throws Exception{
		
		List<BoardVO> list = dao.listPage(3);
		
		for(BoardVO boardVO : list) {
			logger.info(boardVO.getBno()+":"+boardVO.getTitle());
		}
	}*/
	
/*	@Test
	public void testListCriteria()throws Exception{
		
		Criteria cri = new Criteria();
		
		cri.setPage(3);
		cri.setPerPageNum(20);
		List<BoardVO> list = dao.listCriteria(cri);
		
		for(BoardVO boardVO : list) {
			logger.info(boardVO.getBno()+":"+boardVO.getTitle());
		}
	}
*/
	@Test
	public void testDynamic1() throws Exception{
		
		SearchCriteria cri = new SearchCriteria();
		
		cri.setPage(1);
		cri.setKeyword("1��");
		cri.setSearchType("t");
		
		List<BoardVO> list = dao.listSearch(cri);
		
		for(BoardVO b:list) {
			logger.info(b.getBno()+":"+b.getTitle());
		}
		
		logger.info("count:"+dao.listSearchCount(cri));
	}
}
