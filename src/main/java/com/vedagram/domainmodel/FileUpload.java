/**
 * 
 */
package com.vedagram.domainmodel;

import org.springframework.web.multipart.MultipartFile;


public class FileUpload {

	private MultipartFile file;

	/**
	 * @return the file
	 */
	public MultipartFile getFile() {
		return file;
	}

	/**
	 * @param file
	 *            the file to set
	 */
	public void setFile(MultipartFile file) {
		this.file = file;
	}

}
