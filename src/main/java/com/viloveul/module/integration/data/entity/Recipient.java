package com.viloveul.module.integration.data.entity;

import com.viloveul.context.base.AbstractEntity;
import com.viloveul.context.type.TargetType;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.databind.PropertyNamingStrategies;
import com.fasterxml.jackson.databind.annotation.JsonNaming;
import com.viloveul.context.auth.AccessControl;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.validation.Valid;

@Getter
@Setter
@Entity
@NoArgsConstructor
@Table(name = "tbl_recipient", schema = "schema")
@EqualsAndHashCode(callSuper = true, exclude = {"mail"})
@JsonNaming(PropertyNamingStrategies.SnakeCaseStrategy.class)
@AccessControl(resource = "RECIPIENT")
public class Recipient extends AbstractEntity {

    @Column(name = "type")
    @Enumerated(EnumType.STRING)
    private TargetType type;

    @Column(name = "email")
    private String email;

    @Valid
    @ManyToOne
    @JoinColumn(name = "id_mail", nullable = false)
    @JsonIgnoreProperties({"recipients"})
    private Mail mail;

    public Recipient(String email) {
        this.email = email;
        this.type = TargetType.TO;
    }

    public Recipient(String email, TargetType type) {
        this.email = email;
        this.type = type;
    }

    public Recipient(Mail mail, String email, TargetType type) {
        this.mail = mail;
        this.email = email;
        this.type = type;
    }
}
