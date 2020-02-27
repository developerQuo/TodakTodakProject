//package java142.todak.common;
//
//import java142.todak.etc.service.EtcService;
//
//import javax.annotation.Resource;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//
//import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
//
//public class LoginSessionInterceptor extends HandlerInterceptorAdapter {
//	
//	@Resource(name = "EtcService")
//	private EtcService etcService;
//
//	@Override
//	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
//
//		MemberVO mVO = (MemberVO) etcService.login(hmvo);
//
//		if(loginVO != null){
//                        return true;
//                }
//                else {
//                        ModelAndView modelAndView = new ModelAndView("forward:/accessDenied.do");
//                        throw new ModelAndViewDefiningException(modelAndView);
//                }
//	}
//
//}
