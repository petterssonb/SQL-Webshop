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

    public String query1() {
        return message.query1();
    }

    public String query2() {
        return message.query2();
    }

    public String query3() {
        return message.query3();
    }

    public String query4() { return message.query4(); }

    public String query5() {
        return message.query5();
    }

    public String query6() {
        return message.query6();
    }
}