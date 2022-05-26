package com.viloveul.module;

import com.viloveul.module.initial.TestConfiguration;
import com.viloveul.module.integration.pojo.ApiForm;
import com.viloveul.module.integration.service.ApiService;
import lombok.SneakyThrows;
import org.junit.jupiter.api.Assertions;
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
class ApiTests {

    @Autowired
    private ApiService apiService;

    @SneakyThrows
    @Test
    void testSend() {
        Assertions.assertNotNull(
            this.apiService.send(new ApiForm("http://api.plos.org/search?q=title:DNA"), Object.class)
        );
    }

}