package dao;

import org.hibernate.Session;
import org.hibernate.Transaction;

import model.Resident;
import util.HibernateUtil;

public class ResidentDAO {
	public Resident isValid(String username, String password) {

	    // Validate login credentials before querying the database
	    if (username == null || username.trim().isEmpty() ||
	        password == null || password.trim().isEmpty()) {
	        return null;
	    }

	    try(Session session = HibernateUtil.getConnection().openSession()){
			Resident resident = session.createQuery("From Resident Where username=:username And password=:password", Resident.class)
					.setParameter("username", username)
					.setParameter("password", password)
					.uniqueResult();
			if(resident!=null) {
				return resident;
			}
			else {
				return null;
			}
		}
	    catch(Exception e) {
	        System.err.println("Error while validating resident login.");
	        e.printStackTrace();
	        return null;
	    }
	}
	public void saveResident(Resident resident) {
		Transaction ts = null;
		try(Session session = HibernateUtil.getConnection().openSession()){
			ts = session.beginTransaction();
			session.save(resident);
			ts.commit();
		}
		catch(Exception e) {
		    if(ts != null && ts.isActive()) {
		        ts.rollback();
		    }

		    System.err.println("Error while saving resident information.");
		    e.printStackTrace();
		}
	}
	public Resident getResident(String email) {

	    // Validate email before performing database lookup
	    if (email == null || email.trim().isEmpty()) {
	        return null;
	    }

	    try(Session session = HibernateUtil.getConnection().openSession()){
			Resident resident = session.createQuery("From Resident Where email=:email", Resident.class)
			.setParameter("email", email).uniqueResult();
			return resident;
		}
		catch(Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	public java.util.List<Resident> getAllResidents() {
		try(Session session = HibernateUtil.getConnection().openSession()){
			return session.createQuery("From Resident", Resident.class).list();
		}
		catch(Exception e) {
			e.printStackTrace();
			return new java.util.ArrayList<>();
		}
	}
	
	public Resident getResidentById(int id) {
		try(Session session = HibernateUtil.getConnection().openSession()){
			return session.get(Resident.class, id);
		}
		catch(Exception e) {
			e.printStackTrace();
			return null;
		}
	}
}
