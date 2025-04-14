package util;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.UUID;
import jakarta.servlet.http.Part;

/**
 * Utility class for file storage operations.
 * Handles storing and retrieving files from local storage or CDN.
 */
public class FileStorageUtil {
    private static final String CDN_BASE_URL = "https://cdn.lawlink.com/";
    private static final String LOCAL_STORAGE_PATH = "uploads/";
    private static final boolean USE_CDN = false; // Set to true to use CDN, false for local storage

    /**
     * Gets the URL for a file, either from CDN or local storage.
     *
     * @param path The relative path of the file
     * @return The full URL to the file
     */
    public static String getCdnUrl(String path) {
        if (path == null || path.isEmpty()) {
            return "";
        }

        if (USE_CDN) {
            return CDN_BASE_URL + path;
        } else {
            // For local storage, return the application-relative path
            return path;
        }
    }

    /**
     * Stores a file from an uploaded Part.
     *
     * @param part The uploaded file part
     * @param subDirectory The subdirectory to store the file in (e.g., "profiles")
     * @return The relative path to the stored file
     * @throws IOException If an I/O error occurs
     */
    public static String storeFile(Part part, String subDirectory) throws IOException {
        String fileName = getSubmittedFileName(part);
        String fileExtension = "";

        if (fileName != null && !fileName.isEmpty()) {
            int lastDot = fileName.lastIndexOf('.');
            if (lastDot > 0) {
                fileExtension = fileName.substring(lastDot);
            }
        }

        // Generate a unique file name
        String uniqueFileName = UUID.randomUUID().toString() + fileExtension;
        String relativePath = LOCAL_STORAGE_PATH + subDirectory + "/" + uniqueFileName;
        String absolutePath = getAbsolutePath(relativePath);

        // Ensure directory exists
        File directory = new File(absolutePath).getParentFile();
        if (!directory.exists()) {
            directory.mkdirs();
        }

        // Write the file
        try (InputStream input = part.getInputStream();
             FileOutputStream output = new FileOutputStream(absolutePath)) {

            byte[] buffer = new byte[1024];
            int length;
            while ((length = input.read(buffer)) > 0) {
                output.write(buffer, 0, length);
            }
        }

        return relativePath;
    }

    /**
     * Gets the absolute path for a relative path.
     *
     * @param relativePath The relative path
     * @return The absolute path
     */
    public static String getAbsolutePath(String relativePath) {
        // This would typically use ServletContext.getRealPath() in a servlet
        // For simplicity, we're using a hardcoded approach here
        String basePath = System.getProperty("catalina.base") + "/webapps/LawLink/";
        return basePath + relativePath;
    }

    /**
     * Gets the submitted file name from a Part.
     *
     * @param part The uploaded file part
     * @return The original file name
     */
    private static String getSubmittedFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] items = contentDisp.split(";");

        for (String item : items) {
            if (item.trim().startsWith("filename")) {
                return item.substring(item.indexOf('=') + 2, item.length() - 1);
            }
        }

        return null;
    }

    /**
     * Checks if a file exists.
     *
     * @param relativePath The relative path to the file
     * @return true if the file exists, false otherwise
     */
    public static boolean fileExists(String relativePath) {
        if (USE_CDN) {
            // For CDN, we assume the file exists
            return true;
        } else {
            String absolutePath = getAbsolutePath(relativePath);
            return Files.exists(Paths.get(absolutePath));
        }
    }

    /**
     * Gets the default profile image path for a user type.
     *
     * @param userType The type of user (admin, lawyer, client)
     * @return The path to the default profile image
     */
    public static String getDefaultProfileImage(String userType) {
        switch (userType.toLowerCase()) {
            case "admin":
                return "assets/images/default-admin.png";
            case "lawyer":
                return "assets/images/default-lawyer.png";
            case "client":
                return "assets/images/default-client.png";
            default:
                return "assets/images/default-avatar.jpg";
        }
    }
}
