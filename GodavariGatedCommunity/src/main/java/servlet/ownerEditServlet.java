package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import dao.ComplaintDAO;

/**
 * Servlet implementation class ownerEditServlet
 */
@WebServlet("/editServlet")
public class ownerEditServlet extends HttpServlet {
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("userId") == null) {
		    response.sendRedirect("index.jsp");
		    return;
		}
		String role = (String) session.getAttribute("role");
		if (role == null || !role.equals("owner")) {
		    response.sendRedirect("index.jsp");  // or unauthorized page
		    return;
		}


		int complaintId = Integer.parseInt(request.getParameter("complaintId"));
		String status = request.getParameter("status");
		ComplaintDAO dao = new ComplaintDAO();
		dao.updateStatus(complaintId, status);
		request.getRequestDispatcher("oViewServlet").forward(request,response);
	}

}
