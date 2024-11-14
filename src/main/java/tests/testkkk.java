package tests;

import java.sql.Connection;

public class testkkk {
	public static void main(String[] args) {
		Connection connection = Project.ConnectionProvider.getCon();
		System.out.println(connection);
	}
}
