package com.viloveul.module.integration.service;

import com.viloveul.module.integration.data.entity.Job;
import org.springframework.amqp.core.Exchange;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

@Service
public interface JobService {

    void resend(String id);

    void send(Job integration);

    void send(String route, Object body);

    void send(Exchange exchange, String route, Object body);

    void send(String exchange, String route, Object body);

    Job detail(String id);

    Page<Job> search(Specification<Job> filter, Pageable pageable);

}
