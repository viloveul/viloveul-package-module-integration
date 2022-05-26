package com.viloveul.module.integration.service;

import com.viloveul.module.integration.data.entity.Mail;
import com.viloveul.module.integration.pojo.MailForm;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

@Service
public interface MailService {

    Mail create(MailForm form);

    void send(Mail mail);

    void send(String id);

    void resend(String id);

    Mail detail(String id);

    Page<Mail> search(Specification<Mail> filter, Pageable pageable);

}
