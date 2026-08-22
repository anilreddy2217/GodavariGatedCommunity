package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Complaint;
import model.Resident;

import java.io.IOException;
import java.sql.Timestamp;
import java.time.LocalDateTime;

import dao.ComplaintDAO;
import dao.ResidentDAO;

/**
 * Servlet implementation class SubmitComplaintServlet
 */
@WebServlet("/submitComplaintServlet")
public class SubmitComplaintServlet extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException {

		// Verify user session
		HttpSession session = request.getSession(false);

		if (session == null || session.getAttribute("userId") == null) {
		    response.sendRedirect("index.jsp");
		    return;
		}

		if (session.getAttribute("email") == null) {
		    response.sendRedirect("index.jsp");
		    return;
		}

	    String fullName = request.getParameter("fullName");
	    String email = request.getParameter("email");
	    String phone = request.getParameter("phone");
	 // Read complaint details from request
	    String category = request.getParameter("category");
	    String subject = request.getParameter("subject");
	    String description = request.getParameter("description");

	    // Remove unnecessary spaces from user input
	    if (category != null) {
	        category = category.trim();
	    }

	    if (subject != null) {
	        subject = subject.trim();
	    }

	    if (description != null) {
	        description = description.trim();
	    }

	    // Validate required complaint fields
	    if (category == null || category.trim().isEmpty() ||
	        subject == null || subject.trim().isEmpty() ||
	        description == null || description.trim().isEmpty()) {

	        request.setAttribute("errorMessage",
	                "Please fill in all complaint details.");

	        request.getRequestDispatcher("submitComplaint.jsp")
	               .forward(request, response);
	        return;
	    }

	    System.out.println("===== Submit Complaint =====");
	    System.out.println("Full Name: " + fullName);
	    System.out.println("Email: " + email);
	    System.out.println("Phone: " + phone);
	    System.out.println("Category: " + category);
	    System.out.println("Subject: " + subject);
	    System.out.println("Description: " + description);
	    System.out.println("Session UserId: " + session.getAttribute("userId"));

	    ResidentDAO dao = new ResidentDAO();
	 // Retrieve resident information
	    Resident resident = dao.getResident(email);

	    System.out.println("Resident Object: " + resident);

	    if (resident != null) {

	        System.out.println("Resident ID: " + resident.getId());

	        Complaint complaint = new Complaint();
	        complaint.setUserId(resident.getId());
	        complaint.setCategory(category);
	        complaint.setSubject(subject);
	        complaint.setDescription(description);
	        complaint.setCreatedAt(Timestamp.valueOf(LocalDateTime.now()));

	     // Save complaint to database
	        ComplaintDAO cdao = new ComplaintDAO();
	        cdao.saveComplaint(complaint);

	        System.out.println("Complaint saved successfully.");

	        request.getRequestDispatcher("userdashboard.jsp").forward(request, response);

	    } else {

	        System.out.println("Resident not found.");

	        request.getRequestDispatcher("submitComplaint.jsp").forward(request, response);
	    }
	}

}
