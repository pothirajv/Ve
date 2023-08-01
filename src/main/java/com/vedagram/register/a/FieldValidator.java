
package com.vedagram.register.a;

import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;
import com.vedagram.register.a.ValidateFields;

import org.springframework.data.annotation.Id;

public class FieldValidator implements ConstraintValidator<ValidateFields, RegisterModel>{
	public void initialize(ValidateFields constraintAnnotation) {

    }

	@Override
	public boolean isValid(RegisterModel registerModel, ConstraintValidatorContext context) {
		// TODO Auto-generated method stub
		if(registerModel.getRoleId()==2 || registerModel.getRoleId()==4 ){
			 if(registerModel.getAadharNumber()==null ||  registerModel.getAadharNumber()=="")
			{
			context.disableDefaultConstraintViolation();
	        context
	            .buildConstraintViolationWithTemplate("Aadhar Number is mandatory!!")
	            .addConstraintViolation();
			return false;
			}
			
			else if(registerModel.getAddress()==null ||registerModel.getAddress()=="")
			{
			context.disableDefaultConstraintViolation();
	        context
	            .buildConstraintViolationWithTemplate("Address is mandatory!!")
	            .addConstraintViolation();
			return false;
			}
			
			else if( registerModel.getArea()==null ||registerModel.getArea()=="")
			{
				context.disableDefaultConstraintViolation();
		        context
		            .buildConstraintViolationWithTemplate("Area is mandatory!!")
		            .addConstraintViolation();
				return false;
			}
			else if( registerModel.getState()==null ||registerModel.getState()=="")
			{
				context.disableDefaultConstraintViolation();
		        context
		            .buildConstraintViolationWithTemplate("State is mandatory!!")
		            .addConstraintViolation();
				return false;
			}
			else if( registerModel.getCity()==null ||registerModel.getCity()=="" )
			{
				context.disableDefaultConstraintViolation();
		        context
		            .buildConstraintViolationWithTemplate("City is mandatory!!")
		            .addConstraintViolation();
				return false;
			}
			
			else if( registerModel.getCountry()==null || registerModel.getCountry()=="")
			{
				context.disableDefaultConstraintViolation();
		        context
		            .buildConstraintViolationWithTemplate("Country is mandatory!!")
		            .addConstraintViolation();
				return false;
			}
			else if( registerModel.getEmail()==null || registerModel.getEmail()=="")
			{
				context.disableDefaultConstraintViolation();
		        context
		            .buildConstraintViolationWithTemplate("EmailId is mandatory!!")
		            .addConstraintViolation();
				return false;
			}
			else if( registerModel.getFirstName()==null || registerModel.getFirstName()=="")
			{
				context.disableDefaultConstraintViolation();
		        context
		            .buildConstraintViolationWithTemplate("FirstName is mandatory!!")
		            .addConstraintViolation();
				return false;
			}
				
			else if( registerModel.getMobileNumber()==null || registerModel.getMobileNumber()=="")
			{
				context.disableDefaultConstraintViolation();
		        context
		            .buildConstraintViolationWithTemplate("Mobile Number is mandatory!!")
		            .addConstraintViolation();
				return false;
			}
			 
			else if( registerModel.getPassword()==null || registerModel.getPassword()=="")
			{
				context.disableDefaultConstraintViolation();
		        context
		            .buildConstraintViolationWithTemplate("Password is mandatory!!")
		            .addConstraintViolation();
				return false;
			}
			else if( registerModel.getState()==null || registerModel.getState()=="")
			{
				context.disableDefaultConstraintViolation();
		        context
		            .buildConstraintViolationWithTemplate("State is mandatory!!")
		            .addConstraintViolation();
				return false;
			}
				
				return true;
			
		}
		else if(registerModel.getRoleId()==3){

			 if(registerModel.getAadharNumber()==null ||  registerModel.getAadharNumber()=="")
			{
			context.disableDefaultConstraintViolation();
	        context
	            .buildConstraintViolationWithTemplate("Aadhar Number is mandatory!!")
	            .addConstraintViolation();
			return false;
			}
			
			else if(registerModel.getAddress()==null ||registerModel.getAddress()=="")
			{
			context.disableDefaultConstraintViolation();
	        context
	            .buildConstraintViolationWithTemplate("Address is mandatory!!")
	            .addConstraintViolation();
			return false;
			}
			
			else if( registerModel.getArea()==null ||registerModel.getArea()=="")
			{
				context.disableDefaultConstraintViolation();
		        context
		            .buildConstraintViolationWithTemplate("Area is mandatory!!")
		            .addConstraintViolation();
				return false;
			}
			else if( registerModel.getState()==null ||registerModel.getState()=="")
			{
				context.disableDefaultConstraintViolation();
		        context
		            .buildConstraintViolationWithTemplate("State is mandatory!!")
		            .addConstraintViolation();
				return false;
			}
			else if( registerModel.getCity()==null ||registerModel.getCity()=="" )
			{
				context.disableDefaultConstraintViolation();
		        context
		            .buildConstraintViolationWithTemplate("City is mandatory!!")
		            .addConstraintViolation();
				return false;
			}
			
			else if( registerModel.getCountry()==null || registerModel.getCountry()=="")
			{
				context.disableDefaultConstraintViolation();
		        context
		            .buildConstraintViolationWithTemplate("Country is mandatory!!")
		            .addConstraintViolation();
				return false;
			}
			else if( registerModel.getEmail()==null || registerModel.getEmail()=="")
			{
				context.disableDefaultConstraintViolation();
		        context
		            .buildConstraintViolationWithTemplate("EmailId is mandatory!!")
		            .addConstraintViolation();
				return false;
			}
			else if( registerModel.getFirstName()==null || registerModel.getFirstName()=="")
			{
				context.disableDefaultConstraintViolation();
		        context
		            .buildConstraintViolationWithTemplate("FirstName is mandatory!!")
		            .addConstraintViolation();
				return false;
			}
				
			else if( registerModel.getMobileNumber()==null || registerModel.getMobileNumber()=="")
			{
				context.disableDefaultConstraintViolation();
		        context
		            .buildConstraintViolationWithTemplate("Mobile Number is mandatory!!")
		            .addConstraintViolation();
				return false;
			}
			 
			else if(( registerModel.getPassword()==null || registerModel.getPassword()=="") && (registerModel.getId()!=null ||registerModel.getId()!=""))
			{
				context.disableDefaultConstraintViolation();
		        context
		            .buildConstraintViolationWithTemplate("Password is mandatory!!")
		            .addConstraintViolation();
				return false;
			}
			else if( registerModel.getState()==null || registerModel.getState()=="")
			{
				context.disableDefaultConstraintViolation();
		        context
		            .buildConstraintViolationWithTemplate("State is mandatory!!")
		            .addConstraintViolation();
				return false;
			}
			else if( registerModel.getVendorName()==null || registerModel.getVendorName()=="")
			{
				context.disableDefaultConstraintViolation();
		        context
		            .buildConstraintViolationWithTemplate("Vendor Name is mandatory!!")
		            .addConstraintViolation();
				return false;
			}
			else if( registerModel.getProductType()==null || registerModel.getProductType()=="")
			{
				context.disableDefaultConstraintViolation();
		        context
		            .buildConstraintViolationWithTemplate("Product Type is mandatory!!")
		            .addConstraintViolation();
				return false;
			}
				
				return true;
			
		
		}
		return true;
	}
	
}
