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
 * Servlet implementation class SignupServlet
 */
@WebServlet("/signup")
public class SignupServlet extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String email = request.getParameter("email");
		String fullName = request.getParameter("fullname");
		String phone = request.getParameter("phone");
		
		ResidentDAO dao = new ResidentDAO();
		
		// Check if email already exists
		if(dao.getResident(email) != null) {
			request.setAttribute("error", "Email already registered");
			request.getRequestDispatcher("signup.jsp").forward(request, response);
			return;
		}
		
		Resident resident = new Resident();
		resident.setUsername(username);
		resident.setPassword(password);
		resident.setEmail(email);
		resident.setFullname(fullName);
		resident.setRole("user");
		resident.setPhone(phone);
		dao.saveResident(resident);
		request.setAttribute("success", "Registration successful! Please login.");
		request.getRequestDispatcher("index.jsp").forward(request, response);
	}

}
