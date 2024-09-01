import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class Message {

    private Connection conn;

    public Message(Connection conn) {
        this.conn = conn;
    }

    public String executeQuery(String sql, int queryType) {
        StringBuilder result = new StringBuilder();
        if (conn != null) {
            try (Statement stmt = conn.createStatement()) {
                ResultSet rs = stmt.executeQuery(sql);
                switch (queryType) {
                    case 1:
                        result.append(formatQuery1(rs));
                        break;
                    case 2:
                        result.append(formatQuery2(rs));
                        break;
                    case 3:
                        result.append(formatQuery3(rs));
                        break;
                }
            } catch (SQLException e) {
                e.printStackTrace();
                return "Error: " + e.getMessage();
            }
        } else {
            return "No connection. Interrupted or not established.";
        }
        return result.toString();
    }

    public String query1() {
        String sql = "select distinct Customer.firstName as 'Customers' " +
                "from Item " +
                "left join OrderItem on Item.id = OrderItem.item_id " +
                "inner join Orders on Orders.id = OrderItem.order_id " +
                "right join Customer on Customer.id = Orders.customer_id " +
                "where Item.color = 'Black' and Item.size = 'M' and Item.brand = 'H&M'";
        return executeQuery(sql, 1);
    }

    public String query2() {
        String sql = "select Category.name as 'Category', count(ItemCategory.id) as ItemCount from Category " +
                "left join ItemCategory on Category.id = ItemCategory.category_id " +
                "group by Category.name " +
                "order by ItemCount desc";
        return executeQuery(sql, 2);
    }

    public String query3() {
        String sql = "select Customer.firstName as 'First name', Customer.lastName as 'Last name', " +
                "sum(OrderItem.quantity * Item.price) as OrderValue " +
                "from Customer inner join Orders on Customer.id = Orders.customer_id " +
                "inner join OrderItem on Orders.id = OrderItem.order_id " +
                "inner join Item on OrderItem.item_id = Item.id " +
                "group by Customer.id, Customer.firstName, Customer.lastName " +
                "order by OrderValue desc";
        return executeQuery(sql, 3);
    }

    private String formatQuery1(ResultSet rs) throws SQLException {
        StringBuilder result = new StringBuilder();
        while (rs.next()) {
            String firstName = rs.getString("Customers");
            result.append(firstName).append("\n");
        }
        return result.toString();
    }

    private String formatQuery2(ResultSet rs) throws SQLException {
        StringBuilder result = new StringBuilder();
        while (rs.next()) {
            String category = rs.getString("Category");
            int itemCount = rs.getInt("ItemCount");
            result.append(category).append(": ").append(itemCount).append("\n");
        }
        return result.toString();
    }

    private String formatQuery3(ResultSet rs) throws SQLException {
        StringBuilder result = new StringBuilder();
        while (rs.next()) {
            String firstName = rs.getString("First name");
            String lastName = rs.getString("Last name");
            double orderValue = rs.getDouble("OrderValue");
            result.append(firstName).append(" ").append(lastName).append(": ").append(orderValue).append("\n");
        }
        return result.toString();
    }
}