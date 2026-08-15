package util;

import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

import model.Complaint;
import model.Resident;

/**
 * Utility class responsible for creating and providing
 * the Hibernate SessionFactory used by the application.
 */
public class HibernateUtil {
	static SessionFactory sessionFactory = null;
	/**
	 * Provides the shared Hibernate SessionFactory instance
	 * used to create database sessions.
	 *
	 * @return the configured Hibernate SessionFactory
	 */
	public static SessionFactory getConnection() {
		if(sessionFactory==null) {
			Configuration cfg = new Configuration();
			cfg.configure("hibernate.cfg.xml");
			cfg.addAnnotatedClass(Resident.class);
			cfg.addAnnotatedClass(Complaint.class);

			sessionFactory = cfg.buildSessionFactory();
		}
		return sessionFactory;
	}
}

