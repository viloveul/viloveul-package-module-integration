package com.viloveul.module.integration.data.entity;

import com.viloveul.context.auth.AccessControl;
import com.viloveul.context.base.AbstractMidEntity;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.databind.PropertyNamingStrategy;
import com.fasterxml.jackson.databind.annotation.JsonNaming;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.Valid;
import java.util.HashSet;
import java.util.Set;

@Getter
@Setter
@Entity
@NoArgsConstructor
@Table(name = "tprefix_mail", schema = "schema")
@EqualsAndHashCode(callSuper = true, exclude = {"attachments"})
@JsonNaming(PropertyNamingStrategy.SnakeCaseStrategy.class)
@AccessControl(resource = "MAIL")
public class Mail extends AbstractMidEntity {

    @Column(name = "email")
    private String email;

    @Column(name = "subject")
    private String subject;

    @Column(name = "body")
    private String body;

    @Valid
    @OneToMany(mappedBy = "mail", cascade = CascadeType.ALL)
    @NotFound(action = NotFoundAction.IGNORE)
    @JsonIgnoreProperties({"mail"})
    private Set<Attachment> attachments = new HashSet<>();

    @Valid
    @OneToMany(mappedBy = "mail", cascade = CascadeType.ALL)
    @NotFound(action = NotFoundAction.IGNORE)
    @JsonIgnoreProperties({"mail"})
    private Set<Recipient> recipients = new HashSet<>();

    @ManyToOne
    @JoinColumn(name = "id_origin", referencedColumnName = "id", updatable = false)
    @JsonIgnoreProperties({"origin"})
    @NotFound(action = NotFoundAction.IGNORE)
    private Mail origin;

    public Mail(String email, String subject, String body) {
        this.subject = subject;
        this.body = body;
        this.email = email;
    }

    public Mail(String email) {
        this.email = email;
    }

    public Mail(Mail mail) {
        this.origin = mail.getOrigin() == null ? mail : mail.getOrigin();
        for (Recipient recipient : this.origin.getRecipients()) {
            this.recipients.add(new Recipient(this, recipient.getEmail(), recipient.getType()));
        }
        this.attachments.addAll(this.origin.getAttachments());
        this.subject = this.origin.getSubject();
        this.body = this.origin.getBody();
        this.email = this.origin.getEmail();
    }
}
