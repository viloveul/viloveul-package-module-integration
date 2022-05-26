package com.viloveul.module.integration.pojo;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.SneakyThrows;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;

import java.io.Serializable;
import java.net.URL;

@Getter
@Setter
@NoArgsConstructor
public class ApiForm implements Serializable {

    private HttpHeaders headers = new HttpHeaders();

    private HttpMethod method = HttpMethod.GET;

    private URL url;

    private Serializable content;

    private String populator;

    public ApiForm(HttpMethod method, URL url, Serializable content) {
        this.method = method;
        this.url = url;
        this.content = content;
    }

    @SneakyThrows
    public ApiForm(HttpMethod method, String url, Serializable content) {
        this.method = method;
        this.url = new URL(url);
        this.content = content;
    }

    @SneakyThrows
    public ApiForm(String url) {
        this.url = new URL(url);
    }

    @SneakyThrows
    public ApiForm(String url, Serializable content) {
        this.url = new URL(url);
        this.content = content;
    }
}
