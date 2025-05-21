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

    private static final String UPLOAD_DIR = "assets/uploads";

    public static String saveProfileImage(Part part, int userId, ServletContext servletContext) throws IOException {
        String uploadDir = getBaseUploadDirectory(servletContext);
        createDirectoryIfNotExists(uploadDir);
        String fileName = userId + "_" + UUID.randomUUID().toString() + getFileExtension(part);
        Path filePath = Paths.get(uploadDir, fileName);
        System.out.println("Attempting to save profile image to: " + filePath);
        try {
            Files.copy(part.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);
            System.out.println("Profile image saved successfully: " + filePath);
        } catch (IOException e) {
            System.err.println("Failed to save profile image to " + filePath + ": " + e.getMessage());
            throw e;
        }
        String relativePath = UPLOAD_DIR + "/" + fileName;
        System.out.println("Returning relative path: " + relativePath);
        return relativePath;
    }

    public static boolean deleteProfileImage(String relativePath, ServletContext servletContext) {
        if (relativePath == null || relativePath.isEmpty()) {
            System.out.println("No profile image to delete (relativePath is null or empty)");
            return false;
        }
        String baseDir = getBaseUploadDirectory(servletContext);
        // Remove leading "assets/uploads/" to avoid duplication
        String cleanPath = relativePath.replaceFirst("^/?assets/uploads/", "");
        Path filePath = Paths.get(baseDir, cleanPath.replace("/", File.separator));
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

    private static String getFileExtension(Part part) {
        String submittedFileName = part.getSubmittedFileName();
        String extension = submittedFileName.substring(submittedFileName.lastIndexOf("."));
        System.out.println("File extension: " + extension);
        return extension;
    }
}