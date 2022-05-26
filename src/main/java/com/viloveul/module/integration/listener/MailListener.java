package com.viloveul.module.integration.listener;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.viloveul.context.event.GenericTransform;
import com.viloveul.module.integration.data.entity.Mail;
import com.viloveul.module.integration.pojo.MailForm;
import com.viloveul.module.integration.service.MailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.event.EventListener;
import org.springframework.stereotype.Component;

@Component
public class MailListener {

    @Autowired
    private MailService mailService;

    @Autowired
    private ObjectMapper objectMapper;

    @EventListener(condition = "#event.target == 'MAIL'")
    public void send(GenericTransform event) {
        Mail mail = this.mailService.create(
            this.objectMapper.convertValue(
                event.getPayload(),
                MailForm.class
            )
        );
        this.mailService.send(mail);
    }

}
