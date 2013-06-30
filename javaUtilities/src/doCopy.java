package SPSolveUtils;
import java.io.*;
public class doCopy 
{
// Copies src file to dst file.
    // If the dst file does not exist, it is created
    public static void main(String args[]) throws IOException {

	    copyFile(args[0],args[1]);
    return;
    }

// Copies src file to dst file.
    // If the dst file does not exist, it is created
    public static void copyFile(String src, String dst) throws IOException {
	File srcFile = new File(src); 
	File dstFile = new File(dst); 
        InputStream in = new FileInputStream(srcFile);
        OutputStream out = new FileOutputStream(dstFile);
    
        // Transfer bytes from in to out
        byte[] buf = new byte[1024];
        int len;
        while ((len = in.read(buf)) > 0) {
            out.write(buf, 0, len);
        }
        in.close();
        out.close();
    }


}

