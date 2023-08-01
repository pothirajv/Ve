package com.vedagram.projectadm;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.data.mongodb.core.FindAndModifyOptions;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.stereotype.Service;

import com.vedagram.domainmodel.UserModel;
import com.vedagram.support.constant.GeneralConstants;
import com.vedagram.support.util.Utility;
import com.vedagram.user.PoojaMaterialOrders;
import com.vedagram.user.ProjectDonation;
import com.vedagram.user.ProjectDonationRepository;
import com.vedagram.vendor.PoojaMaterial;

@Service
public class ProjectServiceImpl implements ProjectService {
	@Autowired
	ProjectRepository projectRepository;
	@Autowired
	MongoTemplate mongoTemplate;
	@Autowired
	ProjectDonationRepository projectDonationRepository;
	@Autowired
	Utility utility;

	@Override
	public String addNewProject(ProjectModelDto projectModelDto) {
		ProjectModel model = projectRepository.findByProjectTitle(projectModelDto.getProjectTitle());
		if (model != null) {
			return "Project Title Already Exist";
		}
		UserModel userModel = new UserModel();
		ProjectModel projectModel = new ProjectModel();
		if(utility.getUserRole().equals(GeneralConstants.ROLE_ADMIN)) {
			if(projectModelDto.getProjectAdminId()==null || projectModelDto.getProjectAdminId().isEmpty()) {
				return "ProjectAdmin not available!";
			}
			userModel.setId(projectModelDto.getProjectAdminId());
			projectModel.setAdminCreatedId(utility.getUserId());
		}
		else {
		userModel.setId(utility.getUserId());
		}

		projectModel.setStartDate(projectModelDto.getStartDate());
		projectModel.setEndDate(projectModelDto.getEndDate());
		projectModel.setProjectStatus(GeneralConstants.PROJECT_STATUS_PENDING);
		projectModel.setCreatedBy(userModel);
		projectModel.setPurpose(projectModelDto.getPurpose());
		projectModel.setCreatedDate(new Date());
		projectModel.setTargetAmount(projectModelDto.getTargetAmount());
		projectModel.setProjectTitle(projectModelDto.getProjectTitle());
		projectModel.setMinAmountDonate(projectModelDto.getMinAmountDonate());
		projectModel.setMaxAmountDonate(projectModelDto.getMaxAmountDonate());
		mongoTemplate.insert(projectModel);
		return "SUCCESS";
	}

	@Override
	public List<ProjectModelDto> showAllProjects(String projAdmId) throws Exception {
		List<ProjectModel> projectModelLList = new ArrayList<>();
		if(utility.getUserRole().equals(GeneralConstants.ROLE_ADMIN)) {
			if(projAdmId==null || projAdmId.isEmpty()) {
	        	throw new Exception("ProjectAdminId Required");
	        }
			 projectModelLList = projectRepository.findByCreatedById(projAdmId);
		}
		else {
			 projectModelLList = projectRepository.findByCreatedById(utility.getUserId());
		}
		List<ProjectModelDto> projectModelDtoList = new ArrayList<ProjectModelDto>();
		
		for (ProjectModel projectModel : projectModelLList) {
			Integer totalAmountDonated=0;
			long diffDays=0; 
			Date now = new Date();
			Date endDate=projectModel.getEndDate();
			 LocalDate from = now.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
		     LocalDate to = endDate.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
		        
		        // Calculate the day difference
		        diffDays = ChronoUnit.DAYS.between(from, to);
		
				ProjectModelDto projectModelDto = new ProjectModelDto();
				projectModelDto.setId(projectModel.getId());
				projectModelDto.setProjectTitle(projectModel.getProjectTitle());
				projectModelDto.setProjectStatus(projectModel.getProjectStatus());
				projectModelDto.setPurpose(projectModel.getPurpose());
				projectModelDto.setTargetAmount(projectModel.getTargetAmount());
				projectModelDto.setStartDate(projectModel.getStartDate());
				projectModelDto.setEndDate(projectModel.getEndDate());
				projectModelDto.setNoOfDaysLeft(diffDays);
				projectModelDto.setMinAmountDonate(projectModel.getMinAmountDonate());
				projectModelDto.setMaxAmountDonate(projectModel.getMaxAmountDonate());
				projectModelDto.setActiveComment(projectModel.getActiveComment());
				projectModelDto.setInactiveComment(projectModel.getInactiveComment());
			
			Query donationQuery =new Query(Criteria.where("projectModel").in(projectModel.getId()));
			List<ProjectDonation> projectDonation = mongoTemplate.find(donationQuery, ProjectDonation.class);
			projectModelDto.setTotalSupporters(projectDonation.size());
			for(ProjectDonation donation:projectDonation) {
				totalAmountDonated+=donation.getContributionAmount();
				projectModelDto.setTotalAmountCollected(totalAmountDonated);
			}
				
				projectModelDtoList.add(projectModelDto);
			

		}
		return projectModelDtoList;
	}

