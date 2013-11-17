package org.study.chifan.core.utils;

import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSenderImpl;

/**
 * @author Bruce
 *         Created on 1/14/13.
 */
public class SingleMailSender {
    public static void main(String args[]){
        sendSimpleMail();
    }

    private static void sendSimpleMail() {
        JavaMailSenderImpl senderImpl = new JavaMailSenderImpl();
        //设定mail server
        senderImpl.setHost("smtp.exmail.qq.com");
        senderImpl.setUsername("noreply.swiftsync@conversant.com.cn");
        senderImpl.setPassword("8uhb#EDC");

        //建立邮件消息
        SimpleMailMessage mailMessage = new SimpleMailMessage();
        //设置收件人，寄件人
        //String[] array = new String[]    {"sun111@163.com","sun222@sohu.com"};
        //mailMessage.setTo(array);
        mailMessage.setTo("hongjun@conversant.com.cn");
        mailMessage.setFrom("noreply.swiftsync@conversant.com.cn");
        mailMessage.setSubject("send mail test！");
        mailMessage.setText("test my mail sending！！");

        //发送邮件
        senderImpl.send(mailMessage);

        System.out.println("send mail ok.....");
    }
}
