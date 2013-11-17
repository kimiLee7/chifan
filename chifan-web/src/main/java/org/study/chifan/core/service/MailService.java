package org.study.chifan.core.service;

import javax.mail.MessagingException;

/**
 * @author Bruce
 *         Created on 1/20/13.
 */
public interface MailService {
    public void sendHtmlMail() throws MessagingException;

    public void sendHtmlMail(String mailTo, String mailText) throws MessagingException;
}
