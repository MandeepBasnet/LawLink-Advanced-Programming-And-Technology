package util;

import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

/**
 * Utility class for sending emails with Jakarta Mail
 */
public class EmailUtil {
    private static final Logger LOGGER = Logger.getLogger(EmailUtil.class.getName());
    
    // SMTP server settings - would be better to load from properties file
    private static final String SMTP_HOST = "smtp.gmail.com";
    private static final String SMTP_PORT = "587";
    private static final String EMAIL_USERNAME = "np05cp4a230108@iic.edu.np"; // Replace with actual email
    private static final String EMAIL_PASSWORD = "clut egwy wvwb jdtg"; // Replace with app password
    private static final String EMAIL_FROM = "np05cp4a230108@iic.edu.np";
    
    /**     * Sends an email using SMTP
     * 
     * @param toEmail Recipient email address
     * @param subject Email subject
     * @param body Email body (HTML)
     * @return true if sent successfully, false otherwise
     */
    public static boolean sendEmail(String toEmail, String subject, String body) {
        try {
            Properties props = new Properties();
            props.put("mail.smtp.host", SMTP_HOST);
            props.put("mail.smtp.port", SMTP_PORT);
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");
            
            // Create session with authentication
            Session session = Session.getInstance(props, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(EMAIL_USERNAME, EMAIL_PASSWORD);
                }
            });
            
            // Create and send message
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(EMAIL_FROM));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject(subject);
            message.setContent(body, "text/html");
            
            Transport.send(message);
            
            LOGGER.log(Level.INFO, "Email sent successfully to: {0}", toEmail);
            return true;
            
        } catch (MessagingException e) {
            LOGGER.log(Level.SEVERE, "Failed to send email to: " + toEmail, e);
            return false;
        }
    }
    
}
