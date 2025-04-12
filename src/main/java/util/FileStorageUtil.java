package util;

public class FileStorageUtil {
    private static final String CDN_BASE_URL = "https://cdn.lawlink.com/";

    public static String getCdnUrl(String path) {
        return CDN_BASE_URL + path;
    }
}
