package com.viloveul.module.integration.subscriber;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.viloveul.context.event.GenericTransform;
import com.viloveul.context.util.misc.StringObjectMapper;
import org.springframework.amqp.core.Message;
import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.util.HashMap;
import java.util.Locale;

@Component
public class GeneralMessageSubscriber {

    @Autowired
    private ApplicationEventPublisher publisher;

    @Autowired
    private ObjectMapper mapper;

    @RabbitListener(
        id = "internal",
        queues = "${viloveul.integration.executor:master}-integration",
        containerFactory = "listenerContainerFactory"
    )
    public void onMessage(Message message) throws IOException {
        HashMap<String, Object> map = this.mapper.readValue(message.getBody(), StringObjectMapper.class);
        String[] routes = message.getMessageProperties().getReceivedRoutingKey().split("\\.");
        this.publisher.publishEvent(
            new GenericTransform(routes[routes.length - 1].toUpperCase(Locale.ROOT), map)
        );
    }
}
