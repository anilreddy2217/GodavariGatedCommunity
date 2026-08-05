package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Resident;

import java.io.IOException;

import dao.ResidentDAO;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/login")
public class LoginServlet extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub


		String username = request.getParameter("username");
		String password = request.getParameter("password");
		ResidentDAO dao = new ResidentDAO();
		Resident resident = dao.isValid(username, password);
		if(resident != null) {
			HttpSession session = request.getSession(true);
		    session.setAttribute("username", username);
		    session.setAttribute("userId", resident.getId());
		    session.setAttribute("email", resident.getEmail());
		    session.setAttribute("fullName", resident.getFullname());
		    session.setAttribute("role", resident.getRole());
		    session.setAttribute("phone", resident.getPhone());

		    if (resident.getRole().equals("owner")) {
		        response.sendRedirect("ownerdashboard.jsp");
		    } else {
		        response.sendRedirect("userdashboard.jsp");
		    }
		}
		else {
			request.setAttribute("error", "Invalid username or password");
			request.getRequestDispatcher("index.jsp").forward(request,response);
		}
	}
}
