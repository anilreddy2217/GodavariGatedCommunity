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
 * Servlet implementation class ownerViewServlet
 */
@WebServlet("/oViewServlet")
public class ownerViewServlet extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		System.out.println("ownerViewServlet.doPost() called");
		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("userId") == null) {
		    response.sendRedirect("index.jsp");
		    return;
		}
		String role = (String) session.getAttribute("role");
		if (role == null || !role.equals("owner")) {
		    response.sendRedirect("index.jsp");
		    return;
		}

		ComplaintDAO dao = new ComplaintDAO();
	    List<Complaint> list = dao.getComplaintAllUsers();
	    request.setAttribute("list", list);
	    request.getRequestDispatcher("ownerViewComplaints.jsp").forward(request, response);
	}

}
