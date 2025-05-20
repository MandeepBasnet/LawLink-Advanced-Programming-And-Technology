package util;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.Part;

import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;

public class ImageUtil {

    private static final int TARGET_SIZE = 150; // 150x150 pixels for profile images

    public static String resizeAndSaveProfileImage(Part part, int userId, ServletContext servletContext) throws IOException {
        // Read the image
        BufferedImage originalImage = ImageIO.read(part.getInputStream());
        if (originalImage == null) {
            throw new IOException("Invalid image file.");
        }

        // Resize the image
        BufferedImage resizedImage = resizeImage(originalImage, TARGET_SIZE, TARGET_SIZE);

        // Convert to input stream
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        String format = part.getContentType().equals("image/jpeg") ? "jpg" : "png";
        ImageIO.write(resizedImage, format, baos);
        ByteArrayInputStream bais = new ByteArrayInputStream(baos.toByteArray());

        // Create a custom Part wrapper to pass the resized image to FileStorageUtil
        Part resizedPart = new ResizedPart(part, bais, format);
        return FileStorageUtil.saveProfileImage(resizedPart, userId, servletContext);
    }

    private static BufferedImage resizeImage(BufferedImage originalImage, int targetWidth, int targetHeight) {
        // Calculate scaling factor to maintain aspect ratio
        double widthRatio = (double) targetWidth / originalImage.getWidth();
        double heightRatio = (double) targetHeight / originalImage.getHeight();
        double scale = Math.min(widthRatio, heightRatio);

        int scaledWidth = (int) (originalImage.getWidth() * scale);
        int scaledHeight = (int) (originalImage.getHeight() * scale);

        // Create resized image
        BufferedImage resizedImage = new BufferedImage(targetWidth, targetHeight, BufferedImage.TYPE_INT_ARGB);
        Graphics2D g2d = resizedImage.createGraphics();
        g2d.setRenderingHint(RenderingHints.KEY_INTERPOLATION, RenderingHints.VALUE_INTERPOLATION_BILINEAR);
        g2d.setColor(Color.WHITE);
        g2d.fillRect(0, 0, targetWidth, targetHeight); // White background for transparency
        int x = (targetWidth - scaledWidth) / 2;
        int y = (targetHeight - scaledHeight) / 2;
        g2d.drawImage(originalImage, x, y, scaledWidth, scaledHeight, null);
        g2d.dispose();
        return resizedImage;
    }

    // Custom Part implementation to wrap resized image
    private static class ResizedPart implements Part {
        private final Part originalPart;
        private final InputStream inputStream;
        private final String format;

        public ResizedPart(Part originalPart, InputStream inputStream, String format) {
            this.originalPart = originalPart;
            this.inputStream = inputStream;
            this.format = format;
        }

        @Override
        public InputStream getInputStream() throws IOException {
            return inputStream;
        }

        @Override
        public String getContentType() {
            return "image/" + (format.equals("jpg") ? "jpeg" : format);
        }

        @Override
        public String getName() {
            return originalPart.getName();
        }

        @Override
        public String getSubmittedFileName() {
            return originalPart.getSubmittedFileName();
        }

        @Override
        public long getSize() {
            return -1; // Size is unknown after resizing
        }

        @Override
        public void write(String fileName) throws IOException {
            originalPart.write(fileName);
        }

        @Override
        public void delete() throws IOException {
            originalPart.delete();
        }

        @Override
        public String getHeader(String name) {
            return originalPart.getHeader(name);
        }

        @Override
        public java.util.Collection<String> getHeaders(String name) {
            return originalPart.getHeaders(name);
        }

        @Override
        public java.util.Collection<String> getHeaderNames() {
            return originalPart.getHeaderNames();
        }
    }
}