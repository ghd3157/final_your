
package bit.your.prj.controller;


import java.io.PrintWriter;

import java.util.Date;


import java.util.Random;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.scribejava.core.model.OAuth2AccessToken;

import bit.your.prj.dto.MemberDto;
import bit.your.prj.oauth.bo.NaverLoginBO;
import bit.your.prj.service.MemberService;



@Controller
public class MemberController {
	
	static Logger log = LoggerFactory.getLogger(MemberController.class);
	
	@Autowired
	MemberService service;
	
	@Autowired
	private JavaMailSender mailSender;
	
	
	@RequestMapping(value = "login.do",  method = {RequestMethod.GET, RequestMethod.POST})
	public String login() {
		log.info("MemberController login() " + new Date());
		
		return "login.tiles";
		
	}
	
	@RequestMapping(value = "regi.do",  method = {RequestMethod.GET, RequestMethod.POST})
	public String regi(MemberDto dto) {
		log.info("MemberController regi() " + new Date());

		
		return "regi.tiles";
	}
	
	@ResponseBody
	@RequestMapping(value = "getId.do",  method = {RequestMethod.GET, RequestMethod.POST})
	public String getId(MemberDto mem) {	
		log.info("MemberController getId() " + new Date());
		
		int count = service.getId(mem);
		String msg = "";
		if(count > 0) {
			msg = "YES";
		}else {
			msg = "NO";
		}
		return msg;
	}
	
	@ResponseBody
	@RequestMapping(value = "getnickname.do",  method = {RequestMethod.GET, RequestMethod.POST})
	public String getnickname(MemberDto mem) {	
		log.info("MemberController getnickname() " + new Date());
		
		int count = service.getnickname(mem);
		String msg = "";
		if(count > 0) {
			msg = "YES";
		}else {
			msg = "NO";
		}
		return msg;
	}

	@RequestMapping(value = "loginAf.do",  method = {RequestMethod.GET, RequestMethod.POST})
	public String loginAf(MemberDto dto, HttpServletRequest req) {
		log.info("MemberController loginAf() " + new Date());
		
		MemberDto login = service.login(dto);
		if(login != null && !login.getId().equals("")) {
			System.out.println("????????????????????????");
			req.getSession().setAttribute("login", login);
			req.getSession().setMaxInactiveInterval(60 * 60 * 24);
			
			return "redirect:/home.do";
		}else {
			System.out.println("????????? ?????????????????????");
			return "redirect:/login.do";
		}
		
		
		}
		@RequestMapping(value = "regiAf.do", method = {RequestMethod.GET, RequestMethod.POST})
		public String regiAf(MemberDto dto, Model model, HttpServletRequest request) {
			log.info("MemberController regiAf() " + new Date());

			boolean b = service.addmember(dto);
			
			if(b) {
				System.out.println("???????????????????????????");
				return "login.tiles";
			}else {
			
			System.out.println("???????????? ???????????????");		
			return "regi.tiles";		

	}
		}
		
		@RequestMapping(value = "findid.do",  method = {RequestMethod.GET, RequestMethod.POST})
		public String findid() {
			log.info("MemberController findid() " + new Date());
			return "findid.tiles";
		}
		
		@RequestMapping(value = "findidAf.do",  method = {RequestMethod.GET, RequestMethod.POST})
		public String findidAf(MemberDto dto, Model model) {
			log.info("MemberController findid() " + new Date());
			MemberDto mem = service.findid(dto);
			
			if(mem == null) { 
				model.addAttribute("check", 1);
			} else { 
				model.addAttribute("check", 0);
				model.addAttribute("id", mem.getId());
			}
			
			return "findid.tiles";
		}
		
		/* ???????????? ?????? */
		@RequestMapping(value = "findpw.do",  method = RequestMethod.GET)
		public String findpw() {
			log.info("MemberController findpw() " + new Date());
			return "findpw.tiles";
		}
		

		@RequestMapping(value="findpw.do", method = RequestMethod.POST)
		public String findpwAf(@ModelAttribute MemberDto mem, HttpServletResponse resp) throws Exception{
			log.info("MemberController findpwAf() " + new Date());
			
			service.findpw(resp, mem);
			
			
		return "login.tiles";
		}
	
		

