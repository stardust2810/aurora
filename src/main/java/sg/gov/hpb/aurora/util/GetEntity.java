package sg.gov.hpb.aurora.util;

import com.api.util.ApiSecurity.ApiSigning;
import com.api.util.ApiSecurity.ApiUtilException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;


public class GetEntity {
    private static final Logger log = LoggerFactory.getLogger(GetEntity.class);

    private static String realm = "\"http://apex_l2_eg\"";

    public static String RSAString() {
        return "Test RSA";
    }

    public static String get_nonce() {
        //Random rand = SecureRandom.getInstance("SHA1PRNG");
        try {
            long nonce = SecureRandom.getInstance("SHA1PRNG").nextLong();
            return Long.toString(nonce);
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }

        return null;
    }

    public static String get_timestamp() {
        long timestamp = System.currentTimeMillis();
        return Long.toString(timestamp);
    }

    public static String getSignatureToken(String endpt, String param) {
        String thePath = "https://edh.e.api.gov.sg/test/l2-eg/v1/"+endpt+param;
        log.debug("[GetEntity]"+thePath);

        try {
            //return ApiSigning.getSignatureToken("http://apex_l2_eg","apex_l2_eg", "GET", "https://edh.e.api.gov.sg/test/l2-eg/v1/entities?issuance_agencies=MOM","edh-5iLlRCGWvZ94ysTfulcy4H1W", "fc09eb269e6655dafc6414645a10884afdccf0ee", null, "Auror@2810", "7092c01186b34d4fa1489e546c4e2cfc", getLocalPath("aurora.store"), GetEntity.get_nonce(), GetEntity.get_timestamp());
            return ApiSigning.getSignatureToken("http://apex_l2_eg","apex_l2_eg", "GET", thePath,"edh-5iLlRCGWvZ94ysTfulcy4H1W", "fc09eb269e6655dafc6414645a10884afdccf0ee", null, "Auror@2810", "7092c01186b34d4fa1489e546c4e2cfc", getLocalPath("aurora.store"), GetEntity.get_nonce(), GetEntity.get_timestamp());
        } catch (ApiUtilException e) {
            e.printStackTrace();
        }
        return null;
    }

    private static String getLocalPath(String relativeFileName)
    {
        Path currentRelativePath = Paths.get("");
        //String s = combine(currentRelativePath.toAbsolutePath().toString(), relativeFileName.replaceAll("/", File.separator));
        //log.info("[PATH]=========" + currentRelativePath.toAbsolutePath().toString());
        String s = currentRelativePath.toAbsolutePath().toString()+"\\" + relativeFileName;
        //log.info("[PATH]=========" + s);
        //System.out.println("[PATH]=========" + s);
        return s;
    }

    public static String combine(String... paths)
    {
        File file = new File(File.separator);

        for (int i = 0; i < paths.length ; i++) {
            file = new File(file, paths[i]);
        }

        return file.getPath();
    }
}
