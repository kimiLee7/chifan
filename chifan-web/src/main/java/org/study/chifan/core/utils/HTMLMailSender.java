package org.study.chifan.core.utils;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;

/**
 * @author Bruce
 *         Created on 1/20/13.
 */
public class HTMLMailSender {
    public static void main(String[] args) throws Exception {
        final String mailServerHost = "smtp.exmail.qq.com";
        final String mailServerUser = "noreply.swiftsync@conversant.com.cn";
        final String mailServerPassword = "8uhb#EDC";
        final String mailTo = "hongjun@conversant.com.cn";
        final String mailFrom = "noreply.swiftsync@conversant.com.cn";
        final String mailSubject = "测试HTML邮件！";
        final String mailText = "<html><head></head><body><h1>hello!!zhangjian</h1></body></html>";
        sendHtmlMail(mailServerHost, mailServerUser, mailServerPassword, mailTo, mailFrom, mailSubject, mailText);
    }

    public static void sendHtmlMail(String mailServerHost, String mailServerUser, String mailServerPassword, String mailTo, String mailFrom, String mailSubject, String mailText) throws MessagingException {
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
