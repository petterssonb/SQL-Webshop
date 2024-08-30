import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class Connect{

    private Connection conn;

    public void loadProperties(){
        Properties props = new Properties();
        try(InputStream input = new FileInputStream("config.properties")){
            if(input == null){
                System.out.println("Unable to find properties file.");
                return;
            }
            props.load(input);
            String url = props.getProperty("url");
            String username = props.getProperty("user");
            String password = props.getProperty("password");

            if(url == null || username == null || password == null){
                System.out.println("Unable to load properties.");
                return;
            }

            if(!hasConnection(url, username, password)){
                System.out.println("Unable to establish connection.");
            }

        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public boolean hasConnection(String url, String username, String password) {
        try{
            conn = DriverManager.getConnection(url, username, password);
            return true;
        } catch (SQLException e){
            System.out.println("Connection failed.");
            e.printStackTrace();
            return false;
        }
    }

    public Connection getConnection(){
        return conn;
    }
}
