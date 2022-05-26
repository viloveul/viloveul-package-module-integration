package com.viloveul.module.integration.data.repository;

import com.viloveul.module.integration.data.entity.Mail;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

@Repository
public interface MailRepository extends JpaRepository<Mail, String>, JpaSpecificationExecutor<Mail> {
}
