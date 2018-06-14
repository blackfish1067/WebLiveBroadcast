package servlets;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.LoginFile;
import dao.UserDao;
import models.User;


/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * Default constructor. 
     */
    public LoginServlet() {
    	super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		
		//Get the user name and password
		String userID = request.getParameter("username1");
		
		String password = request.getParameter("password1");
		System.out.println(userID);
		System.out.println(password);
		//UserDao u = new UserDao();
		//User user = u.login(userID,password);
		ServletContext sc = getServletContext();
		
		/*if(user != null){
			HttpSession session = null;
			session = request.getSession();
			session.setAttribute("userId", userID);
			RequestDispatcher rd = sc.getRequestDispatcher("/live.html");
			rd.forward(request, response);
		}else{
			RequestDispatcher rd = sc.getRequestDispatcher("/live.html");
			rd.forward(request, response);
			}*/
		if (LoginFile.isLogin(userID, password)) {//验证成功
			request.setAttribute("username", userID);
			request.setAttribute("password", password);
			RequestDispatcher rd;
			if((userID.equals("anchor1")||userID.equals("anchor2")||userID.equals("anchor3")||userID.equals("anchor4")||userID.equals("anchor5"))){//如果是主播
				if(password.equals("12345")){
				    
				    rd = sc.getRequestDispatcher("/anchorClient.jsp");
				}else{
					rd = sc.getRequestDispatcher("/index.jsp");
				}
			}else{
				rd = sc.getRequestDispatcher("/userClient.jsp");
				System.out.println("dsaefsf");
			}
			rd.forward(request, response);
		}else{//验证失败
			RequestDispatcher rd = sc.getRequestDispatcher("/index.jsp");
			rd.forward(request, response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
