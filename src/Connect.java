import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class Connect {

    private Connection conn;

    public void loadProperties(){
        Properties props = new Properties();
        try(InputStream input = new FileInputStream("config.properties")) {
            props.load(input);
        } catch (IOException e) {
            e.printStackTrace();
        }

        String url = props.getProperty("db.url");
        String username = props.getProperty("db.user");
        String password = props.getProperty("db.password");

        if(!hasConnection(url, username, password)){
            System.out.println("Unable to establish connection.");
        }
    }

    public boolean hasConnection(String url, String username, String password) {
        try{
            conn = DriverManager.getConnection(url, username, password);
            System.out.println("Connection to DB successful!");
            return true;
        } catch (SQLException e){
            System.out.println("Connection failed.");
            throw new RuntimeException(e);
        }
    }

    public void closeConnection(){
        if(conn != null){
            try{
                conn.close();
                System.out.println("Connection closed.");
            } catch (SQLException e){
                throw new RuntimeException(e);
            }
        }
    }

    public Connection getConn() {
        return conn;
    }
}
