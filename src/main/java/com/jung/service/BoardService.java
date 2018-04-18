package com.jung.service;

import java.util.List;

import com.jung.domain.BoardVO;
import com.jung.domain.Criteria;
import com.jung.domain.SearchCriteria;

public interface BoardService {
	
	public void register(BoardVO board)throws Exception;
	
	public BoardVO read(Integer bno)throws Exception;
	
	public void modify(BoardVO board)throws Exception;
	
	public void remove(Integer bno)throws Exception;
	
	public List<BoardVO> listAll()throws Exception;
	
	public List<BoardVO> listCriteria(Criteria cri)throws Exception;
	
	public int listCountCriteria() throws Exception;
	
	public List<BoardVO> listSearchCriteria(SearchCriteria cri) throws Exception;
	
	public int listSearchCount(SearchCriteria cri) throws Exception;
	
	public List<String> getAttach(Integer bno) throws Exception; 
}
