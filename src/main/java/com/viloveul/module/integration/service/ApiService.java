package com.viloveul.module.integration.service;

import com.viloveul.module.integration.data.entity.Api;
import com.viloveul.module.integration.pojo.ApiForm;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import java.util.function.Consumer;

@Service
public interface ApiService {

    <T> T send(ApiForm form, Class<T> clzz);

    void send(ApiForm form);

    void send(ApiForm form, Consumer<Api> consumer);

    void resend(Api api);

    void resend(String id);

    void send(Api api);

    void send(Api api, Consumer<Api> consumer);

    Api detail(String id);

    Page<Api> search(Specification<Api> filter, Pageable pageable);
}
