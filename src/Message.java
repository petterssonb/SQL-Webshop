import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

public class Message extends Connect{

    public void sendMessage(){
        Connection conn = getConn();
        if(conn != null){
            try(Statement stmt = conn.createStatement()){
                // call for admin menu
            }catch(SQLException e){
                throw new RuntimeException(e);
            }
        } else {
            System.out.println("No connection. Interrupted or not established.");
        }

    }
}
