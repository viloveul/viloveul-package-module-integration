package com.viloveul.module;

import com.viloveul.module.integration.service.MailService;
import com.viloveul.module.initial.TestConfiguration;
import com.viloveul.module.integration.service.JobService;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.springframework.transaction.annotation.Transactional;

@ExtendWith(SpringExtension.class)
@ContextConfiguration(
    classes = {
        TestConfiguration.class
    }
)
@Transactional
class EmailTests {

    @Autowired
    private JobService messageService;

    @Autowired
    private MailService mailService;

    @Test
    void testSendEmail() {
    }
}
