package com.viloveul.module.integration.data.entity;

import com.viloveul.context.base.AbstractMidEntity;
import com.viloveul.context.type.AttemptType;
import com.viloveul.context.type.ProcessType;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.databind.PropertyNamingStrategies;
import com.fasterxml.jackson.databind.annotation.JsonNaming;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.viloveul.context.auth.AccessControl;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.SneakyThrows;
import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;
import org.springframework.http.HttpMethod;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;
import java.net.URI;
import java.net.URL;
import java.util.Date;

@Setter
@Getter
@Entity
@NoArgsConstructor
@Table(name = "tbl_api", schema = "schema")
@JsonSerialize
@JsonNaming(PropertyNamingStrategies.SnakeCaseStrategy.class)
@AccessControl(resource = "API")
public class Api extends AbstractMidEntity {

    @Column(name = "type")
    @Enumerated(EnumType.STRING)
    private AttemptType type;

    @Column(name = "method")
    @Enumerated(EnumType.STRING)
    private HttpMethod method;

    @Column(name = "protocol")
    private String protocol;

    @Column(name = "info")
    private String info;

    @Column(name = "host")
    private String host;

    @Column(name = "port")
    private Integer port;

    @Column(name = "path")
    private String path;

    @Column(name = "qs")
    private String qs;

    @Column(name = "request_header")
    private String requestHeader;

    @Column(name = "request_body")
    private String requestBody;

    @Column(name = "response_header")
    private String responseHeader;

    @Column(name = "response_body")
    private String responseBody;

    @Column(name = "process")
    @Enumerated(EnumType.STRING)
    private ProcessType process;

    @Column(name = "duration")
    private Double duration;

    @Column(name = "populator")
    private String populator;

    @ManyToOne
    @JoinColumn(name = "id_origin", referencedColumnName = "id", updatable = false)
    @JsonIgnoreProperties({"origin"})
    @NotFound(action = NotFoundAction.IGNORE)
    private Api origin;

    @Transient
    @JsonIgnore
    private transient URL url;

    public Api(Api origin) {
        this.origin = origin;
        this.type = AttemptType.RETRY;
        this.process = ProcessType.PENDING;
        this.requestHeader = this.origin.getRequestHeader();
        this.requestBody = this.origin.getRequestBody();
        this.duration = 0D;
        this.method = this.origin.getMethod();
        this.protocol = this.origin.getProtocol();
        this.info = this.origin.getInfo();
        this.host = this.origin.getHost();
        this.port = this.origin.getPort();
        this.path = this.origin.getPath();
        this.qs = this.origin.getQs();
    }

    public Api(HttpMethod method) {
        this.method = method;
    }

    public Api(HttpMethod method, URL url) {
        this(method);
        this.type = AttemptType.NEW;
        this.setUrl(url);
    }

    public void setUrl(URL url) {
        this.protocol = url.getProtocol();
        this.info = url.getUserInfo();
        this.host = url.getHost();
        this.port = url.getPort();
        this.path = url.getPath();
        this.qs = url.getQuery();
        if (this.port.equals(-1)) {
            this.port = url.getDefaultPort();
        }
    }

    @SneakyThrows
    @JsonIgnore
    @Transient
    public URL getUrl() {
        if (this.url == null) {
            URI uri = new URI(
                this.protocol,
                this.info,
                this.host,
                this.port,
                this.path,
                this.qs,
                null
            );
            this.url = uri.toURL();
        }
        return this.url;
    }
}
