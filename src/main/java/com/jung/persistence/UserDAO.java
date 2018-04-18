package com.jung.persistence;


import java.util.Date;

import com.jung.domain.UserVO;
import com.jung.dto.LoginDTO;

public interface UserDAO {
	
	public UserVO login(LoginDTO dto)throws Exception;
	
	public void keepLogin(String uid, String sessionId, Date next);
	
	public UserVO checkUserWithSessionKey(String value);

}
