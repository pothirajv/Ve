package com.vedagram.projectadm;

import java.util.List;

import org.springframework.stereotype.Service;

import com.vedagram.user.ProjectDonation;

@Service
public interface ProjectService {
	String addNewProject(ProjectModelDto projectModelDto);
	List<ProjectModelDto> showAllProjects(String projAdmId) throws Exception;
	String updateProject(ProjectModelDto projectModelDto);
	ProjectModelDto viewProjectInfo(String projectId);
	List<ProjectModelDto> showAllProjectsForAdmin();
	String setProjectStatus(String projectId,String projectStatus, String comment);
	List<ProjectModelDto> showAllProjectsForUser();
	List<ProjectDonation> getAllProjectDonations(String projAdmId) throws Exception;
	void changeProjectStatus();

}
