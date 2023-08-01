/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.vedagram.payment;

import java.util.List;

import org.springframework.stereotype.Component;

import com.mongodb.client.result.UpdateResult;
import com.vedagram.domainmodel.UserModel;
import com.vedagram.user.DonationOrders;
import com.vedagram.user.GrammercePurchaseDto;
import com.vedagram.user.MaterialPurchaseDto;
import com.vedagram.user.MultiPurchaseDetails;
import com.vedagram.user.ProjectDonation;
import com.vedagram.user.VedaCart;
import com.vedagram.user.VedaCartDto;


@Component
public interface IPaymentService {


	boolean isPaymentSuccess(String orderId, String paymentId, String signature);

	UserPurchaseModelForPay updateUserPurchaseModelForPay(String orderId, String string);

	UserPurchaseDetail saveUserPurchaseDetail(String string, String orderId, String paymentId, String resOrderId, String signature,
			String poojaOfferingOrderId, String multiReqId,UserModel user, boolean b);

	
	PaymentInitResDto createCartPayRef(String userId);

	PaymentInitResDto createCartPayRefForPoojaMaterials(MaterialPurchaseDto materialPurchaseDto);

	PaymentInitResDto createCartPayRefForGrammerce(GrammercePurchaseDto grammercePurchaseDtoDto);

	PaymentInitResDto createCartPayRefForDonation(DonationOrders donationOrders);

	PaymentInitResDto createCartPayRefForProjectDonation(ProjectDonation projectDonation);

	PaymentInitResDto payInitOffering(VedaCartDto vedaCartDto, String userId);

	List<UserPurchaseModelForPay> updateUserPurchaseModelForPay1(String orderId, String paymentStatus);

	
}
