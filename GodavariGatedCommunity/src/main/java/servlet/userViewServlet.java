package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Complaint;

import java.io.IOException;
import java.util.List;

import dao.ComplaintDAO;

/**
 * Servlet implementation class userViewServlet
 */
@WebServlet("/viewServlet")
public class userViewServlet extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("userId") == null) {
		    response.sendRedirect("index.jsp");
		    return;
		}
		ComplaintDAO dao = new ComplaintDAO();
	    Integer userIdObj = (Integer) session.getAttribute("userId");
	    if (userIdObj == null) {
	        response.sendRedirect("index.jsp"); // redirect to login if no session
	        return;
	    }
	    int userId = userIdObj;
	    List<Complaint> list = dao.getComplaints(userId,"Pending");
	    List<Complaint> list2 = dao.getComplaints(userId,"In Progress");
	    list.addAll(list2);
	    request.setAttribute("list", list);
	    request.getRequestDispatcher("viewComplaints.jsp").forward(request,response);
	}

}
