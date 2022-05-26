package com.viloveul.module.integration.controller;

import com.viloveul.module.integration.data.entity.Api;
import com.viloveul.module.integration.search.ApiSpecification;
import com.viloveul.module.integration.service.ApiService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
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
@RequestMapping(path = "/gate")
public class GateController {

    @Autowired
    private ApiService apiService;

    @Transactional(readOnly = true)
    @GetMapping(produces = MediaType.APPLICATION_JSON_VALUE)
    @PreAuthorize("hasPermission('API', 'SEARCH')")
    public Page<Api> search(Pageable pageable, ApiSpecification filter) {
        return this.apiService.search(filter, pageable);
    }

    @Transactional(readOnly = true)
    @GetMapping(path = "/{id}", produces = MediaType.APPLICATION_JSON_VALUE)
    @PreAuthorize("hasPermission('API', 'DETAIL')")
    public ResponseEntity<Api> detail(@PathVariable("id") String id) {
        return new ResponseEntity<>(this.apiService.detail(id), HttpStatus.OK);
    }

    @Transactional
    @PostMapping(path = "/{id}")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    @PreAuthorize("hasPermission('API', 'RESEND')")
    public void resend(@PathVariable("id") String id) {
        this.apiService.resend(id);
    }

}
