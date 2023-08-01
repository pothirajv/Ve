package com.vedagram.deity;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.data.mongodb.core.FindAndModifyOptions;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.vedagram.domainmodel.UserModel;
import com.vedagram.repository.DeityRepository;
import com.vedagram.support.constant.GeneralConstants;
import com.vedagram.support.util.Utility;

@Service
public class DeityServiceImpl implements DeityService {
	@Autowired
	private DeityRepository dietyRepository;
	@Autowired
	MongoTemplate mongoTemplate;
	@Autowired
	Utility utility;

	@Autowired
	Environment env;

	public String saveDeity(Deity deity, MultipartFile img) throws IOException {
		String extUrl = env.getProperty("ext.app.img.dir");
		String deityUrl = extUrl + "/deity/";
		if (deity != null) {
			Deity deityModel = dietyRepository.findByDeityName(deity.getDeityName());
			if (deityModel == null) {
				deity.setActiveFlag(true);
				mongoTemplate.insert(deity);
				File newFolder = new File(deityUrl + deity.getId());
				if (!newFolder.exists()) {
					newFolder.mkdirs();
				}
				byte[] bytes = img.getBytes();
				Path path = Paths.get(newFolder + "/" + deity.getId() + ".jpg");
				Files.write(path, bytes);
				return "SUCCESS";
			} else {
				return "ERROR:Deity Name Already Exist";
			}

		}

		return "ERROR:Invalid data";

	}

	public String updateDeity(Deity deity, MultipartFile img) throws IOException {
		Deity deityModel = dietyRepository.findById(deity.getId());
		if (deityModel != null) {
			Deity otherDeityModel = dietyRepository.findByDeityNameAndIdNot(deity.getDeityName(), deity.getId());
			if (otherDeityModel != null) {
				return "ERROR:Deity Name Already Exist";
			}
			
			Query searchDeityQuery = new Query(Criteria.where("_id").is(deity.getId()));
			Update update = new Update();
			update.set("deityName", deity.getDeityName());
			update.set("deityDescription", deity.getDeityDescription());
			mongoTemplate.findAndModify(searchDeityQuery, update,
					new FindAndModifyOptions().returnNew(true), Deity.class);
			
			if(img != null && !img.isEmpty()) {
				String extUrl = env.getProperty("ext.app.img.dir");
				String deityUrl = extUrl + "/deity/";
				
				File newFolder = new File(deityUrl + deity.getId());
				byte[] bytes = img.getBytes();
				Path path = Paths.get(newFolder + "/" + deity.getId() + ".jpg");
				
				if (Files.exists(path)) {
					Files.delete(path);
				}
				
				if (!newFolder.exists()) {
					newFolder.mkdirs();
				}
				
				Files.write(path, bytes);
			}

			return "SUCCESS";
		}

		return "ERROR:Invalid data";

	}

	@Override
	public DeityDto showDeity(String deityId) throws IOException {

		Query q = new Query(Criteria.where("_id").is(deityId));
		Deity deity = mongoTemplate.findOne(q, Deity.class);

		DeityDto deityDto = new DeityDto();
		deityDto.setId(deity.getId());
		deityDto.setDeityName(deity.getDeityName());
		deityDto.setDeityDescription(deity.getDeityDescription());
		deityDto.setActiveFlag(deity.isActiveFlag());
		deityDto.setActiveComment(deity.getActiveComment());
		deityDto.setInactiveComment(deity.getInactiveComment());

		String extUrl = env.getProperty("ext.app.img.dir");
		String dietyUrl = extUrl + "/deity/" + deity.getId() + '/' + deity.getId() + ".jpg";

		File dietyImg = new File(dietyUrl);
		if (dietyImg.exists()) {
			String imgUrl = env.getProperty("app.img.dir") + "/deity/" + deity.getId() + "/" + deity.getId() + ".jpg";
			deityDto.setImage(imgUrl);
		}

		return deityDto;
	}

	public List<DeityDto> showAllDeity() throws IOException {

		List<Deity> deityList = mongoTemplate.findAll(Deity.class);
		List<DeityDto> deityDtoList = new ArrayList<DeityDto>();
		for (Deity deity : deityList) {
			if(utility.getUserRole().equals(GeneralConstants.ROLE_TEMPADMIN)) {
			if(deity.isActiveFlag()) {
			DeityDto deityDto = new DeityDto();
			deityDto.setId(deity.getId());
			deityDto.setDeityName(deity.getDeityName());
			deityDto.setDeityDescription(deity.getDeityDescription());
			deityDto.setActiveFlag(deity.isActiveFlag());
			deityDto.setActiveComment(deity.getActiveComment());
			deityDto.setInactiveComment(deity.getInactiveComment());
			
			String extUrl = env.getProperty("ext.app.img.dir");
			String dietyUrl = extUrl + "/deity/" + deity.getId() + '/' + deity.getId() + ".jpg";

			File dietyImg = new File(dietyUrl);
			if (dietyImg.exists()) {
				String imgUrl = env.getProperty("app.img.dir") + "/deity/" + deity.getId() + "/" + deity.getId()
						+ ".jpg";
				deityDto.setImage(imgUrl);
			} else {
				String imgUrl = env.getProperty("app.url") + "/images/noimage.png";
				deityDto.setImage(imgUrl);
			}
			deityDtoList.add(deityDto);
		}
			}
			else {
				DeityDto deityDto = new DeityDto();
				deityDto.setId(deity.getId());
				deityDto.setDeityName(deity.getDeityName());
				deityDto.setDeityDescription(deity.getDeityDescription());
				deityDto.setActiveFlag(deity.isActiveFlag());
				deityDto.setActiveComment(deity.getActiveComment());
				deityDto.setInactiveComment(deity.getInactiveComment());
				
				String extUrl = env.getProperty("ext.app.img.dir");
				String dietyUrl = extUrl + "/deity/" + deity.getId() + '/' + deity.getId() + ".jpg";

				File dietyImg = new File(dietyUrl);
				if (dietyImg.exists()) {
					String imgUrl = env.getProperty("app.img.dir") + "/deity/" + deity.getId() + "/" + deity.getId()
							+ ".jpg";
					deityDto.setImage(imgUrl);
				} else {
					String imgUrl = env.getProperty("app.url") + "/images/noimage.png";
					deityDto.setImage(imgUrl);
				}
				deityDtoList.add(deityDto);
			}
		}

		return deityDtoList;
	}

	public String actInactDeity(String deityId, String activeFlag) {
		Query query = new Query(Criteria.where("_id").is(deityId));
		Deity deity = mongoTemplate.findOne(query, Deity.class);
		if (deity != null) {
			Update update = new Update();
			update.set("activeFlag", activeFlag);
			deity = mongoTemplate.findAndModify(query, update, new FindAndModifyOptions().returnNew(true), Deity.class);

			return "Active";

		}

		return "Inactive";

	}

}
