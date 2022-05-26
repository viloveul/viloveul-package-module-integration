package com.viloveul.module.integration.pojo;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import java.io.InputStream;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Setter
@Getter
@NoArgsConstructor
public class MailForm implements Serializable {

    @NotNull
    @NotEmpty
    private String subject;

    @NotNull
    @NotEmpty
    private String body;

    @JsonProperty("to")
    private List<String> toArray = new ArrayList<>();

    @JsonProperty("cc")
    private List<String> ccArray = new ArrayList<>();

    @JsonProperty("bcc")
    private List<String> bccArray = new ArrayList<>();

    private Map<String, InputStream> attachments = new HashMap<>();

    public MailForm(String subject, String body, Collection<String> emails) {
        this.subject = subject;
        this.body = body;
        this.toArray.addAll(emails);
    }

    public MailForm(String subject, String body, String email) {
        this.subject = subject;
        this.body = body;
        this.toArray.add(email);
    }

}
