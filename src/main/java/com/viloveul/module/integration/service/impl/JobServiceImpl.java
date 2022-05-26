package com.viloveul.module.integration.service.impl;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.viloveul.module.integration.data.entity.Job;
import com.viloveul.module.integration.data.repository.JobRepository;
import com.viloveul.module.integration.service.JobService;
import com.viloveul.context.constant.message.DomainErrorCollection;
import com.viloveul.context.exception.GeneralFailureException;
import lombok.SneakyThrows;
import org.springframework.amqp.core.AmqpTemplate;
import org.springframework.amqp.core.Exchange;
import org.springframework.amqp.core.Message;
import org.springframework.amqp.core.MessageProperties;
import org.springframework.amqp.core.TopicExchange;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

import java.nio.charset.StandardCharsets;
import java.util.Optional;

@Service
public class JobServiceImpl implements JobService {

    @Autowired
    private AmqpTemplate amqpTemplate;

    @Autowired
    private ObjectMapper objectMapper;

    @Autowired
    private JobRepository integrationRepository;

    @Value("${viloveul.integration.executor:master}")
    private String executor;

    @Async
    @Override
    public void resend(String id) {
        Optional<Job> res = this.integrationRepository.findById(id);
        res.ifPresent(integration -> this.send(
            this.integrationRepository.save(new Job(integration))
        ));
    }

    @Async
    @Override
    public void send(Job integration) {
        MessageProperties properties = new MessageProperties();
        properties.setContentType(MessageProperties.CONTENT_TYPE_JSON);
        properties.setContentEncoding(StandardCharsets.UTF_8.name());
        this.amqpTemplate.send(
            integration.getExchange(),
            integration.getRoute(),
            new Message(integration.getContent().getBytes(), properties)
        );
    }

    @Async
    @Override
    public void send(String route, Object body) {
        this.send("integration", route, body);
    }

    @SneakyThrows
    @Override
    @Async
    public void send(Exchange exchange, String route, Object body) {
        String content = objectMapper.writeValueAsString(body);
        Job integration = new Job(exchange.getName(), this.executor + "-integration." + route, content);
        this.send(
            this.integrationRepository.save(integration)
        );
    }

    @SneakyThrows
    @Override
    @Async
    public void send(String exchange, String route, Object body) {
        this.send(new TopicExchange(this.executor + "-" + exchange, true, false), route, body);
    }

    @Override
    public Job detail(String id) {
        Optional<Job> res = this.integrationRepository.findById(id);
        if (!res.isPresent()) {
            throw new GeneralFailureException(DomainErrorCollection.DATA_IS_NOT_EXISTS);
        }
        return res.get();
    }

    @Override
    public Page<Job> search(Specification<Job> filter, Pageable pageable) {
        return this.integrationRepository.findAll(filter, pageable);
    }

}
