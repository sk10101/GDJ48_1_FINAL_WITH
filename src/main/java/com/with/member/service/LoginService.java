package com.with.member.service;

import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.with.member.dao.LoginDAO;
import com.with.member.dao.MemberDAO;
import com.with.member.dto.MemberDTO;

@Service
public class LoginService {

	Logger logger = LoggerFactory.getLogger(this.getClass());

	@Autowired LoginDAO dao;
	@Autowired MemberDAO mbdao;
	
	public MemberDTO login(String id, String pw) {
		logger.info("로그인 서비스");
		
		MemberDTO dto = new MemberDTO();
		String hashPw = dao.login(id,pw);
		String loginId = null;
		String member_class = null;

		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		if (encoder.matches(pw, hashPw)) {
			loginId = id;
			member_class = dao.getMbClass(id);
		}
		
		dto.setMember_id(loginId);
		dto.setMember_class(member_class);
		
		return dto;

	}
	
	//유저 정보 가져오기
	public MemberDTO getMbInfo(String id) {
		return dao.getMbInfo(id);
	}
	
	//아이디 찾기
	public String idFind(String name, String email) {
		String idFind = dao.idFind(name,email); 
		logger.info("아이디 :"+idFind);
		
		return idFind;
	}
	
	//비밀번호 찾기
	public int pwFind(String id, String email) {
		return dao.pwFind(id,email);
	}

	//비밀번호 수정
	public boolean newPw(String id, String pw) { 
		boolean success =dao.newPw(id,pw); 
		return success; 
	}	
	
	/* 양수빈 service 작업 공간 
	
	public HashMap<String, Object> mblist(String loginId) {
		return mbdao.mblist(loginId);
	}

	public String univer(Object object) {
		return mbdao.univer(object);
	}

	public int macnt(String loginId) {
		return mbdao.macnt(loginId);
	}

	 여기까지 */
	
	/*
	 * // member(admin)Main으로 돌아가기
	 * 
	 * @Override public String cancle(long m_number) { MemberDTO member =
	 * mr.findNum(m_number); if(member!=null) {
	 * if(member.getM_id().equals("admin123")) { session.invalidate();
	 * session.setAttribute("loginId", member.getM_id());
	 * session.setAttribute("loginNumber", member.getM_number());
	 * session.setAttribute("loginName", member.getM_name()); return
	 * "member/adminMain"; } session.invalidate(); session.setAttribute("loginId",
	 * member.getM_id()); session.setAttribute("loginNumber", member.getM_number());
	 * session.setAttribute("loginName", member.getM_name()); return
	 * "member/memberMain"; } else { return "member/memberMain"; } }
	 */

	/*
	 * // memberList 요청
	 * 
	 * @Override public List<MemberDTO> findAll() { return mr.findAll(); }
	 */

	/*
	 * // 카카오 로그인 public String getAccessToken(String authorize_code) { String
	 * access_Token = ""; String refresh_Token = ""; String reqURL =
	 * "https://kauth.kakao.com/oauth/token";
	 * 
	 * try { URL url = new URL(reqURL);
	 * 
	 * HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	 * 
	 * // POST 요청을 위해 기본값이 false인 setDoOutput을 true로
	 * 
	 * conn.setRequestMethod("POST"); conn.setDoOutput(true);
	 * 
	 * // POST 요청에 필요로 요구하는 파라미터 스트림을 통해 전송 BufferedWriter bw = new
	 * BufferedWriter(new OutputStreamWriter(conn.getOutputStream())); StringBuilder
	 * sb = new StringBuilder(); sb.append("grant_type=authorization_code");
	 * sb.append("&client_id=b8239aad28fc4b4100b8f469df9c704f"); // 본인이 발급받은 key
	 * sb.append("&redirect_uri=http://localhost:8080/kakaoLogin"); // 본인이 설정해 놓은 경로
	 * sb.append("&code=" + authorize_code); bw.write(sb.toString()); bw.flush();
	 * 
	 * // 결과 코드가 200이라면 성공 int responseCode = conn.getResponseCode();
	 * System.out.println("responseCode : " + responseCode);
	 * 
	 * // 요청을 통해 얻은 JSON타입의 Response 메세지 읽어오기 BufferedReader br = new
	 * BufferedReader(new InputStreamReader(conn.getInputStream())); String line =
	 * ""; String result = "";
	 * 
	 * while ((line = br.readLine()) != null) { result += line; }
	 * System.out.println("response body : " + result);
	 * 
	 * // Gson 라이브러리에 포함된 클래스로 JSON파싱 객체 생성 JsonParser parser = new JsonParser();
	 * JsonElement element = parser.parse(result);
	 * 
	 * access_Token = element.getAsJsonObject().get("access_token").getAsString();
	 * refresh_Token = element.getAsJsonObject().get("refresh_token").getAsString();
	 * 
	 * System.out.println("access_token : " + access_Token);
	 * System.out.println("refresh_token : " + refresh_Token);
	 * 
	 * br.close(); bw.close(); } catch (IOException e) { // TODO Auto-generated
	 * catch block e.printStackTrace(); }
	 * 
	 * return access_Token; }
	 * 
	 * 
	 * 
	 * // 카카오 로그인 정보 저장 public KakaoDTO getUserInfo(String access_Token) {
	 * 
	 * // 요청하는 클라이언트마다 가진 정보가 다를 수 있기에 HashMap타입으로 선언 HashMap<String, Object>
	 * userInfo = new HashMap<String, Object>(); String reqURL =
	 * "https://kapi.kakao.com/v2/user/me"; try { URL url = new URL(reqURL);
	 * HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	 * conn.setRequestMethod("GET");
	 * 
	 * // 요청에 필요한 Header에 포함될 내용 conn.setRequestProperty("Authorization", "Bearer "
	 * + access_Token);
	 * 
	 * int responseCode = conn.getResponseCode();
	 * System.out.println("responseCode : " + responseCode);
	 * 
	 * BufferedReader br = new BufferedReader(new
	 * InputStreamReader(conn.getInputStream()));
	 * 
	 * String line = ""; String result = "";
	 * 
	 * while ((line = br.readLine()) != null) { result += line; }
	 * System.out.println("response body : " + result);
	 * 
	 * JsonParser parser = new JsonParser(); JsonElement element =
	 * parser.parse(result);
	 * 
	 * JsonObject properties =
	 * element.getAsJsonObject().get("properties").getAsJsonObject(); JsonObject
	 * kakao_account =
	 * element.getAsJsonObject().get("kakao_account").getAsJsonObject();
	 * 
	 * String nickname = properties.getAsJsonObject().get("nickname").getAsString();
	 * String email = kakao_account.getAsJsonObject().get("email").getAsString();
	 * 
	 * userInfo.put("nickname", nickname); userInfo.put("email", email);
	 * 
	 * } catch (IOException e) { // TODO Auto-generated catch block
	 * e.printStackTrace(); }
	 * 
	 * KakaoDTO result = dao.findkakao(userInfo); System.out.println("S:" + result);
	 * if (result == null) { dao.kakaoinsert(userInfo); return
	 * dao.findkakao(userInfo); } else { return result; }
	 * 
	 * }
	 * 
	 * 
	 * // 카카오 번호찾기 public KakaoDTO kakaoNumber(KakaoDTO userInfo) { return
	 * dao.kakaoNumber(userInfo); }
	 */

}
