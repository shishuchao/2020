package ssc;
/**
 * selenium
 * AUTHOR 13283
 * DATE 2020-05-31
 */

import java.io.BufferedReader;
import java.io.File;
import java.io.FileWriter;
import java.io.InputStreamReader;
import java.net.InetAddress;
import java.net.NetworkInterface;
import java.net.UnknownHostException;
import java.util.Enumeration;

/**
 * author 13283
 */
public class GetMac {
    public static void main(String[] args) {
        GetMac getMac = new GetMac();
        System.out.println(getMac.getMac());
        if(getMac.getMac().equals("00-50-56-C0-00-08")){
            System.out.println(true);
        }
        getMac.getHostName();
    }
    /**
     * @param drive 硬盘驱动器分区 如C,D
     * @return 该分区的卷标
     */
    public static String getHDSerial(String drive) {
        String result = "";
        try {
            File file = File.createTempFile("tmp", ".vbs");
            file.deleteOnExit();
            FileWriter fw = new java.io.FileWriter(file);
            String vbs = "Set objFSO = CreateObject(\"Scripting.FileSystemObject\")\n" + "Set colDrives = objFSO.Drives\n" + "Set objDrive = colDrives.item(\""
                    + drive + "\")\n" + "Wscript.Echo objDrive.SerialNumber";
            fw.write(vbs);
            fw.close();
            Process p = Runtime.getRuntime().exec("cscript //NoLogo " + file.getPath());
            BufferedReader input = new BufferedReader(new InputStreamReader(p.getInputStream()));
            String line;
            while ((line = input.readLine()) != null) {
                result += line;
            }
            input.close();
            file.delete();
        } catch (Exception e) {

        }
        if (result.trim().length() < 1 || result == null) {
            result = "无磁盘ID被读取";
        }
        return result.trim();
    }
    /**
     * 获取CPU号,多CPU时,只取第一个
     * @return
     */
    public static String getCPUSerial() {
        String result = "";
        try {
            File file = File.createTempFile("tmp", ".vbs");
            file.deleteOnExit();
            FileWriter fw = new java.io.FileWriter(file);
            String vbs = "On Error Resume Next \r\n\r\n" + "strComputer = \".\"  \r\n" + "Set objWMIService = GetObject(\"winmgmts:\" _ \r\n"
                    + "    & \"{impersonationLevel=impersonate}!\\\\\" & strComputer & \"\\root\\cimv2\") \r\n"
                    + "Set colItems = objWMIService.ExecQuery(\"Select * from Win32_Processor\")  \r\n " + "For Each objItem in colItems\r\n "
                    + "    Wscript.Echo objItem.ProcessorId  \r\n " + "    exit for  ' do the first cpu only! \r\n" + "Next                    ";

            fw.write(vbs);
            fw.close();
            Process p = Runtime.getRuntime().exec("cscript //NoLogo " + file.getPath());
            BufferedReader input = new BufferedReader(new InputStreamReader(p.getInputStream()));
            String line;
            while ((line = input.readLine()) != null) {
                result += line;
            }
            input.close();
            file.delete();
        } catch (Exception e) {
            e.fillInStackTrace();
        }
        if (result.trim().length() < 1 || result == null) {
            result = "无CPU_ID被读取";
        }
        return result.trim();
    }
    /***
     * 获取MAC地址
     * @return
     */
    public String getMac() {
        String macStr = null;
        try {
            InetAddress ip = InetAddress.getLocalHost();
            System.out.println(ip.toString());
            NetworkInterface network = NetworkInterface.getByInetAddress(ip);
            byte[] mac = network.getHardwareAddress();
            System.out.print("Current MAC address : ");
            StringBuilder sb = new StringBuilder();
            for (int i = 0; i < mac.length; i++) {
                sb.append(String.format("%02X%s", mac[i], (i < mac.length - 1) ? "-" : ""));
            }
            macStr = sb.toString();
            System.out.println(sb.toString());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return macStr;
    }

    /**
     *
     */
    private static String getLocalMac() {

        InetAddress ia = null;
        StringBuffer sb = new StringBuffer("");

        try {

            Enumeration<NetworkInterface> interfaces = NetworkInterface.getNetworkInterfaces();

            while (interfaces.hasMoreElements()) {
                NetworkInterface networkInterface = interfaces.nextElement();
                if (networkInterface != null) {

                    String name = networkInterface.getName();
                    System.out.println(name);
                    if(!name.equals("xxxxxxxxx")){
                        continue;
                    }

                    byte[] bytes = networkInterface.getHardwareAddress();
                    if (bytes != null) {
                        for (int i = 0; i < bytes.length; i++) {
                            if (i != 0) {
                                sb.append(":");
                            }
                            int tmp = bytes[i] & 0xff; // 字节转换为整数
                            String str = Integer.toHexString(tmp);
                            if (str.length() == 1) {
                                sb.append("0" + str);
                            } else {
                                sb.append(str);
                            }
                        }
                    }
                }
            }

            System.out.println("本机MAC地址:" + sb.toString().toLowerCase());


        } catch (Exception e) {
            e.printStackTrace();
        }
        return sb.toString().toLowerCase();

    }
    public void getHostName() {
        try {
            InetAddress addr = InetAddress.getLocalHost();
            System.out.println("IP地址：" + addr.getHostAddress() + "，主机名：" + addr.getHostName());
        } catch (UnknownHostException e) {
            e.printStackTrace();
        }
    }
}