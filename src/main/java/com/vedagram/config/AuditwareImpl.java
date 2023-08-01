package com.vedagram.config;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.AuditorAware;

import com.vedagram.support.util.Utility;

/**
 *
 * @author Winston
 */
public class AuditwareImpl implements AuditorAware<String>{
    
    @Autowired
    Utility utility;

    @Override
    public Optional<String> getCurrentAuditor() {
  
    return Optional.ofNullable(utility.getUserId());
    }
    

}
