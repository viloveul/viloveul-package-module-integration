package com.viloveul.module.initial;

import com.viloveul.context.ViloveulConfiguration;
import com.viloveul.context.behaviour.EntityNamingStrategy;
import com.viloveul.context.behaviour.EntityEventInterceptor;
import com.viloveul.context.ApplicationContainer;
import org.hibernate.EmptyInterceptor;
import org.hibernate.cfg.AvailableSettings;
import org.hibernate.jpa.HibernatePersistenceProvider;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.CacheManager;
import org.springframework.cache.support.NoOpCacheManager;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;
import org.springframework.context.annotation.PropertySource;
import org.springframework.context.annotation.PropertySources;
import org.springframework.core.env.Environment;
import org.springframework.core.io.ClassPathResource;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.jdbc.datasource.init.DataSourceInitializer;
import org.springframework.jdbc.datasource.init.ResourceDatabasePopulator;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.orm.jpa.JpaTransactionManager;
import org.springframework.orm.jpa.JpaVendorAdapter;
import org.springframework.orm.jpa.LocalContainerEntityManagerFactoryBean;
import org.springframework.orm.jpa.vendor.HibernateJpaVendorAdapter;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.persistence.EntityManagerFactory;
import javax.persistence.spi.PersistenceProvider;
import javax.sql.DataSource;
import java.util.Properties;

@Configuration
@ComponentScan(
    basePackages = {
        "com.viloveul.module.integration"
    }
)
@PropertySources({
    @PropertySource(value = "application.properties"),
    @PropertySource(value = "application-testing.properties", ignoreResourceNotFound = true)
})
@EnableJpaRepositories(basePackages = {
    "com.viloveul.module.integration.data.repository"
})
@EnableGlobalMethodSecurity(prePostEnabled = true, securedEnabled = true)
@Import(ViloveulConfiguration.class)
public class TestConfiguration {

    @Autowired
    private Environment environment;

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    public LocalContainerEntityManagerFactoryBean entityManagerFactory(ApplicationEventPublisher publisher) {
        LocalContainerEntityManagerFactoryBean factory = new LocalContainerEntityManagerFactoryBean();
        PersistenceProvider persistenceProvider = new HibernatePersistenceProvider();
        JpaVendorAdapter jpaVendorAdapter = new HibernateJpaVendorAdapter();
        factory.setBeanName("entityManagerFactory");
        factory.setDataSource(dataSource());
        factory.setPackagesToScan(
            "com.viloveul.module.integration.data.entity"
        );
        factory.setPersistenceProvider(persistenceProvider);
        factory.setJpaVendorAdapter(jpaVendorAdapter);
        factory.setJpaProperties(jpaProperties(publisher));
        return factory;
    }

    @Bean
    public DataSource dataSource() {
        DriverManagerDataSource dataSource = new DriverManagerDataSource();
        dataSource.setDriverClassName(environment.getRequiredProperty("datasource.driverClassName"));
        dataSource.setUrl(environment.getRequiredProperty("datasource.url"));
        dataSource.setUsername(environment.getProperty("datasource.username"));
        dataSource.setPassword(environment.getProperty("datasource.password"));
        return dataSource;
    }

    @Bean
    public PlatformTransactionManager transactionManager(ApplicationEventPublisher publisher) {
        EntityManagerFactory factory = entityManagerFactory(publisher).getObject();
        assert factory != null;
        return new JpaTransactionManager(factory);
    }

    @Bean
    public DataSourceInitializer dataSourceInitializer() {
        DataSourceInitializer dataSourceInitializer = new DataSourceInitializer();
        dataSourceInitializer.setDataSource(dataSource());
        ResourceDatabasePopulator databasePopulator = new ResourceDatabasePopulator();
        databasePopulator.addScript(new ClassPathResource("/migrations/V1_0_0__00000ALLSCHAUD.sql"));
        databasePopulator.addScript(new ClassPathResource("/migrations/V1_0_0__00100ALLSCHINT.sql"));
        dataSourceInitializer.setDatabasePopulator(databasePopulator);
        dataSourceInitializer.setEnabled(true);
        return dataSourceInitializer;
    }

    @Bean
    public Properties jpaProperties(ApplicationEventPublisher publisher) {
        Properties jpaProperties = new Properties();
        jpaProperties.put(AvailableSettings.DIALECT, environment.getRequiredProperty("datasource.dialect", String.class));
        jpaProperties.put(AvailableSettings.HBM2DDL_AUTO, environment.getProperty("datasource.ddl-auto", String.class, "none"));
        jpaProperties.put(AvailableSettings.SHOW_SQL, environment.getProperty("datasource.show_sql", Boolean.class, true));
        jpaProperties.put(AvailableSettings.GLOBALLY_QUOTED_IDENTIFIERS, environment.getProperty("datasource.quoted_identifiers", Boolean.class, false));
        jpaProperties.put(AvailableSettings.ENABLE_LAZY_LOAD_NO_TRANS, environment.getProperty("datasource.enable_lazy_load_no_trans", Boolean.class, true));
        jpaProperties.put(AvailableSettings.NON_CONTEXTUAL_LOB_CREATION, environment.getProperty("datasource.lob.non_contextual_creation", Boolean.class, false));
        jpaProperties.put(AvailableSettings.PHYSICAL_NAMING_STRATEGY, EntityNamingStrategy.class);
        jpaProperties.put(AvailableSettings.INTERCEPTOR, new EntityEventInterceptor(publisher, EmptyInterceptor.INSTANCE));
        return jpaProperties;
    }

    @Autowired
    public void appContext(ApplicationContext context) {
        ApplicationContainer.init(context);
    }

    @Autowired
    public void httpServletRequest() {
        MockHttpServletRequest request = new MockHttpServletRequest();
        request.addHeader("User-Agent", "Command Line");
        RequestContextHolder.setRequestAttributes(new ServletRequestAttributes(request));
    }

    @Bean
    public CacheManager cacheManager() {
        return new NoOpCacheManager();
    }

}
