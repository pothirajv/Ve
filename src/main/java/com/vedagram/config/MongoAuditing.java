/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.vedagram.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.domain.AuditorAware;
import org.springframework.data.mongodb.config.EnableMongoAuditing;

/**
 *
 * @author Winston
 */
@Configuration
@EnableMongoAuditing
public class MongoAuditing {

    @Bean
    public AuditorAware<String> myAuditorProvider() {
        return new AuditwareImpl();
    }

}
