import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.*;
import java.util.Properties;

public class Main {

    public static void main(String[] args) {

        Properties props = new Properties();
        try(InputStream input = new FileInputStream("config.properties")) {
            props.load(input);
        } catch (IOException e) {
            e.printStackTrace();
        }

        String url = props.getProperty("url");
        String username = props.getProperty("user");
        String password = props.getProperty("password");

        try(Connection conn = DriverManager.getConnection(url, username, password);
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(
                    "select distinct Customer.firstName as 'Customers' " +
                            "from Item " +
                            "left join OrderItem on Item.id = OrderItem.item_id " +
                            "inner join Orders on Orders.id = OrderItem.order_id " +
                            "right join Customer on Customer.id = Orders.customer_id " +
                            "where Item.color = 'Black' and Item.size = 'M' and Item.brand = 'H&M'"
            )

        ){
            while(rs.next()){
                String firstName = rs.getString("Customers");
                System.out.println(firstName);
            }

        } catch (SQLException e){
            throw new RuntimeException(e);
        }

    }
}
