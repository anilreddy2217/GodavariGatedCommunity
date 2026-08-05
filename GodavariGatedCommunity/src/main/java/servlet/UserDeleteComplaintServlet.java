package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Complaint;

import java.io.IOException;

import dao.ComplaintDAO;

@WebServlet("/userDeleteComplaint")
public class UserDeleteComplaintServlet extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("userId") == null) {
		    response.sendRedirect("index.jsp");
		    return;
		}
		
		int complaintId = Integer.parseInt(request.getParameter("complaintId"));
		ComplaintDAO dao = new ComplaintDAO();
		Complaint complaint = dao.getComplaintById(complaintId);
		
		// Only allow deletion if complaint belongs to user and is still Pending
		if(complaint != null && complaint.getUserId() == (Integer)session.getAttribute("userId") 
				&& complaint.getStatus().equals("Pending")) {
			dao.deleteComplaint(complaintId);
		}
		
		response.sendRedirect("viewServlet");
	}
}