	@Override
	public ProjectModelDto viewProjectInfo(String projectId) {

		Query projectQuery = new Query(Criteria.where("_id").is(projectId));
		ProjectModel projectModel = mongoTemplate.findOne(projectQuery, ProjectModel.class);
		long diff = projectModel.getEndDate().getTime() - (new Date().getTime());
		long diffDays = diff / (24 * 60 * 60 * 1000);
		ProjectModelDto projectModelDto = new ProjectModelDto();
		projectModelDto.setId(projectModel.getId());
		projectModelDto.setProjectTitle(projectModel.getProjectTitle());
		projectModelDto.setProjectStatus(projectModel.getProjectStatus());
		projectModelDto.setPurpose(projectModel.getPurpose());
		projectModelDto.setTargetAmount(projectModel.getTargetAmount());
		projectModelDto.setStartDate(projectModel.getStartDate());
		projectModelDto.setEndDate(projectModel.getEndDate());
		projectModelDto.setNoOfDaysLeft(diffDays);
		projectModelDto.setMinAmountDonate(projectModel.getMinAmountDonate());
		projectModelDto.setMaxAmountDonate(projectModel.getMaxAmountDonate());
		projectModelDto.setActiveComment(projectModel.getActiveComment());
		projectModelDto.setInactiveComment(projectModel.getInactiveComment());
		return projectModelDto;
	}

	@Override
	public String updateProject(ProjectModelDto projectModelDto) {
		Query projectQuery = new Query(Criteria.where("_id").is(projectModelDto.getId()));
		ProjectModel projectModel = mongoTemplate.findOne(projectQuery, ProjectModel.class);

		if (projectModel != null) {
			ProjectModel otherProjectModel = projectRepository
					.findByProjectTitleAndIdNot(projectModelDto.getProjectTitle(), projectModelDto.getId());
			if (otherProjectModel != null) {
				return "ERROR:Project Title Already Exist";
			}
			Update update = new Update();
			update.set("projectTitle", projectModelDto.getProjectTitle());
			update.set("purpose", projectModelDto.getPurpose());
			update.set("targetAmount", projectModelDto.getTargetAmount());
			update.set("startDate", projectModelDto.getStartDate());
			update.set("endDate", projectModelDto.getEndDate());
			update.set("minAmountDonate", projectModelDto.getMinAmountDonate());
			update.set("maxAmountDonate", projectModelDto.getMaxAmountDonate());

			mongoTemplate.findAndModify(projectQuery, update, new FindAndModifyOptions().returnNew(true),
					ProjectModel.class);

			return "SUCCESS";
		}
		return "ERROR:Invalid data";
	}

	@Override
	public List<ProjectModelDto> showAllProjectsForAdmin() {
		List<ProjectModel> projectModelLList = projectRepository.findAll();
		List<ProjectModelDto> projectModelDtoList = new ArrayList<ProjectModelDto>();
		
		for (ProjectModel projectModel : projectModelLList) {
			Integer totalAmountDonated=0;
			long diff = projectModel.getEndDate().getTime() - (new Date().getTime());
			long diffDays = diff / (24 * 60 * 60 * 1000);
			ProjectModelDto projectModelDto = new ProjectModelDto();
			projectModelDto.setId(projectModel.getId());
			projectModelDto.setProjectTitle(projectModel.getProjectTitle());
			projectModelDto.setProjectStatus(projectModel.getProjectStatus());
			projectModelDto.setPurpose(projectModel.getPurpose());
			projectModelDto.setTargetAmount(projectModel.getTargetAmount());
			projectModelDto.setStartDate(projectModel.getStartDate());
			projectModelDto.setEndDate(projectModel.getEndDate());
			projectModelDto.setNoOfDaysLeft(diffDays);
			projectModelDto.setMinAmountDonate(projectModel.getMinAmountDonate());
			projectModelDto.setMaxAmountDonate(projectModel.getMaxAmountDonate());
			projectModelDto.setCreatedBy(projectModel.getCreatedBy());
			projectModelDto.setActiveComment(projectModel.getActiveComment());
			projectModelDto.setInactiveComment(projectModel.getInactiveComment());
			
		
		Query donationQuery =new Query(Criteria.where("projectModel").in(projectModel.getId()));
		List<ProjectDonation> projectDonation = mongoTemplate.find(donationQuery, ProjectDonation.class);
		projectModelDto.setTotalSupporters(projectDonation.size());
		for(ProjectDonation donation:projectDonation) {
			totalAmountDonated+=donation.getContributionAmount();
			projectModelDto.setTotalAmountCollected(totalAmountDonated);
		}
			projectModelDtoList.add(projectModelDto);
			
		}

		return projectModelDtoList;
		
	}

