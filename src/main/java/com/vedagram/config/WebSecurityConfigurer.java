package com.vedagram.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.web.authentication.www.BasicAuthenticationFilter;

import com.vedagram.repository.UserRepository;
import com.vedagram.support.constant.GeneralConstants;

/**
 * <b>Security configurations</b><br>
 *
 * You can configure your application security features by this class when .yml
 * file configurations can not meet your requirements.
 *
 */
@Configuration
public class WebSecurityConfigurer extends WebSecurityConfigurerAdapter {

    @Autowired
    private UserRepository userRepository;

    @Override
	public void configure(WebSecurity web) throws Exception {
		web.ignoring().antMatchers("/pdresources/**").antMatchers("/resources/**").antMatchers("/css/**").antMatchers("/images/**")
				.antMatchers("/js/**").antMatchers("/vedaresources/**").antMatchers("/assets/**").antMatchers("/static/**");
	}

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http.cors().and().csrf().disable().authorizeRequests()
                .antMatchers("/a/sendotp", "/a/login", "/a/c", "/a/cc", "/a/r", "/a/rs","/a/d","/a/u","/", "/index", "/**/css/**", "/**/js/**", "/**/images/**", "/**/*.html/", "/pay/**", "/index", "/about", "/contact", "/partners", "/apisup","/awbtrack", "/privacypolicy","/tnc", "/services", "/f/appv","/tracklist","/a/q","/a/q1","/a/t","/register","/user/loginValidate","/user/loginValidate1","/user/update","/faq","/login","/adm/getRate","/user/register","/user/myProfile","/adm/showAllUsers","/u/**","/user/**", "/u/showAllDeity", "/u/showDeityInfo", "/tempadm/viewTemple", "/tempadm/viewTemple/**","/adm/showAllDonations").permitAll()
                .antMatchers("/b/**","/c/**", "/d/**", "/e/**","/api/v1/**","/o/**").hasAnyAuthority("",GeneralConstants.ROLE_USER, GeneralConstants.ROLE_ADMIN, GeneralConstants.ROLE_VENDOR, GeneralConstants.ROLE_DELIVER)
                .antMatchers("/f/**", "/adm/**","/pd/**").hasAuthority(GeneralConstants.ROLE_ADMIN)
                .antMatchers("/ven/**","/pd/**").hasAnyAuthority(GeneralConstants.ROLE_VENDOR,GeneralConstants.ROLE_ADMIN)
                .antMatchers("/projectadm/**").hasAnyAuthority(GeneralConstants.ROLE_PROJECTADMIN,GeneralConstants.ROLE_ADMIN)

                .antMatchers("/tempadm/**","/pd/**").hasAnyAuthority(GeneralConstants.ROLE_TEMPADMIN,GeneralConstants.ROLE_ADMIN)
                .antMatchers("/v/**").hasAnyAuthority(GeneralConstants.ROLE_VENDOR, GeneralConstants.ROLE_ADMIN)
                .anyRequest().authenticated()
                .and()
                .addFilterBefore(new JwtAuthenticationFilter(authenticationManager(), userRepository), BasicAuthenticationFilter.class)
                .exceptionHandling().authenticationEntryPoint(new UnauthenticatedRequestHandler());
    }

    public UserRepository getUserRepository() {
        return userRepository;
    }

    public void setUserRepository(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

}
