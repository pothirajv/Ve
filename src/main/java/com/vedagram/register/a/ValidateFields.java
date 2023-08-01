
package com.vedagram.register.a;
import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

import javax.validation.Constraint;
import javax.validation.Payload;

@Documented
@Constraint(validatedBy = FieldValidator.class)
@Target({ ElementType.TYPE})
@Retention(RetentionPolicy.RUNTIME)
//Constraint(validatedBy = { FieldValidator.class })

public  @interface  ValidateFields {
	String message() default "{ValidateFields}";

    Class<?>[] groups() default {};

    Class<? extends Payload>[] payload() default {};
	
}