			/* ????????? ?????? */
			@ResponseBody
			@RequestMapping(value="mailCheck.do", method = {RequestMethod.GET, RequestMethod.POST})
			public String mailCheckGET(String email) throws Exception{
				log.info("MemberController mailcheck() " + new Date());
				
				log.info("????????????" + email);
						
				/* ????????????(??????) ?????? */
				Random random = new Random();
				int checkNum = random.nextInt(888888) + 111111;
				
				/* ????????? ????????? */
				String setFrom = "yourrecipe202@gmail.com";
				String toMail = email;
				String title = "???????????? ?????? ????????? ?????????.";
				String content = 
						"YOUR(Your Own Uniqe Recipe)??? ?????????????????? ???????????????." +
						"<br><br>" + 
						"?????? ????????? " +
						checkNum + "?????????." + 
						"<br>" + 
						"?????? ??????????????? ???????????? ???????????? ???????????? ?????????.";		
				
				try {
					
					MimeMessage message = mailSender.createMimeMessage();
					MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
					helper.setFrom(setFrom);
					helper.setTo(toMail);
					helper.setSubject(title);
					helper.setText(content,true);
					mailSender.send(message);
					
				}catch(Exception e) {
					e.printStackTrace();
				}		
				
				String num = Integer.toString(checkNum);
				
				return num;
				
			}
			
			@RequestMapping(value="mypage_main.do", method = {RequestMethod.GET, RequestMethod.POST})
			public String mypage_main()  {
				log.info("MemberController mypage_main() " + new Date());
			
			  return "mypage_main.tiles";
			
			}
		
		@RequestMapping(value="info.do", method = {RequestMethod.GET, RequestMethod.POST})
		public String info(HttpSession session, Model model, HttpServletRequest request)  {
			log.info("MemberController info() " + new Date());

			//?????? ?????? ?????? ?????? ID?????? ??????
			MemberDto login = (MemberDto)request.getSession().getAttribute("login");
		    String id = login.getId();
			
			//??????????????? ?????????????????? ????????? ??????
			MemberDto dto = service.readmember(id);
			//???????????? ??? ????????? ??????
			model.addAttribute("mem", dto);
			
			return "info.tiles";
		}
		
		@RequestMapping(value="info_update.do", method = {RequestMethod.GET, RequestMethod.POST})
		public String info_update(HttpSession session, Model model, HttpServletRequest request) {
			log.info("MemberController info_update() " + new Date());

			//?????? ?????? ?????? ?????? ID?????? ??????
			MemberDto login = (MemberDto)request.getSession().getAttribute("login");
		    String id = login.getId();
			
			//??????????????? ?????????????????? ????????? ??????
			MemberDto dto = service.readmember(id);
			
			model.addAttribute("mem", dto);
		    
			return "info_update.tiles";
		}
		
		@RequestMapping(value="info_updateAf.do", method = {RequestMethod.GET, RequestMethod.POST})
		public String info_updateAf(HttpSession session, Model model, HttpServletRequest request, MemberDto dto) {
			log.info("MemberController info_updateAf() " + new Date());

			//?????? ?????? ?????? ?????? ID?????? ??????
			MemberDto login = (MemberDto)request.getSession().getAttribute("login");
		    String id = login.getId();
			
			//??????????????? ?????????????????? ????????? ??????
			MemberDto mem = service.readmember(id);
			
			model.addAttribute("mem", dto);
		
		    service.updatemember(dto);
		
	
		return "info.tiles";
		}
		
	
		
		@RequestMapping(value="info_del.do", method = {RequestMethod.GET, RequestMethod.POST})
		public String info_update(HttpSession session, HttpServletRequest request, Model model, MemberDto dto) {
			log.info("MemberController info_del() " + new Date());
			
			//?????? ?????? ?????? ?????? ID?????? ??????
			MemberDto login = (MemberDto)request.getSession().getAttribute("login");
		    String id = login.getId();
		    
		    MemberDto mem = service.readmember(id);
			
			model.addAttribute("mem", dto);
		    
		    if(id == null) {
		    	return "redirect:/login.do";
		    }
			
			
		return "info_del.tiles";
		
		}
		
