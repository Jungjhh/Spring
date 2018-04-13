package com.jung.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jung.domain.MessageVO;
import com.jung.persistence.MessageDAO;
import com.jung.persistence.PointDAO;

@Service
public class MessageServiceImpl implements MessageService{

	@Inject
	private MessageDAO messageDAO;
	
	@Inject
	private PointDAO pointDAO;
	
	@Transactional
	@Override
	public void addMessage(MessageVO vo) throws Exception {
		messageDAO.create(vo);
		pointDAO.updatePoint(vo.getSender(), 10);
	}

	@Override
	public MessageVO readMessage(String uid, Integer mno) throws Exception {
		
		messageDAO.updateState(mno);
		pointDAO.updatePoint(uid, 5);
		
		return messageDAO.readMessage(mno);
		
	}

}
