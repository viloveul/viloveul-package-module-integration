package com.viloveul.module.integration.data.entity;

import com.viloveul.context.base.AbstractEntity;
import com.viloveul.context.type.TargetType;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.databind.PropertyNamingStrategy;
import com.fasterxml.jackson.databind.annotation.JsonNaming;
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
@Table(name = "tprefix_attachment", schema = "schema")
@EqualsAndHashCode(callSuper = true, exclude = {"mail"})
@JsonNaming(PropertyNamingStrategy.SnakeCaseStrategy.class)
public class Attachment extends AbstractEntity {

    @Column(name = "name")
    private String name;

    @Column(name = "source")
    private String source;

    @Valid
    @ManyToOne
    @JoinColumn(name = "id_mail", nullable = false)
    @JsonIgnoreProperties({"recipients"})
    private Mail mail;

    public Attachment(String name, String source) {
        this.name = name;
        this.source = source;
    }

    public Attachment(Mail mail, String name, String source) {
        this.mail = mail;
        this.name = name;
        this.source = source;
    }
}
