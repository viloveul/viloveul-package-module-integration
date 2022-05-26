package com.viloveul.module.integration.search;

import com.viloveul.module.integration.data.entity.Mail;
import com.viloveul.context.filter.SearchSpecification;
import com.viloveul.context.filter.SearchTarget;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class MailSpecification extends SearchSpecification<Mail> {

    @SearchTarget(
        path = "email",
        condition = SearchTarget.Condition.LIKE
    )
    protected String email;

    @SearchTarget(
        path = "subject",
        condition = SearchTarget.Condition.LIKE
    )
    protected String subject;

    @SearchTarget(
        path = "body",
        condition = SearchTarget.Condition.LIKE
    )
    protected String body;

}
