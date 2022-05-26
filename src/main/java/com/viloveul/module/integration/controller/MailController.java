package com.viloveul.module.integration.controller;

import com.viloveul.module.integration.data.entity.Mail;
import com.viloveul.module.integration.search.MailSpecification;
import com.viloveul.module.integration.service.MailService;
import com.viloveul.context.util.misc.PageableResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping(path = "/mail")
public class MailController {

    @Autowired
    private MailService mailService;

    @Transactional(readOnly = true)
    @GetMapping(produces = MediaType.APPLICATION_JSON_VALUE)
    public PageableResult<Mail> search(Pageable pageable, MailSpecification filter) {
        return new PageableResult<>(this.mailService.search(filter, pageable));
    }

    @Transactional(readOnly = true)
    @GetMapping(path = "/{id}", produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<Mail> detail(@PathVariable("id") String id) {
        return new ResponseEntity<>(this.mailService.detail(id), HttpStatus.OK);
    }

    @Transactional
    @PostMapping(path = "/{id}")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    public void resend(@PathVariable("id") String id) {
        this.mailService.send(id);
    }

}
