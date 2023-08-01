/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.vedagram.support.util;

import java.lang.reflect.Method;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.aop.interceptor.AsyncUncaughtExceptionHandler;

/**
 *
 * @author vijay
 */
public class AsyncExceptionHandler implements AsyncUncaughtExceptionHandler {

    private static final Logger LOGGER = LoggerFactory.getLogger(AsyncExceptionHandler.class);

    @Override
    public void handleUncaughtException(Throwable thrwbl, Method method, Object... os) {
        thrwbl.printStackTrace();
        LOGGER.error("Exception Cause - " + thrwbl.getMessage());
        LOGGER.error("Method name - " + method.getName());
        for (Object param : os) {
            LOGGER.error("Parameter value - " + param);
        }
    }
}
