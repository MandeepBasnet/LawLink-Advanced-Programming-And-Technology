package util;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.UUID;

import jakarta.servlet.http.Part;

/**
 * Utility class for handling file storage operations
 */
public class FileStorageUtil {

    private static final String UPLOAD_DIR = "uploads";
    private static final String PROFILE_DIR = "profiles";

    /**
     * Save a profile image to the file system
     * @param part The uploaded file part
     * @param userId The ID of the user
     * @return The relative path to the saved file
     * @throws IOException If an I/O error occurs
     */
    public static String saveProfileImage(Part part, int userId) throws IOException {
        // Get the base directory for file uploads
        String baseDir = getBaseUploadDirectory();

        // Create the profile directory if it doesn't exist
        String profileDir = baseDir + File.separator + PROFILE_DIR;
        createDirectoryIfNotExists(profileDir);

        // Generate a unique filename
        String fileName = userId + "_" + UUID.randomUUID().toString() + getFileExtension(part);

        // Save the file
        Path filePath = Paths.get(profileDir + File.separator + fileName);
        Files.copy(part.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);

        // Return the relative path
        return UPLOAD_DIR + "/" + PROFILE_DIR + "/" + fileName;
    }

    /**
     * Delete a profile image from the file system
     * @param relativePath The relative path to the file
     * @return true if the file was deleted, false otherwise
     */
    public static boolean deleteProfileImage(String relativePath) {
        if (relativePath == null || relativePath.isEmpty()) {
            return false;
        }

        // Get the base directory for file uploads
        String baseDir = getBaseUploadDirectory();

        // Get the absolute path to the file
        Path filePath = Paths.get(baseDir + File.separator + relativePath.replace("/", File.separator));

        try {
            return Files.deleteIfExists(filePath);
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Get the base upload directory
     * @return The base upload directory
     */
    private static String getBaseUploadDirectory() {
        // Get the catalina base directory
        String catalinaBase = System.getProperty("catalina.base");
        if (catalinaBase == null) {
            catalinaBase = System.getProperty("user.dir");
        }

        // Create the upload directory if it doesn't exist
        String uploadDir = catalinaBase + File.separator + "webapps" + File.separator + UPLOAD_DIR;
        createDirectoryIfNotExists(uploadDir);

        return uploadDir;
    }

    /**
     * Create a directory if it doesn't exist
     * @param dirPath The directory path
     */
    private static void createDirectoryIfNotExists(String dirPath) {
        File dir = new File(dirPath);
        if (!dir.exists()) {
            dir.mkdirs();
        }
    }

    /**
     * Get the file extension from a Part
     * @param part The uploaded file part
     * @return The file extension
     */
    private static String getFileExtension(Part part) {
        String submittedFileName = part.getSubmittedFileName();
        return submittedFileName.substring(submittedFileName.lastIndexOf("."));
    }
}
