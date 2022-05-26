package com.viloveul.module.integration.controller;

import com.viloveul.module.integration.data.entity.Job;
import com.viloveul.module.integration.search.JobSpecification;
import com.viloveul.module.integration.service.JobService;
import com.viloveul.context.util.misc.PageableResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping(path = "/job")
public class JobController {

    @Autowired
    private JobService jobService;

    @Transactional(readOnly = true)
    @GetMapping(produces = MediaType.APPLICATION_JSON_VALUE)
    @PreAuthorize("hasPermission('JOB', 'SEARCH')")
    public PageableResult<Job> search(JobSpecification filter, Pageable pageable) {
        return new PageableResult<>(this.jobService.search(filter, pageable));
    }

    @Transactional(readOnly = true)
    @GetMapping(path = "/{id}", produces = MediaType.APPLICATION_JSON_VALUE)
    @PreAuthorize("hasPermission('JOB', 'DETAIL')")
    public ResponseEntity<Job> detail(@PathVariable("id") String id) {
        return new ResponseEntity<>(this.jobService.detail(id), HttpStatus.OK);
    }

    @Transactional
    @PostMapping(path = "/{id}")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    @PreAuthorize("hasPermission('JOB', 'RESEND')")
    public void resend(@PathVariable("id") String id) {
        this.jobService.resend(id);
    }


}
