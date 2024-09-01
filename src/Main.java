import py4j.GatewayServer;

public class Main {

    public static void main(String[] args) {
        EntryPoint entry = new EntryPoint();
        GatewayServer server = new GatewayServer(entry);
        server.start();
        System.out.println("Gateway Server Started");
    }
}

