package ssc;

import io.netty.bootstrap.ServerBootstrap;
import io.netty.buffer.ByteBuf;
import io.netty.buffer.Unpooled;
import io.netty.channel.*;
import io.netty.channel.oio.OioEventLoopGroup;
import io.netty.channel.socket.oio.OioServerSocketChannel;
import org.testng.annotations.Test;
import org.testng.annotations.TestInstance;

import java.io.IOException;
import java.io.OutputStream;
import java.net.InetSocketAddress;
import java.net.ServerSocket;
import java.net.Socket;
import java.nio.ByteBuffer;
import java.nio.channels.SelectionKey;
import java.nio.channels.Selector;
import java.nio.channels.ServerSocketChannel;
import java.nio.channels.SocketChannel;
import java.nio.charset.Charset;
import java.nio.charset.StandardCharsets;
import java.sql.Driver;
import java.sql.DriverManager;
import java.util.Iterator;
import java.util.Set;

/**
 * seleniumImooc
 * AUTHOR 13283
 * DATE 2020-05-20
 */

public class Temp {
    /**
     * lambda表达式
     * 调用内部类 两种方法
     *     1、内部类创建为 static
     *     2、实例化 总类，通过 总类 实例化 内部类
     */
    public static void main(String[] args){
        Temp t = new Temp();
        Temp.Java8Tester tester = t.new Java8Tester();
        // 类型声明
        MathOperation addition = Integer::sum;
        //MathOperation addition = (int a, int b) -> a + b;
        // 不用类型声明
        MathOperation subtraction = (a, b) -> a - b;
        // 大括号中的返回语句
        MathOperation multiplication = (int a, int b) -> a * b;
        //MathOperation multiplication = (int a, int b) -> { return a * b; };

        // 没有大括号及返回语句
        MathOperation division = (int a, int b) -> a / b;

        System.out.println("10 + 5 = " + tester.operate(10, 5, addition));
        System.out.println("10 - 5 = " + tester.operate(10, 5, subtraction));
        System.out.println("10 x 5 = " + tester.operate(10, 5, multiplication));
        System.out.println("10 / 5 = " + tester.operate(10, 5, division));

        // 不用括号
        GreetingService greetService1 = message ->
                System.out.println("Hello " + message);
        // 用括号
        GreetingService greetService2 = (message) ->
                System.out.println("Hello " + message);

        greetService1.sayMessage("Runoob");
        greetService2.sayMessage("Google");
    }
public class Java8Tester{
    private int operate(int a, int b, MathOperation mathOperation){
        return mathOperation.operation(a, b);
    }
}

    interface MathOperation {
        int operation(int a, int b);
    }

    interface GreetingService {
        void sayMessage(String message);
    }

    /**
     * BIO  NIO  NETTY
     */
    public class PlainOioServer {

