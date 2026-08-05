package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Resident;

import java.io.IOException;
import java.util.List;

import dao.ResidentDAO;

@WebServlet("/adminViewResidents")
public class AdminViewResidentsServlet extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
		
		ResidentDAO dao = new ResidentDAO();
		List<Resident> residents = dao.getAllResidents();
		request.setAttribute("residents", residents);
		request.getRequestDispatcher("adminViewResidents.jsp").forward(request, response);
	}
}
