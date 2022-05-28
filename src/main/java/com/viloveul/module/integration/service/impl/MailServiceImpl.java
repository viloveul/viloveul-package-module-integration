package com.viloveul.module.integration.service.impl;

import com.viloveul.context.base.AbstractComponent;
import com.viloveul.context.util.misc.MediaStorage;
import com.viloveul.module.integration.data.entity.Attachment;
import com.viloveul.module.integration.data.entity.Mail;
import com.viloveul.module.integration.data.entity.Recipient;
import com.viloveul.module.integration.pojo.MailForm;
import com.viloveul.module.integration.data.repository.MailRepository;
import com.viloveul.module.integration.service.MailService;
import lombok.SneakyThrows;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.mail.MailException;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.validation.Valid;
import java.io.InputStream;
import java.util.Date;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

@Service
public class MailServiceImpl extends AbstractComponent implements MailService {

    private static final Logger LOGGER = LoggerFactory.getLogger(MailServiceImpl.class);

    @Autowired
    private JavaMailSender mailSender;

    @Autowired
    private MailRepository mailRepository;

    @Autowired
    private MediaStorage mediaStorage;

    @Value("${viloveul.mail.from}")
    private String from;

    @Async
    @Override
    public void send(String id) {
        Mail mail = this.mailRepository.getOne(id);
        mail.setUpdatedAt(new Date());
        this.send(this.mailRepository.save(mail));
    }

    @Async
    @Override
    public void resend(String id) {
        Mail mail = this.mailRepository.getOne(id);
        this.send(this.mailRepository.save(new Mail(mail)));
    }

    @Override
    public Mail detail(String id) {
        return this.mailRepository.getOne(id);
    }

    @Override
    public Page<Mail> search(Specification<Mail> filter, Pageable pageable) {
        return this.mailRepository.findAll(filter, pageable);
    }

    @SneakyThrows
    @Override
    public Mail create(@Valid MailForm form) {
        Mail mail = new Mail(
            this.from,
            form.getSubject(),
            form.getBody()
        );
        Set<Recipient> recipients = new HashSet<>();
        Set<Attachment> attachments = new HashSet<>();
        for (MailForm.Recipient recipient : form.getRecipients()) {
            recipients.add(new Recipient(mail, recipient.getEmail(), recipient.getType()));
        }
        for (Map.Entry<String, InputStream> attachment : form.getAttachments().entrySet()) {
            attachments.add(
                new Attachment(
                    mail,
                    attachment.getKey(),
                    this.mediaStorage.write(
                        attachment.getKey(),
                        attachment.getValue()
                    )
                )
            );
        }
        mail.setRecipients(recipients);
        mail.setAttachments(attachments);
        return this.mailRepository.save(mail);
    }

    @Async
    @Override
    public void send(Mail mail) {
        try {
            MimeMessage mailMessage = this.mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(mailMessage, !mail.getAttachments().isEmpty());
            helper.setFrom(mail.getEmail());
            helper.setSubject(mail.getSubject());
            helper.setText(mail.getBody());
            for (Attachment attachment : mail.getAttachments()) {
                helper.addAttachment(attachment.getName(), this.mediaStorage.load(attachment.getSource()));
            }
            for (Recipient recipient : mail.getRecipients()) {
                switch (recipient.getType().name()) {
                    case "BCC" :
                        helper.addBcc(recipient.getEmail());
                        break;
                    case "CC" :
                        helper.addCc(recipient.getEmail());
                        break;
                    case "TO" :
                    default:
                        helper.addTo(recipient.getEmail());
                        break;
                }
            }
            this.mailSender.send(mailMessage);
        } catch (MessagingException | MailException e) {
            LOGGER.warn(e.getMessage(), e.getCause());
        }
    }
}
