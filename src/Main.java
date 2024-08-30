import java.sql.Connection;

public class Main {

    public static void main(String[] args) {
        Connect con = new Connect();
        con.loadProperties();

        Connection conn = con.getConnection();
        Message msg = new Message(conn);
        msg.adminMenu();


    }
}

