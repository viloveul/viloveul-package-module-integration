package com.viloveul.module.integration.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;

import java.util.Properties;

@Configuration(
    proxyBeanMethods = false
)
public class MailConfig {

    @Value("${viloveul.mail.host:smtp.mailserver.com}")
    private String host;

    @Value("${viloveul.mail.port:587}")
    private Integer port;

    @Value("${viloveul.mail.username:admin@mailserver.com}")
    private String username;

    @Value("${viloveul.mail.password:M4ailPassword}")
    private String password;

    @Value("${viloveul.mail.protocol:smtp}")
    private String protocol;

    @Value("${viloveul.mail.auth:true}")
    private Boolean auth;

    @Value("${viloveul.mail.starttls:true}")
    private Boolean starttls;

    @Bean
    public JavaMailSender mailSender() {
        JavaMailSenderImpl mailSender = new JavaMailSenderImpl();
        mailSender.setHost(this.host);
        mailSender.setProtocol(this.protocol);
        mailSender.setPort(this.port);
        mailSender.setUsername(this.username);
        mailSender.setPassword(this.password);

        Properties props = mailSender.getJavaMailProperties();
        props.put(
            "mail.transport.protocol",
            this.protocol
        );
        props.put(
            "mail.smtp.auth",
            this.auth.toString()
        );

        if (Boolean.TRUE.equals(this.starttls)) {
            props.put("mail.smtp.starttls.enable", "true");
            props.put("mail.smtp.starttls.required", "true");
        } else {
            props.put("mail.smtp.starttls.enable", "false");
            props.put("mail.smtp.starttls.required", "false");
        }

        mailSender.setJavaMailProperties(props);
        return mailSender;
    }
}
