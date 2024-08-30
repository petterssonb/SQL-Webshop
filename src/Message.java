import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Scanner;

public class Message{

    private Connection conn;
    Scanner sc = new Scanner(System.in);

    public Message(Connection conn){
        this.conn = conn;
    }

    public void sendMessage(String message, int userInput){
        if(conn != null){
            try(Statement stmt = conn.createStatement()){
                ResultSet rs = stmt.executeQuery(message);
                switch(userInput){
                    case 1:
                        printQuery1(rs);
                        break;
                    case 2:
                        printQuery2(rs);
                        break;
                    case 3:
                        printQuery3(rs);
                        break;
                }
            }catch(SQLException e){
                throw new RuntimeException(e);
            }
        } else {
            System.out.println("No connection. Interrupted or not established.");
        }
    }

    public void query1(){
        int userInput = 1;
        String msg = "select distinct Customer.firstName as 'Customers' " +
                "from Item " +
                "left join OrderItem on Item.id = OrderItem.item_id " +
                "inner join Orders on Orders.id = OrderItem.order_id " +
                "right join Customer on Customer.id = Orders.customer_id " +
                "where Item.color = 'Black' and Item.size = 'M' and Item.brand = 'H&M'";
        sendMessage(msg, userInput);
    }

    public void printQuery1(ResultSet rs) throws SQLException {
        while(rs.next()){
            String firstName = rs.getString("Customers");
            System.out.println(firstName);
        }
    }

    public void query2(){
        int userInput = 2;
        String msg = "select Category.name as 'Category', count(ItemCategory.id) as ItemCount from Category " +
                "left join ItemCategory on Category.id = ItemCategory.category_id " +
                "group by Category.name " +
                "order by ItemCount desc";
        sendMessage(msg, userInput);
    }

    public void printQuery2(ResultSet rs) throws SQLException {
        while(rs.next()){
            String category = rs.getString("Category");
            int itemCount = rs.getInt("ItemCount");
            System.out.println(category + " " + itemCount);
        }
    }

    public void query3(){
        int userInput = 3;
        String msg = "select Customer.firstName as 'First name', Customer.lastName as 'Last name', sum(OrderItem.quantity * Item.price) as OrderValue " +
                "from Customer inner join Orders on Customer.id = Orders.customer_id " +
                "inner join OrderItem on Orders.id = OrderItem.order_id " +
                "inner join Item on OrderItem.item_id = Item.id " +
                "group by Customer.id, Customer.firstName, Customer.lastName " +
                "order by OrderValue desc";
        sendMessage(msg, userInput);
    }

    public void printQuery3(ResultSet rs) throws SQLException {
        while(rs.next()){
            String firstName = rs.getString("First name");
            String lastName = rs.getString("Last name");
            double orderValue = rs.getDouble("OrderValue");
            System.out.println(firstName + " " + lastName + " " + orderValue);
        }
    }

    public void adminMenu(){

        while(true) {
            System.out.println("1. T-shirt customers, black, medium, H&M");
            System.out.println("2. Category with item count");
            System.out.println("3. Customer and their order value");
            int userInput = sc.nextInt();

            switch (userInput) {
                case 1:
                    query1();
                    break;
                case 2:
                    query2();
                    break;
                case 3:
                    query3();
                    break;
                default:
                    System.out.println("Invalid input.");
                    break;
            }
        }
    }
}
