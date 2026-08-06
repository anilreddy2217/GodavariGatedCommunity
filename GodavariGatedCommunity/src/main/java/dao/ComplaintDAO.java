package dao;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;

import model.Complaint;
import util.HibernateUtil;

/**
 * Handles database operations related to complaints,
 * including create, update, delete, and retrieval.
 */

public class ComplaintDAO {
	public void saveComplaint(Complaint complaint) {
	    Transaction ts = null;
	    Session session = null;
	    try {
	        session = HibernateUtil.getConnection().openSession();
	        ts = session.beginTransaction();
	        session.save(complaint);
	        ts.commit();
	    } catch (Exception e) {
	        if (ts != null && ts.isActive()) {  // safer check
	            try {
	                ts.rollback();
	            } catch (Exception rollbackEx) {
	                rollbackEx.printStackTrace();
	            }
	        }
	        e.printStackTrace();
	    } finally {
	        if (session != null && session.isOpen()) {
	            session.close();
	        }
	    }
	}
	public List<Complaint> getComplaints(int userId, String status){
	    try(Session session = HibernateUtil.getConnection().openSession()){
	        List<Complaint> list = session.createQuery("From Complaint Where userId=:userId And status=:status", Complaint.class)
	            .setParameter("userId", userId)
	            .setParameter("status", status)
	            .list();
	        return list;
	    } catch(Exception e) {
	        e.printStackTrace();
	        return new ArrayList<>();  // return empty list instead of null
	    }
	}

	public List<Complaint> getComplaintAllUsers(){
	    try(Session session = HibernateUtil.getConnection().openSession()){
	        List<Complaint> list = session.createQuery("From Complaint", Complaint.class).list();
	        System.out.println("DAO: Number of complaints fetched = " + list.size());
	        return list;
	    } catch(Exception e) {
	        e.printStackTrace();
	        return new ArrayList<>();
	    }
	}


	public void updateStatus(int complaintId, String status) {
		Transaction ts = null;
		try(Session session = HibernateUtil.getConnection().openSession()){
			ts = session.beginTransaction();
			Complaint complaint = session.get(Complaint.class, complaintId);
	        if (complaint != null) {
	            complaint.setStatus(status); // Update status
	            session.update(complaint); // Save changes
	        }
			ts.commit();
		}
		catch (Exception e) {
	        if (ts != null) {
	            ts.rollback();
	        }
	        e.printStackTrace();
	    }
	}
	
	public Complaint getComplaintById(int complaintId) {
	    try(Session session = HibernateUtil.getConnection().openSession()){
	        return session.get(Complaint.class, complaintId);
	    } catch(Exception e) {
	        e.printStackTrace();
	        return null;
	    }
	}
	
	public void updateComplaint(Complaint complaint) {
	    Transaction ts = null;
	    try(Session session = HibernateUtil.getConnection().openSession()){
	        ts = session.beginTransaction();
	        session.update(complaint);
	        ts.commit();
	    } catch (Exception e) {
	        if (ts != null) {
	            ts.rollback();
	        }
	        e.printStackTrace();
	    }
	}
	
	public void deleteComplaint(int complaintId) {
	    Transaction ts = null;
	    try(Session session = HibernateUtil.getConnection().openSession()){
	        ts = session.beginTransaction();
	        Complaint complaint = session.get(Complaint.class, complaintId);
	        if (complaint != null) {
	            session.delete(complaint);
	        }
	        ts.commit();
	    } catch (Exception e) {
	        if (ts != null) {
	            ts.rollback();
	        }
	        e.printStackTrace();
	    }
	}
	
	public List<Complaint> getAllComplaints(String status) {
	    try(Session session = HibernateUtil.getConnection().openSession()){
	        if(status == null || status.isEmpty()) {
	            return session.createQuery("From Complaint", Complaint.class).list();
	        }
	        return session.createQuery("From Complaint Where status=:status", Complaint.class)
	            .setParameter("status", status)
	            .list();
	    } catch(Exception e) {
	        e.printStackTrace();
	        return new ArrayList<>();
	    }
	}
}
