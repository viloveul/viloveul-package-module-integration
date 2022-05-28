package com.viloveul.module.integration.pojo;

import com.viloveul.context.type.TargetType;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import java.io.InputStream;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
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

    private List<Recipient> recipients = new ArrayList<>();

    private transient Map<String, InputStream> attachments = new HashMap<>();

    public MailForm(String subject, String body, Recipient... recipients) {
        this.subject = subject;
        this.body = body;
        this.recipients.addAll(Arrays.asList(recipients));
    }

    public MailForm(String subject, String body, String... emails) {
        this.subject = subject;
        this.body = body;
        for (String email : emails) {
            this.recipients.add(new Recipient(email, TargetType.TO.name()));
        }
    }

    public MailForm(String subject, String body, String email, Attachment... attachments) {
        this.subject = subject;
        this.body = body;
        this.recipients.add(new Recipient(email, TargetType.TO.name()));
        for (Attachment attachment : attachments) {
            this.attachments.put(attachment.name, attachment.stream);
        }
    }

    public MailForm(String subject, String body, Recipient recipient, Attachment... attachments) {
        this.subject = subject;
        this.body = body;
        this.recipients.add(recipient);
        for (Attachment attachment : attachments) {
            this.attachments.put(attachment.name, attachment.stream);
        }
    }

    @Setter
    @Getter
    @NoArgsConstructor
    public static class Recipient implements Serializable {
        private String email;
        private TargetType type;
        public Recipient(String email, String type) {
            this.email = email;
            this.type = TargetType.valueOf(type.toUpperCase(Locale.ROOT));
        }
    }

    @Setter
    @Getter
    @NoArgsConstructor
    public static class Attachment implements Serializable {
        private String name;
        private transient InputStream stream;
        public Attachment(String name, InputStream stream) {
            this.name = name;
            this.stream = stream;
        }
    }
}
