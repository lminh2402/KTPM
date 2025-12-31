package com.bluemoon.fees.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.event.ContextRefreshedEvent;
import org.springframework.context.event.EventListener;

import lombok.extern.slf4j.Slf4j;

@Configuration
@Slf4j
public class DataSourceConfig {

    @Value("${spring.datasource.url}")
    private String datasourceUrl;

    @Value("${jwt.secret}")
    private String jwtSecret;

    @EventListener
    public void handleContextRefreshed(ContextRefreshedEvent event) {
        log.info("=== DATASOURCE CONFIGURATION DEBUG ===");
        log.info("Datasource URL: {}", datasourceUrl);
        log.info("JWT Secret length: {}", jwtSecret != null ? jwtSecret.length() : "null");
        log.info("=== END DATASOURCE DEBUG ===");
    }
}
