package com.viloveul.module.integration.search;

import com.viloveul.context.type.AttemptType;
import com.viloveul.context.type.ProcessType;
import com.viloveul.module.integration.data.entity.Api;
import com.viloveul.context.filter.SearchSpecification;
import com.viloveul.context.filter.SearchTarget;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.http.HttpMethod;

@Setter
@Getter
@NoArgsConstructor
public class ApiSpecification extends SearchSpecification<Api> {

    @SearchTarget(
        path = "type",
        condition = SearchTarget.Condition.EQUAL,
        option = SearchTarget.Option.SENSITIVE
    )
    protected AttemptType type;

    @SearchTarget(
        path = "method",
        condition = SearchTarget.Condition.EQUAL,
        option = SearchTarget.Option.SENSITIVE
    )
    protected HttpMethod method;

    @SearchTarget(
        path = "host",
        condition = SearchTarget.Condition.LIKE
    )
    protected String host;

    @SearchTarget(
        path = "port",
        condition = SearchTarget.Condition.LIKE,
        option = SearchTarget.Option.SENSITIVE
    )
    protected Integer port;

    @SearchTarget(
        path = "path",
        condition = SearchTarget.Condition.LIKE
    )
    protected String path;

    @SearchTarget(
        path = "request_header",
        condition = SearchTarget.Condition.LIKE
    )
    protected String requestHeader;

    @SearchTarget(
        path = "request_body",
        condition = SearchTarget.Condition.LIKE
    )
    protected String requestBody;

    @SearchTarget(
        path = "response_header",
        condition = SearchTarget.Condition.LIKE
    )
    protected String responseHeader;

    @SearchTarget(
        path = "response_body",
        condition = SearchTarget.Condition.LIKE
    )
    protected String responseBody;

    @SearchTarget(
        path = "process",
        condition = SearchTarget.Condition.EQUAL,
        option = SearchTarget.Option.SENSITIVE
    )
    protected ProcessType process;

    @SearchTarget(
        path = "duration",
        condition = SearchTarget.Condition.LIKE,
        option = SearchTarget.Option.SENSITIVE
    )
    protected Double duration;

}