		@RequestMapping(value="info_delAf.do", method = {RequestMethod.GET, RequestMethod.POST})
		public String info_updateAf(HttpServletResponse resp,MemberDto mem, HttpSession session, String pwd, HttpServletRequest request) throws Exception {
			log.info("MemberController info_delAf() " + new Date());
			log.info("del????????????" + mem);

			//?????? ?????? ?????? ?????? ID?????? ??????
			MemberDto login = (MemberDto)request.getSession().getAttribute("login");
		    String id = login.getId();
			
			if(mem.getId() != id || mem.getPwd() != pwd) {
				 resp.setContentType("text/html; charset=utf-8");
			     PrintWriter out = resp.getWriter();
				out.print("<script>alert('????????? ?????? ??????????????? ???????????????!'); location.href='info_del.do'; </script> ");
				out.close();
			}else {
			
		service.deletemember(mem);
		// ???????????????
		session.invalidate();
		
		
			}
		
		return "home.tiles";
		
		

		
		
		}
		

		@RequestMapping(value="logout.do", method = {RequestMethod.GET, RequestMethod.POST})
		public String logout(HttpSession session) {
			log.info("MemberController logout() " + new Date());
			
		session.invalidate();
		
		return "redirect:/home.do";
		
		}
		
		
		
	
		
		
		
//		/*?????? ?????? api ???????????????------------------------------------------------------------------------------------------------------------0822*/
//	    
//		//?????????
//	    private NaverLoginBO naverLoginBO;
//	    private String apiResult = null;
//
//		
//	    @Autowired
//	    private void setNaverLoginBO(NaverLoginBO naverLoginBO) {
//	        this.naverLoginBO = naverLoginBO;
//	    }
//	    
//	    
//	    
//	    
//		@RequestMapping(value = "login.do",  method = {RequestMethod.GET, RequestMethod.POST})
//	    public String naverLogin(Model model, HttpSession session) {
//			log.info("MemberController logintesttttt () " + new Date());
//
//			//* ????????????????????? ?????? URL??? ???????????? ????????? naverLoginBO???????????? getAuthorizationUrl????????? ?????? *//*
//	        String naverAuthUrl = naverLoginBO.getAuthorizationUrl(session);
//	        // ?????????
//	        model.addAttribute("naverUrl", naverAuthUrl);
//
//	        return "login.tiles";
//	    }
//	    
//	    @RequestMapping(value = "callback-naver.do", method = { RequestMethod.GET, RequestMethod.POST })
//	    public String naverCallback(Model model, @RequestParam String code, @RequestParam String state, HttpSession session) throws Exception {
//
//	        OAuth2AccessToken oauthToken;
//	        // 1. ????????? ????????? ????????? ????????????.
//	        oauthToken = naverLoginBO.getAccessToken(session, code, state);
//
//	        apiResult = naverLoginBO.getUserProfile(oauthToken); // String????????? json?????????
//	        /**
//	         * apiResult json ?????? {"resultcode":"00", "message":"success",
//	         * "response":{"id":"33666449","nickname":"shinn****","age":"20-29","gender":"M","email":"sh@naver.com","name":"\uc2e0\ubc94\ud638"}}
//	         **/
//
//	        // 2. String????????? apiResult??? json????????? ??????
//	        JSONParser parser = new JSONParser();
//	        Object obj = parser.parse(apiResult);
//	        JSONObject jsonObj = (JSONObject) obj;
//
//
//	        // 3. ????????? ??????
//	        // Top?????? ?????? _response ??????
//	        JSONObject response_obj = (JSONObject)jsonObj.get("response");
//	        // response??? id??? ??????
//	        String id = (String)response_obj.get("id");
//
//	        //?????????????????? ?????????????????? ??????
//	        boolean result = service.idCheck(id);
//
//	        if(result){
//	            MemberDto dto = service.getMember(id);
//	            System.out.println("????????? = " + dto.toString());
//	            session.setMaxInactiveInterval(1800); // 1800 = 60s*30 (30???)
//	            session.setAttribute("login",dto);
//	            return "home.tiles";
//	        }
//
//	        //model.addAttribute("sns_type","naver");
//	        model.addAttribute("info", response_obj);
//	        return "snsregi.tiles";
//
//	    }
//		//????????????
//		
//		
//		
//		
//		@RequestMapping(value = "addMember.do", method = { RequestMethod.POST, RequestMethod.GET })
//	    public String addMember(HttpSession session, MemberDto dto) {
//
//	        if(dto.getSns_Type().equals("none")){
//	            BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
//	            String encPassword = encoder.encode(dto.getPwd());
//	            dto.setPwd(encPassword);
//	        }
//
//	        if(!dto.getSns_Type().equals("none")) {
//	            session.setAttribute("login", dto);
//	        }
//
//	        service.addmember(dto);
//
//	        return "redirect:/home.do";
//	    }
//		
//		
//		
		
		
		
		
}

