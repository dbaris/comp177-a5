/** @author: Fumeng Yang (fyang@cs.tufts.edu)
 * since 2010
 * adpated in 2011, 2012, 2013, 2014, 2015
 */

import java.sql.Statement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;


public class DBHandler {
    
    private static Connection connection = getConnection();
    private static Statement smt = null;
    private static int sqlID = 0;

    public static Connection getConnection() {
        String url = "jdbc:mysql://visualization.cwdj44qfoahu.us-east-2.rds.amazonaws.com";
        
        try {
            Class.forName("com.mysql.jdbc.Driver");
            String name = "admin";
            String password = "processingsucks";
            return (DriverManager.getConnection(url, name, password));
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        return null;
    }

// a local database for testing

    //     public static Connection getConnection() {
  
    //     String url = "jdbc:derby://localhost:1527/150VIS";
    //     try {
    //         Class.forName("org.apache.derby.jdbc.ClientDriver");
    //         String name = "root";
    //         String password = "123123";
    //         return (DriverManager.getConnection(url, name, password));
    //     } catch (SQLException e) {
    //         e.printStackTrace();
    //     } catch (ClassNotFoundException e) {
    //         e.printStackTrace();
    //     }
    //     return null;
    // }
    
    
    public static ResultSet exeQuery(String query) throws SQLException {
        //if(query.contains("*") && !query.contains("where")){
        //   System.out.println("Come back and check! Remco is not happy with this operation!");
        //   return null;
        //}

        // if(!query.contains("from") && !query.contains("FROM")){
        //   return null;
        //}

        if (connection == null) {
            connection = getConnection();
        }
        if (smt == null) {
            smt = connection.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
                                        ResultSet.CONCUR_READ_ONLY);
        }
        System.out.println(sqlID + ": " + query);
        sqlID++;
        return smt.executeQuery(query);
    }
    
    public static void exeUpdateQuery(String query) throws SQLException {
        if (smt == null) {
            smt = connection.createStatement();
        }
        System.out.println("SQL" + sqlID + ": " + query);
        sqlID++;
        smt.execute(query);
    }
    
    public static void closeConnection(){
      try{
          smt.close();
          connection.close();
      }catch(Exception e){
          System.out.println(e.toString());
      }    
    }
    
}// class ends