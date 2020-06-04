package ssc.util;

import java.io.*;
import java.util.Properties;

/**
 * @auchor 19381
 */
public class MyProperties extends Properties {

    public String filePath ;

    /**
     *
     */
    public MyProperties(String filePath){
        try {
            this.filePath = filePath;
            InputStream inputStream = new FileInputStream(filePath);
            BufferedInputStream bis = new BufferedInputStream(inputStream);
            this.load(bis);
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    /**
     *
     */
    public void storeMyProperty(String key, String value)  {
        try {
            OutputStream outputStream = new FileOutputStream(filePath);
            BufferedOutputStream bof = new BufferedOutputStream(outputStream);
            this.setProperty(key,value);
            this.store(bof, key);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    /**
     *
     */
    public String getMyProperty(String key) {
        String value = null;

            if (this.containsKey(key)) {
               value = this.getProperty(key);
            }else{
                System.out.println("from getMyproperty , the key: "+key+" is invalid");
            }
            return value;


    }


}