        public void serve(int port) throws IOException {
            final ServerSocket socket = new ServerSocket(port);     //1
            try {
                for (;;) {
                    final Socket clientSocket = socket.accept();    //2
                    System.out.println("Accepted connection from " + clientSocket);

                    //3
                    new Thread(() -> {
                        OutputStream out;
                        try {
                            out = clientSocket.getOutputStream();
                            out.write("Hi!\r\n".getBytes(StandardCharsets.UTF_8));                            //4
                            out.flush();
                            clientSocket.close();                //5

                        } catch (IOException e) {
                            e.printStackTrace();
                            try {
                                clientSocket.close();
                            } catch (IOException ex) {
                                // ignore on close
                            }
                        }
                    }).start();                                        //6

                    /*
                    new Thread(new Runnable() {                        //3
                        @Override
                        public void run() {
                            OutputStream out;
                            try {
                                out = clientSocket.getOutputStream();
                                out.write("Hi!\r\n".getBytes(Charset.forName("UTF-8")));                            //4
                                out.flush();
                                clientSocket.close();                //5

                            } catch (IOException e) {
                                e.printStackTrace();
                                try {
                                    clientSocket.close();
                                } catch (IOException ex) {
                                    // ignore on close
                                }
                            }
                        }
                    }).start();
                    */

                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    public class PlainNioServer {
        public void serve(int port) throws IOException {
            ServerSocketChannel serverChannel = ServerSocketChannel.open();
            serverChannel.configureBlocking(false);
            ServerSocket ss = serverChannel.socket();
            InetSocketAddress address = new InetSocketAddress(port);
            ss.bind(address);                                            //1
            Selector selector = Selector.open();                        //2
            serverChannel.register(selector, SelectionKey.OP_ACCEPT);    //3
            final ByteBuffer msg = ByteBuffer.wrap("Hi!\r\n".getBytes());
            for (;;) {
                try {
                    selector.select();                                    //4
                } catch (IOException ex) {
                    ex.printStackTrace();
                    // handle exception
                    break;
                }
                Set<SelectionKey> readyKeys = selector.selectedKeys();    //5
                Iterator<SelectionKey> iterator = readyKeys.iterator();
                while (iterator.hasNext()) {
                    SelectionKey key = iterator.next();
                    iterator.remove();
                    try {
                        if (key.isAcceptable()) {                //6
                            ServerSocketChannel server =
                                    (ServerSocketChannel)key.channel();
                            SocketChannel client = server.accept();
                            client.configureBlocking(false);
                            client.register(selector, SelectionKey.OP_WRITE |
                                    SelectionKey.OP_READ, msg.duplicate());    //7
                            System.out.println(
                                    "Accepted connection from " + client);
                        }
                        if (key.isWritable()) {                //8
                            SocketChannel client =
                                    (SocketChannel)key.channel();
                            ByteBuffer buffer =
                                    (ByteBuffer)key.attachment();
                            while (buffer.hasRemaining()) {
                                if (client.write(buffer) == 0) {        //9
                                    break;
                                }
                            }
                            client.close();                    //10
                        }
                    } catch (IOException ex) {
                        key.cancel();
                        try {
                            key.channel().close();
                        } catch (IOException cex) {
                            // 在关闭时忽略
                        }
                    }
                }
            }
        }
    }

//    public class NettyOioServer {
//
//        public void server(int port) throws Exception {
//            final ByteBuf buf = Unpooled.unreleasableBuffer(
//                    Unpooled.copiedBuffer("Hi!\r\n", Charset.forName("UTF-8")));
//            EventLoopGroup group = new OioEventLoopGroup();
//            try {
//                ServerBootstrap b = new ServerBootstrap();        //1
//
//                b.group(group)                                    //2
//                        .channel(OioServerSocketChannel.class)
//                        .localAddress(new InetSocketAddress(port))
//                        .childHandler(new ChannelInitializer<SocketChannel>() {//3
//                            @Override
//                            public void initChannel(SocketChannel ch)
//                                    throws Exception {
//                                ch.pipeline().addLast(new ChannelInboundHandlerAdapter() {            //4
//                                    @Override
//                                    public void channelActive(ChannelHandlerContext ctx) throws Exception {
//                                        ctx.writeAndFlush(buf.duplicate()).addListener(ChannelFutureListener.CLOSE);//5
//                                    }
//                                });
//                            }
//                        });
//                ChannelFuture f = b.bind().sync();  //6
//                f.channel().closeFuture().sync();
//            } finally {
//                group.shutdownGracefully().sync();        //7
//            }
//        }
//    }

    /**
     * springboot 校验注册格式  https://www.jianshu.com/p/b5b8613769db
     * @Data
     * public class User {
     *     @NotNull(message = "用户id不能为空")
     *     private Long id;
     *
     *     @NotNull(message = "用户账号不能为空")
     *     @Size(min = 6, max = 11, message = "账号长度必须是6-11个字符")
     *     private String account;
     *
     *     @NotNull(message = "用户密码不能为空")
     *     @Size(min = 6, max = 11, message = "密码长度必须是6-16个字符")
     *     private String password;
     *
     *     @NotNull(message = "用户邮箱不能为空")
     *     @Email(message = "邮箱格式不正确")
     *     private String email;
     * }
     */
    @Test
    public void testIframe(){
        System.setProperty("","");
        // 做一些修改，单独提交

    }

}