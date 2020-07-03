package kh.pingpong.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

import kh.pingpong.config.Configuration;
import kh.pingpong.dto.ChatRecordDTO;
import kh.pingpong.dto.ChatRoomDTO;
import kh.pingpong.dto.MemberDTO;
import kh.pingpong.service.ChatService;

@Controller
@RequestMapping("/chatting")
public class ChatController {
	
	@Autowired
	ChatService chatService;
	
	@Autowired
	private HttpSession session;
	
	@ResponseBody
	@RequestMapping(value="create", produces="application/text;charset=utf8"
)
	public String create(ChatRoomDTO chatDto) throws Exception{
		MemberDTO mdto = (MemberDTO)session.getAttribute("loginInfo");
		String roomId = null;
		String myName = mdto.getName();
		String usersIds = mdto.getId() +"," +chatDto.getChatMemberId();
		String usersNames = chatDto.getUser() +","+myName;
		
		Map<String,String> chatInfo = Configuration.chatCreate;
		chatInfo.put("usersName",usersNames);
		chatInfo.put("usersIds",usersIds);
		chatInfo.put("master",mdto.getId());
		chatInfo.put("partner",chatDto.getChatMemberId());
		
		String chatRoomId = chatService.chatRoomIdSch(chatInfo);
		int result = 0;
		
		if(chatRoomId == null) {
			roomId = chatService.rndTxt();
			chatInfo.put("roomId",roomId);
			result = chatService.chatInsert(chatInfo);
		}
		chatRoomId = chatService.chatRoomIdSch(chatInfo);
		List<ChatRecordDTO> chatRecord = chatService.chatRecordList(chatRoomId);
		Configuration.chatRecord = chatRecord;
		System.out.println(chatRecord.size());
		if(chatRecord.size() == 0) {
			System.out.println(chatRoomId);
			return chatRoomId;
		}else {
			if(result > 0) {
				//return chatRoomId;
				return new Gson().toJson(chatRecord);
			}else{
				chatInfo.put("roomId",chatRoomId);
				//return chatRoomId;
				return new Gson().toJson(chatRecord);
			}
		}
	}
	
}