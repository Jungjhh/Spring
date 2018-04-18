package com.jung.service;


import java.util.Date;

import com.jung.domain.UserVO;
import com.jung.dto.LoginDTO;

public interface UserService {
	
	public UserVO login(LoginDTO dto) throws Exception;
	
	public void keepLogin(String uid, String sessionId, Date sessionLimit) throws Exception;
	
	public UserVO checkLoginBefore(String value);
}
