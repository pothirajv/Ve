package com.vedagram;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.stereotype.Repository;

/**
 * Main class of application<br>
 *
 * Spring Boot tries to guess the location of your {@link Repository}, based on
 * the {@link EnableAutoConfiguration} annotation it finds. So we have to place
 * {@link EnableJpaRepositories} annotation below {@link SpringBootApplication}
 * annotation
 *
 *
 */
@SpringBootApplication
@EnableCaching
@EnableAutoConfiguration
@EnableScheduling
public class Application extends SpringBootServletInitializer {

    @Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder builder) {
        return builder.sources(Application.class);
    }

    public static void main(String args[]) {
        SpringApplication.run(Application.class, args);
    }

}
