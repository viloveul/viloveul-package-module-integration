package com.viloveul.module.integration.data.entity;

import com.viloveul.context.base.AbstractMidEntity;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.databind.PropertyNamingStrategies;
import com.fasterxml.jackson.databind.annotation.JsonNaming;
import com.viloveul.context.auth.AccessControl;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Setter
@Getter
@Entity
@NoArgsConstructor
@Table(name = "tbl_job", schema = "schema")
@EqualsAndHashCode(callSuper = true)
@JsonNaming(PropertyNamingStrategies.SnakeCaseStrategy.class)
@AccessControl(resource = "JOB")
public class Job extends AbstractMidEntity {

    @Column(name = "exchange")
    private String exchange;

    @Column(name = "route")
    private String route;

    @Column(name = "content")
    private String content;

    @ManyToOne
    @JoinColumn(name = "id_origin", referencedColumnName = "id", updatable = false)
    @JsonIgnoreProperties({"origin"})
    @NotFound(action = NotFoundAction.IGNORE)
    private Job origin;

    public Job(String exchange, String route, String content) {
        this.exchange = exchange;
        this.route = route;
        this.content = content;
    }

    public Job(Job origin) {
        this.origin = origin.getOrigin() == null ? origin : origin.getOrigin();
        this.exchange = this.origin.getExchange();
        this.route = this.origin.getRoute();
        this.content = this.origin.getContent();
    }

}
