package com.vedagram.support.util;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

public class PasswordUtil {
	private static final BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();

	/**
	 * Encode the given password
	 * 
	 */
	public static String encode(String rawPassword) {
		return passwordEncoder.encode(rawPassword);
	}

	/**
	 * Check whether the raw password matches the encoded password
	 * 
	 */
	public static boolean matches(String rawPassword, String encodedPassword) {
		return passwordEncoder.matches(rawPassword, encodedPassword);
	}

	public static void main(String args[]) {
		System.out.println(PasswordUtil.encode("admin"));
		System.out.println(PasswordUtil.encode("user"));
	}
}
