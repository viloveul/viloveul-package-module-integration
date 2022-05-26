package com.viloveul.module.integration.service.impl;

import com.viloveul.context.constant.message.DomainErrorCollection;
import com.viloveul.context.type.ProcessType;
import com.viloveul.module.integration.data.entity.Api;
import com.viloveul.module.integration.data.repository.ApiRepository;
import com.viloveul.module.integration.service.ApiService;
import com.viloveul.module.integration.pojo.ApiForm;
import com.viloveul.context.ApplicationContainer;
import com.viloveul.context.exception.GeneralFailureException;
import com.viloveul.context.util.misc.DataPopulator;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.SneakyThrows;
import org.apache.http.conn.ssl.SSLConnectionSocketFactory;
import org.apache.http.conn.ssl.TrustStrategy;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.impl.client.LaxRedirectStrategy;
import org.apache.http.ssl.SSLContextBuilder;
import org.apache.http.ssl.SSLContexts;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.http.client.HttpComponentsClientHttpRequestFactory;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;
import org.springframework.util.StopWatch;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;

import javax.net.ssl.SSLContext;
import java.security.KeyManagementException;
import java.security.KeyStoreException;
import java.security.NoSuchAlgorithmException;
import java.security.cert.X509Certificate;
import java.util.Optional;
import java.util.function.Consumer;

@Service
public class ApiServiceImpl implements ApiService {

    private static final Logger LOGGER = LoggerFactory.getLogger(ApiServiceImpl.class);

    @Autowired
    private ApiRepository apiRepository;

    @Autowired
    private ObjectMapper objectMapper;

    private RestTemplate rest;

    public ApiServiceImpl() {
        TrustStrategy acceptingTrustStrategy = (X509Certificate[] chain, String authType) -> true;
        try {
            SSLContextBuilder contextBuilder = SSLContexts.custom();
            SSLContext sslContext = contextBuilder.loadTrustMaterial(null, acceptingTrustStrategy).build();
            SSLConnectionSocketFactory csf = new SSLConnectionSocketFactory(sslContext, (hostname, session) -> true); //NOSONAR
            HttpClientBuilder clientBuilder = HttpClients.custom();
            clientBuilder.setSSLSocketFactory(csf);
            clientBuilder.setRedirectStrategy(new LaxRedirectStrategy());
            CloseableHttpClient httpClient = clientBuilder.build();
            HttpComponentsClientHttpRequestFactory requestFactory = new HttpComponentsClientHttpRequestFactory();
            requestFactory.setHttpClient(httpClient);
            this.rest = new RestTemplate(requestFactory);
        } catch (NoSuchAlgorithmException | KeyManagementException | KeyStoreException e) {
            this.rest = new RestTemplate();
            LOGGER.warn(e.getMessage(), e.getCause());
        }
    }

    @SneakyThrows
    @Override
    public <T> T send(ApiForm form, Class<T> clzz) {
        Api request = form.getPopulator() == null ?
            this.makeRequest(form) :
                ApplicationContainer.getBean(form.getPopulator(), DataPopulator.class)
                    .populate(this.makeRequest(form)
                );
        Api response = this.makeResponse(this.apiRepository.save(request));
        if (ProcessType.ERROR == response.getProcess()) {
            return this.objectMapper.convertValue(response.getResponseBody(), clzz);
        }
        return null;
    }

    @Override
    @Async
    public void send(ApiForm form) {
        Api request = form.getPopulator() == null ?
            this.makeRequest(form) :
                ApplicationContainer.getBean(form.getPopulator(), DataPopulator.class)
                    .populate(this.makeRequest(form)
                );
        this.makeResponse(this.apiRepository.save(request));
    }

    @Override
    @Async
    public void send(ApiForm form, Consumer<Api> consumer) {
        Api request = form.getPopulator() == null ?
            this.makeRequest(form) :
                ApplicationContainer.getBean(form.getPopulator(), DataPopulator.class)
                    .populate(this.makeRequest(form)
                );
        consumer.accept(this.makeResponse(this.apiRepository.save(request)));
    }

    @Async
    @Override
    public void resend(Api api) {
        this.makeResponse(this.apiRepository.save(new Api(api)));
    }

    @Async
    @Override
    public void resend(String id) {
        Optional<Api> api = this.apiRepository.findById(id);
        api.ifPresent(this::resend);
    }

    @SneakyThrows
    @Async
    @Override
    public void send(Api api) {
        this.makeResponse(api);
    }

    @SneakyThrows
    @Async
    @Override
    public void send(Api api, Consumer<Api> consumer) {
        consumer.accept(this.makeResponse(api));
    }

    @Override
    public Api detail(String id) {
        Optional<Api> res = this.apiRepository.findById(id);
        if (!res.isPresent()) {
            throw new GeneralFailureException(DomainErrorCollection.DATA_IS_NOT_EXISTS);
        }
        return res.get();
    }

    @Override
    public Page<Api> search(Specification<Api> filter, Pageable pageable) {
        return this.apiRepository.findAll(filter, pageable);
    }

    private Api makeRequest(ApiForm form) {
        Api api = new Api(form.getMethod(), form.getUrl());
        api.setProcess(ProcessType.PENDING);
        api.setPopulator(form.getPopulator());
        if (!form.getHeaders().isEmpty()) {
            try {
                api.setRequestHeader(this.objectMapper.writeValueAsString(form.getHeaders()));
            } catch (JsonProcessingException e) {
                LOGGER.warn(e.getMessage(), e.getCause());
            }
        }
        if (form.getContent() != null) {
            try {
                api.setRequestBody(this.objectMapper.writeValueAsString(form.getContent()));
            } catch (JsonProcessingException e) {
                LOGGER.warn(e.getMessage(), e.getCause());
            }
        }
        return api;
    }

    @SneakyThrows
    private Api makeResponse(Api request) {
        StopWatch stopwatch = new StopWatch();
        stopwatch.setKeepTaskList(false);
        stopwatch.start();
        try {
            ResponseEntity<byte[]> response = this.rest.exchange(
                request.getUrl().toURI(),
                request.getMethod(),
                new HttpEntity<>(
                    request.getRequestBody() == null ? null :
                    this.objectMapper.convertValue(request.getRequestBody(), byte[].class),
                    request.getRequestHeader() == null ? null :
                    this.objectMapper.convertValue(request.getRequestHeader(), HttpHeaders.class)
                ),
                byte[].class
            );
            request.setProcess(ProcessType.SUCCESS);
            request.setResponseHeader(this.objectMapper.writeValueAsString(response.getHeaders()));
            request.setResponseBody(this.objectMapper.writeValueAsString(response.getBody()));
        } catch (RestClientException e) {
            LOGGER.warn(e.getMessage(), e.getCause());
            request.setProcess(ProcessType.ERROR);
            request.setResponseHeader(e.getClass().getCanonicalName());
            request.setResponseBody(this.objectMapper.writeValueAsString(e));
        }
        stopwatch.stop();
        request.setDuration(stopwatch.getTotalTimeSeconds());
        return this.apiRepository.save(request);
    }
}
