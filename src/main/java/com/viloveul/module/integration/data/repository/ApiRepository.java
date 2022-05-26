package com.viloveul.module.integration.data.repository;

import com.viloveul.module.integration.data.entity.Api;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

@Repository
public interface ApiRepository extends JpaRepository<Api, String>, JpaSpecificationExecutor<Api> {
}