	@Override
	public String setProjectStatus(String projectId, String projectStatus,String comment) {
		Query projectQuery = new Query(Criteria.where("_id").is(projectId));
		ProjectModel projectModel = mongoTemplate.findOne(projectQuery, ProjectModel.class);

		if (projectModel != null) {

			Update update = new Update();

			update.set("projectStatus", projectStatus);
			if(projectStatus.equals("STATUS_ACTIVE")) {
				Date now = new Date();
				LocalDate currentDate = now.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
			    LocalDate endDate = projectModel.getEndDate().toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
				
			    if(endDate.isBefore(currentDate)) {
					return "Change the project EndDate";
				}
			    else {
			     update.set("activeComment",comment);
			    }
			}
			else {
				update.set("inactiveComment",comment);
			}

			mongoTemplate.findAndModify(projectQuery, update, new FindAndModifyOptions().returnNew(true),
					ProjectModel.class);
		}
		return projectStatus;

	}

	@Override
	public List<ProjectModelDto> showAllProjectsForUser() {
		List<ProjectModel> projectModelLList = projectRepository.findAll();
		List<ProjectModelDto> projectModelDtoList = new ArrayList<ProjectModelDto>();
       
		for (ProjectModel projectModel : projectModelLList) {

			if (projectModel.getProjectStatus().equals(GeneralConstants.PROJECT_STATUS_ACTIVE)) {
				long diffDays=0; 
				Date now = new Date();
				Date endDate=projectModel.getEndDate();
				 LocalDate from = now.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
			     LocalDate to = endDate.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
			        
			        // Calculate the day difference
			     diffDays = ChronoUnit.DAYS.between(from, to);
			     
				 Integer totalAmountDonated = 0;
				 
				if (diffDays >= 0) {
					
					ProjectModelDto projectModelDto = new ProjectModelDto();
					projectModelDto.setId(projectModel.getId());
					projectModelDto.setProjectTitle(projectModel.getProjectTitle());
					projectModelDto.setProjectStatus(projectModel.getProjectStatus());
					projectModelDto.setPurpose(projectModel.getPurpose());
					projectModelDto.setTargetAmount(projectModel.getTargetAmount());
					projectModelDto.setStartDate(projectModel.getStartDate());
					projectModelDto.setEndDate(projectModel.getEndDate());
					projectModelDto.setNoOfDaysLeft(diffDays);
					projectModelDto.setMinAmountDonate(projectModel.getMinAmountDonate());
					projectModelDto.setMaxAmountDonate(projectModel.getMaxAmountDonate());
							
					Query donationQuery =new Query(Criteria.where("projectModel").in(projectModel.getId()));
					List<ProjectDonation> projectDonation = mongoTemplate.find(donationQuery, ProjectDonation.class);
					projectModelDto.setTotalSupporters(projectDonation.size());
					for(ProjectDonation donation:projectDonation) {
						totalAmountDonated+=donation.getContributionAmount();
						projectModelDto.setTotalAmountCollected(totalAmountDonated);
					}
					
					
					//projectModelDto.setTotalSupporters(totalSupporters);
					projectModelDtoList.add(projectModelDto);

				}
			}
		}

		return projectModelDtoList;

	}

	@Override
	public List<ProjectDonation> getAllProjectDonations(String projAdmId) throws Exception {
		List<ProjectModel> projectList=new ArrayList<>();
		if(utility.getUserRole().equals(GeneralConstants.ROLE_ADMIN)) {
			if(projAdmId==null || projAdmId.isEmpty()) {
	        	throw new Exception("ProjectAdminId Required");
	        }
			 projectList =projectRepository.findByCreatedById(projAdmId);
		}
		else {
			projectList =projectRepository.findByCreatedById(utility.getUserId());
		}
		List<String> projectIds=new ArrayList<String>();
		for(ProjectModel projectModel: projectList)
		{
			projectIds.add(projectModel.getId());
		}
		Query query =new Query(Criteria.where("projectModel").in(projectIds));
		query.with(new Sort(Sort.Direction.DESC, "donationDate"));
		List<ProjectDonation> donationList=mongoTemplate.find(query,ProjectDonation.class);
		return donationList;
	}

	@Override
	public void changeProjectStatus() {
		Date now = new Date();
		 LocalDate currentDate = now.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
	     
		List<ProjectModel> projectModels = projectRepository.findAll();
		for(ProjectModel projectModel:projectModels) {
			LocalDate endDate = projectModel.getEndDate().toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
			if(endDate.isBefore(currentDate)) {
				Update update = new Update();
				update.set("projectStatus",GeneralConstants.PROJECT_STATUS_PENDING);
				mongoTemplate.findAndModify(new Query(Criteria.where("id").is(projectModel.getId())), update, ProjectModel.class);
			}
			
		}
	}
}