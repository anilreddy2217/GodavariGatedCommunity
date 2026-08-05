package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Resident;

import java.io.IOException;

import dao.ResidentDAO;

@WebServlet("/adminSignup")
public class AdminSignupServlet extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String email = request.getParameter("email");
		String fullName = request.getParameter("fullname");
		String phone = request.getParameter("phone");
		String secretKey = request.getParameter("secretKey");
		
		// Simple secret key validation for admin registration
		if(!"GODAVARI2025".equals(secretKey)) {
			request.setAttribute("error", "Invalid secret key for admin registration");
			request.getRequestDispatcher("adminSignup.jsp").forward(request, response);
			return;
		}
		
		ResidentDAO dao = new ResidentDAO();
		
		// Check if email already exists
		if(dao.getResident(email) != null) {
			request.setAttribute("error", "Email already registered");
			request.getRequestDispatcher("adminSignup.jsp").forward(request, response);
			return;
		}
		
		Resident resident = new Resident();
		resident.setUsername(username);
		resident.setPassword(password);
		resident.setEmail(email);
		resident.setFullname(fullName);
		resident.setRole("owner"); // Admin role
		resident.setPhone(phone);
		dao.saveResident(resident);
		
		request.setAttribute("success", "Admin registration successful! Please login.");
		request.getRequestDispatcher("index.jsp").forward(request, response);
	}
}
