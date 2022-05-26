package com.viloveul.module.integration.search;

import com.viloveul.module.integration.data.entity.Job;
import com.viloveul.context.filter.SearchSpecification;
import com.viloveul.context.filter.SearchTarget;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class JobSpecification extends SearchSpecification<Job> {

    @SearchTarget(
        path = "exchange",
        condition = SearchTarget.Condition.LIKE
    )
    protected String exchange;

    @SearchTarget(
        path = "route",
        condition = SearchTarget.Condition.LIKE
    )
    protected String route;

    @SearchTarget(
        path = "content",
        condition = SearchTarget.Condition.LIKE
    )
    protected String content;

}
