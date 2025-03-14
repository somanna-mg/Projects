package com.tap.util;

import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class DBConnectionManager {
    private static String url;
    private static String user;
    private static String password;
    private static String driver;

    static {
        try {
        	
        	System.out.println("Loading start");
        	
            // Load database properties from file
            Properties properties = new Properties();
            FileInputStream input = new FileInputStream("/Users/somanna/web-dev-projects/TastyThreads/src/main/resources/db.properties");
            properties.load(input);
            
            // Get property values
            url = properties.getProperty("db.url");
            user = properties.getProperty("db.username");
            password = properties.getProperty("db.password");
            driver = properties.getProperty("db.driver");
            
            System.out.println(url);
            System.out.println(user);
            System.out.println(password);
            System.out.println(driver);

            // Load MySQL JDBC Driver
            Class.forName(driver);
            System.out.println("DB loaded...");

        } catch (IOException | ClassNotFoundException e) {
            e.printStackTrace();
            throw new RuntimeException("Failed to load database configuration", e);
        }
    }

    // Method to get database connection
    public static Connection getConnection() throws SQLException {
    	System.out.println("start");
        return DriverManager.getConnection(url, user, password);
    }
}
