package org.study.chifan.core.service.impl;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import org.study.chifan.core.service.MailService;

@Service
public class MailServiceImpl implements MailService {
    public static String MAIL_SERVER_HOST = "mail.server.host";
    public static String MAIL_SERVER_USER = "mail.server.user";
    public static String MAIL_SERVER_PASSWORD = "mail.server.password";
    public static String MAIL_TO = "mail.to";
    public static String MAIL_FROM = "mail.from";
    public static String MAIL_SUBJECT = "mail.subject";
    public static String MAIL_TEXT = "mail.text";

    @Autowired
    private MessageSource configuration;

    public static void main(String[] args) throws Exception {
        MailServiceImpl mailService = new MailServiceImpl();
        mailService.sendHtmlMail();
    }

    private static void test1() throws MessagingException {
        final String mailServerHost = "smtp.exmail.qq.com";
        final String mailServerUser = "noreply.swiftsync@conversant.com.cn";
        final String mailServerPassword = "8uhb#EDC";
        final String mailTo = "hongjun@conversant.com.cn";
        final String mailFrom = "noreply.swiftsync@conversant.com.cn";
        final String mailSubject = "测试HTML邮件！";
        final String mailText = "<html><head></head><body><h1>hello!!zhangjian</h1></body></html>";
        MailServiceImpl mailService = new MailServiceImpl();
        mailService.sendHtmlMail(mailServerHost, mailServerUser, mailServerPassword, mailTo, mailFrom, mailSubject, mailText);
    }

    public void sendHtmlMail() throws MessagingException {
        final String mailServerHost = configuration.getMessage(MAIL_SERVER_HOST, null, null);
        final String mailServerUser = configuration.getMessage(MAIL_SERVER_USER, null, null);
        final String mailServerPassword = configuration.getMessage(MAIL_SERVER_PASSWORD, null, null);
        final String mailTo = configuration.getMessage(MAIL_TO, null, null);
        final String mailFrom = configuration.getMessage(MAIL_FROM, null, null);
        final String mailSubject = configuration.getMessage(MAIL_SUBJECT, null, null);
        final String mailText = configuration.getMessage(MAIL_TEXT, null, null);

        sendHtmlMail(mailServerHost, mailServerUser, mailServerPassword, mailTo, mailFrom, mailSubject, mailText);
    }

    public void sendHtmlMail(String mailTo, String mailText) throws MessagingException {
        final String mailServerHost = configuration.getMessage(MAIL_SERVER_HOST, null, null);
        final String mailServerUser = configuration.getMessage(MAIL_SERVER_USER, null, null);
        final String mailServerPassword = configuration.getMessage(MAIL_SERVER_PASSWORD, null, null);
        final String mailFrom = configuration.getMessage(MAIL_FROM, null, null);
        final String mailSubject = configuration.getMessage(MAIL_SUBJECT, null, null);

        sendHtmlMail(mailServerHost, mailServerUser, mailServerPassword, mailTo, mailFrom, mailSubject, mailText);
    }

    public void sendHtmlMail(String mailServerHost, String mailServerUser, String mailServerPassword, String mailTo, String mailFrom, String mailSubject, String mailText) throws MessagingException {
        JavaMailSenderImpl senderImpl = new JavaMailSenderImpl();

        //设定mail server
        senderImpl.setHost(mailServerHost);
        senderImpl.setUsername(mailServerUser);
        senderImpl.setPassword(mailServerPassword);

        //建立邮件消息,发送简单邮件和html邮件的区别
        MimeMessage mailMessage = senderImpl.createMimeMessage();
        MimeMessageHelper messageHelper = new MimeMessageHelper(mailMessage);

        //设置收件人，寄件人
        messageHelper.setTo(mailTo);
        messageHelper.setFrom(mailFrom);
        messageHelper.setSubject(mailSubject);
        //true 表示启动HTML格式的邮件
        messageHelper.setText(mailText, true);

        //发送邮件
        senderImpl.send(mailMessage);
    }
}
