package Project;

import java.sql.*;
import java.sql.DriverManager;
import com.mysql.cj.jdbc.Driver;

public class ConnectionProvider {
	public static Connection getCon() {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/project4", "root", "");
            return con;
        } catch (Exception ex) {
            System.out.println("Error: " + ex.getMessage());
            return null;
        }
    }
}

