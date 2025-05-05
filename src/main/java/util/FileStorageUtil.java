package util;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.UUID;

import jakarta.servlet.http.Part;

public class FileStorageUtil {

    private static final String UPLOAD_DIR = "uploads";
    private static final String PROFILE_DIR = "profiles";

    public static String saveProfileImage(Part part, int userId) throws IOException {
        String baseDir = getBaseUploadDirectory();
        String profileDir = baseDir + File.separator + PROFILE_DIR;
        System.out.println("Profile directory: " + profileDir);
        createDirectoryIfNotExists(profileDir);
        String fileName = userId + "_" + UUID.randomUUID().toString() + getFileExtension(part);
        Path filePath = Paths.get(profileDir + File.separator + fileName);
        System.out.println("Attempting to save profile image to: " + filePath);
        try {
            Files.copy(part.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);
            System.out.println("Profile image saved successfully: " + filePath);
        } catch (IOException e) {
            System.err.println("Failed to save profile image to " + filePath + ": " + e.getMessage());
            throw e;
        }
        String relativePath = UPLOAD_DIR + "/" + PROFILE_DIR + "/" + fileName;
        System.out.println("Returning relative path: " + relativePath);
        return relativePath;
    }

    public static boolean deleteProfileImage(String relativePath) {
        if (relativePath == null || relativePath.isEmpty()) {
            System.out.println("No profile image to delete (relativePath is null or empty)");
            return false;
        }
        String baseDir = System.getProperty("catalina.base");
        if (baseDir == null) {
            baseDir = System.getProperty("user.dir");
        }
        // Fix: Remove the extra UPLOAD_DIR from the path
        Path filePath = Paths.get(baseDir + File.separator + "webapps" + File.separator + relativePath.replace("/", File.separator));
        System.out.println("Attempting to delete profile image: " + filePath);
        try {
            boolean deleted = Files.deleteIfExists(filePath);
            System.out.println("Profile image deletion " + (deleted ? "successful" : "failed") + ": " + filePath);
            return deleted;
        } catch (IOException e) {
            System.err.println("Failed to delete profile image " + filePath + ": " + e.getMessage());
            return false;
        }
    }

    private static String getBaseUploadDirectory() {
        String catalinaBase = System.getProperty("catalina.base");
        if (catalinaBase == null) {
            catalinaBase = System.getProperty("user.dir");
        }
        System.out.println("Catalina base: " + catalinaBase);
        String uploadDir = catalinaBase + File.separator + "webapps" + File.separator + UPLOAD_DIR;
        System.out.println("Upload directory: " + uploadDir);
        createDirectoryIfNotExists(uploadDir);
        return uploadDir;
    }

    private static void createDirectoryIfNotExists(String dirPath) {
        File dir = new File(dirPath);
        if (!dir.exists()) {
            System.out.println("Creating directory: " + dirPath);
            boolean created = dir.mkdirs();
            if (created) {
                System.out.println("Directory created successfully: " + dirPath);
            } else {
                System.err.println("Failed to create directory: " + dirPath);
            }
        } else {
            System.out.println("Directory already exists: " + dirPath);
        }
    }

    private static String getFileExtension(Part part) {
        String submittedFileName = part.getSubmittedFileName();
        String extension = submittedFileName.substring(submittedFileName.lastIndexOf("."));
        System.out.println("File extension: " + extension);
        return extension;
    }
}