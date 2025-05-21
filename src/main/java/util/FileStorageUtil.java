package util;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.UUID;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.Part;

public class FileStorageUtil {

    private static final String UPLOAD_DIR = "uploads/users";

    public static String saveProfileImage(Part part, int userId, ServletContext servletContext) throws IOException {
        String uploadDir = getBaseUploadDirectory(servletContext);
        createDirectoryIfNotExists(uploadDir);
        String fileName = getSubmittedFileName(part);
        if (fileName == null || fileName.isEmpty()) {
            throw new IOException("Invalid file name.");
        }
        String extension = fileName.substring(fileName.lastIndexOf("."));
        String uniqueFileName = UUID.randomUUID().toString() + extension;
        Path filePath = Paths.get(uploadDir, uniqueFileName);
        System.out.println("Attempting to save profile image to: " + filePath);
        try {
            Files.copy(part.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);
            System.out.println("Profile image saved successfully: " + filePath);
        } catch (IOException e) {
            System.err.println("Failed to save profile image to " + filePath + ": " + e.getMessage());
            throw e;
        }
        String relativePath = UPLOAD_DIR + "/" + uniqueFileName;
        System.out.println("Returning relative path: " + relativePath);
        return relativePath;
    }

    public static boolean deleteProfileImage(String relativePath, ServletContext servletContext) {
        if (relativePath == null || relativePath.isEmpty()) {
            System.out.println("No profile image to delete (relativePath is null or empty)");
            return false;
        }
        String baseDir = getBaseUploadDirectory(servletContext);
        String normalizedPath = relativePath.replaceFirst("^/+", "").replaceFirst("/+$", "");
        if (normalizedPath.startsWith(UPLOAD_DIR)) {
            normalizedPath = normalizedPath.substring(UPLOAD_DIR.length() + 1);
        }
        Path filePath = Paths.get(baseDir, normalizedPath.replace("/", File.separator));
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

    private static String getBaseUploadDirectory(ServletContext servletContext) {
        String uploadDir = servletContext.getRealPath("/") + UPLOAD_DIR;
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

    private static String getSubmittedFileName(Part part) {
        for (String content : part.getHeader("content-disposition").split(";")) {
            if (content.trim().startsWith("filename")) {
                return content.substring(content.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return null;
    }
}