package com.vedagram.projectadm;

import java.util.List;

import org.springframework.data.mongodb.repository.MongoRepository;

public interface ProjectRepository extends MongoRepository<ProjectModel,String> {

	ProjectModel findByProjectTitle(String projectTitle);

	List<ProjectModel> findByCreatedById(String userId);

	ProjectModel findByProjectTitleAndIdNot(String projectTitle, String id);

	List<ProjectModel> findByAdminCreatedId(String userId);

}
