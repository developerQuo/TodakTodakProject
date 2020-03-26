package java142.todak.etc.utils;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionBindingListener;
import javax.servlet.http.HttpSessionBindingEvent;

import java.util.ArrayList;
import java.util.Hashtable;
import java.util.Enumeration;
import java.util.List;

public class LoginSession implements HttpSessionBindingListener{
	
	private static LoginSession sManager = null;
	
	// 사용자 id를 저장해 둘 Hashtable
	private static Hashtable hashManager = new Hashtable();
	
	
	
	// 생성자
	private LoginSession(){
		super();
	}
	
	/**
	*
	*	싱글톤 기법 
	*
	*/
	public static synchronized LoginSession getInstance(){
		
		if(sManager == null){
			sManager = new LoginSession();
		}
		
		return sManager;
	}
	
	// 해당 세션에서 이미 로그인을 했는지 확인 
	// 세션아이디를 받아서 해당 세션이 로그인 상태이면 true를, 아니면 false를 리턴.
	public boolean isLogin(String sessionID){
		
		boolean isLogin = false; 
		
		Enumeration e = hashManager.keys();
		String key = "";
		
		while(e.hasMoreElements()){
			
			key = (String)e.nextElement();
			
			if (sessionID.equals(key)){
				isLogin = true;
			}
		}
		
		return isLogin;
	}
	
	// 해당 아이디의 동시 사용을 막기위해 
	// 이미 사용중인 아이디인지 확인
	// 유저아이디를 받아서 해당 유저가 세션을 사용 중이면 true, 아니면 false를 리턴.
	public boolean isUsing(String userNum)
	{
		boolean isFlag = false;
		
		Enumeration e = hashManager.keys();
		String key = "";
		
		while(e.hasMoreElements()){
			
			key = (String)e.nextElement();
			
			if (userNum.equals(hashManager.get(key))){
				isFlag = true;
			}
		}
		
		return isFlag;
	}
	
	// Hashtable에 세션아이디를 유저아이디를 짝지어 넣기.
	//   ==> 세션아이디로 유저아이디를 찾을 수 있게함.
	// Hashtable을 세션에 넣기
	//   ==> 세션을 통해 Hashtable에 접근할 수 있게함.
	public void setSession(HttpSession hSession, String userNum)
	{
//		//System.out.println("hSession.getId() >>> " + hSession.getId());
		System.out.println(" set session userNum >>> " + userNum);
		//System.out.println("this.getInstance() >>> " + this.getInstance());
		List<String> container = new ArrayList<String>();
		container.add(0, "");
		container.add(1, "");
		//System.out.println(" size >>> " + container.size());
		container.set(0, userNum);
		hashManager.put(hSession.getId(), container);
		hSession.setAttribute("login", this.getInstance());
	}
	
	// 세션이 성립되었을 때 자동으로 호출되는 메소드
	public void valueBound(HttpSessionBindingEvent event)
	{
		// nothing
	}
	
	// 세션이 끊겼을 때 자동으로 호출되는 메소드
	// 세션이 끊겼으면 Hashtable에서 해당 세션의 정보를 삭제한다.
	public void valueUnbound(HttpSessionBindingEvent event)
	{
		hashManager.remove(event.getSession().getId());
	}
	
	// 세션 ID로 현재 로그인한 ID를 구분해 냄
	public String getUserID(String sessionID)
	{
		List<String> container = (List<String>)hashManager.get(sessionID);
		return container.get(0);
	}
	
	// 현재 접속자 수
	public int getUserCount()
	{
		return hashManager.size();
	}

	// set main menu
	public void setMain(String main, String sessionID)
	{
		List<String> container = (List<String>)hashManager.get(sessionID);
		container.set(1, main);

//		List<String> container2 = (List<String>)hashManager.get(sessionID);
//		//System.out.println(" main IN setMain >>> " + container2.get(1));
	}

	// get main menu
	public String getMain(String sessionID)
	{
		List<String> container = (List<String>)hashManager.get(sessionID);
		return container.get(1);
	}
}