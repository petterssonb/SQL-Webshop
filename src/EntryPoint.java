import java.sql.Connection;

public class EntryPoint {

    private Connection conn;
    private Message message;

    public EntryPoint() {
        Connect con = new Connect();
        con.loadProperties();
        conn = con.getConnection();
        message = new Message(conn);
    }

    // Return the result of query1 as a String
    public String query1() {
        return message.query1();
    }

    // Return the result of query2 as a String
    public String query2() {
        return message.query2();
    }

    // Return the result of query3 as a String
    public String query3() {
        return message.query3();
    }
}