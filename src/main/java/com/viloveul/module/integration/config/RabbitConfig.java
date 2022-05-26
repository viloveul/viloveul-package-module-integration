package com.viloveul.module.integration.config;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.amqp.core.AmqpTemplate;
import org.springframework.amqp.rabbit.annotation.EnableRabbit;
import org.springframework.amqp.rabbit.config.SimpleRabbitListenerContainerFactory;
import org.springframework.amqp.rabbit.connection.CachingConnectionFactory;
import org.springframework.amqp.rabbit.connection.ConnectionFactory;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.amqp.support.converter.Jackson2JsonMessageConverter;
import org.springframework.amqp.support.converter.MessageConverter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration(
    proxyBeanMethods = false
)
@EnableRabbit
public class RabbitConfig {

    @Value("${viloveul.rabbit.address:localhost:5672}")
    private String address;

    @Value("${viloveul.rabbit.username:guest}")
    private String username;

    @Value("${viloveul.rabbit.password:guest}")
    private String password;

    @Value("${viloveul.rabbit.vhost:/}")
    private String vhost;

    @Bean
    public ConnectionFactory connectionFactory() {
        CachingConnectionFactory factory = new CachingConnectionFactory();
        factory.setAddresses(this.address);
        factory.setUsername(this.username);
        factory.setPassword(this.password);
        factory.setVirtualHost(this.vhost);
        return factory;
    }

    @Bean
    public MessageConverter messageConverter(@Autowired @Qualifier("objectMapper") ObjectMapper objectMapper) {
        return new Jackson2JsonMessageConverter(objectMapper);
    }

    @Bean
    public AmqpTemplate amqpTemplate(ConnectionFactory connectionFactory, MessageConverter messageConverter) {
        final RabbitTemplate rabbitTemplate = new RabbitTemplate(connectionFactory);
        rabbitTemplate.setMessageConverter(messageConverter);
        return rabbitTemplate;
    }

    @Bean
    public SimpleRabbitListenerContainerFactory listenerContainerFactory(
        ConnectionFactory connectionFactory,
        MessageConverter messageConverter
    ) {
        SimpleRabbitListenerContainerFactory listenerContainerFactory = new SimpleRabbitListenerContainerFactory();
        listenerContainerFactory.setConnectionFactory(connectionFactory);
        listenerContainerFactory.setMissingQueuesFatal(false);
        listenerContainerFactory.setAutoStartup(true);
        listenerContainerFactory.setMessageConverter(messageConverter);
        return listenerContainerFactory;
    }
}
