package com.vedagram.projectadm;

import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.http.ResponseEntity;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.vedagram.register.a.RegisterResponse;
import com.vedagram.user.ProjectDonation;

@Controller
@RequestMapping(path = "/projectadm/")
public class ProjectadmController {

	@Autowired
	ProjectService projectService;

	@RequestMapping(path = "addNewProject", method = RequestMethod.POST)
	public ResponseEntity<RegisterResponse> addNewProject(@RequestBody @Valid ProjectModelDto projectModelDto,
			BindingResult result) {
		RegisterResponse registerResponse = new RegisterResponse();
		if (result.hasFieldErrors("projectTitle")) {
			String trt = result.getFieldError().getDefaultMessage();
			registerResponse.setResponseText(trt);
			return ResponseEntity.ok(registerResponse);
		} else if (result.hasFieldErrors("purpose")) {
			String trt = result.getFieldError().getDefaultMessage();
			registerResponse.setResponseText(trt);
			return ResponseEntity.ok(registerResponse);
		} else if (result.hasFieldErrors("targetAmount")) {
			String trt = result.getFieldError().getDefaultMessage();
			registerResponse.setResponseText(trt);
			return ResponseEntity.ok(registerResponse);
		} else if (result.hasFieldErrors("startDate")) {
			String trt = result.getFieldError().getDefaultMessage();
			registerResponse.setResponseText(trt);
			return ResponseEntity.ok(registerResponse);
		} else if (result.hasFieldErrors("endDate")) {
			String trt = result.getFieldError().getDefaultMessage();
			registerResponse.setResponseText(trt);
			return ResponseEntity.ok(registerResponse);
		}
		String msg = projectService.addNewProject(projectModelDto);
		registerResponse.setResponseText(msg);
		return ResponseEntity.ok(registerResponse);

	}

	@RequestMapping(path = "showAllProjects", method = RequestMethod.GET)
	@ResponseBody
	public List<ProjectModelDto> showAllProjects(@RequestParam("projAdmId") String projAdmId) throws Exception {

		return projectService.showAllProjects(projAdmId);

	}

	@RequestMapping(path = "viewProjectInfo", method = RequestMethod.GET)
	@ResponseBody
	public ProjectModelDto viewProjectInfo(@RequestParam("projectId") String projectId) {
		return projectService.viewProjectInfo(projectId);
	}

	@RequestMapping(path = "updateProject", method = RequestMethod.POST)
	public ResponseEntity<RegisterResponse> updateProject(@RequestBody @Valid ProjectModelDto projectModelDto,
			BindingResult result) {
		RegisterResponse registerResponse = new RegisterResponse();
		if (result.hasFieldErrors("projectTitle")) {
			String trt = result.getFieldError().getDefaultMessage();
			registerResponse.setResponseText(trt);
			return ResponseEntity.ok(registerResponse);
		} else if (result.hasFieldErrors("purpose")) {
			String trt = result.getFieldError().getDefaultMessage();
			registerResponse.setResponseText(trt);
			return ResponseEntity.ok(registerResponse);
		} else if (result.hasFieldErrors("targetAmount")) {
			String trt = result.getFieldError().getDefaultMessage();
			registerResponse.setResponseText(trt);
			return ResponseEntity.ok(registerResponse);
		} else if (result.hasFieldErrors("startDate")) {
			String trt = result.getFieldError().getDefaultMessage();
			registerResponse.setResponseText(trt);
			return ResponseEntity.ok(registerResponse);
		} else if (result.hasFieldErrors("endDate")) {
			String trt = result.getFieldError().getDefaultMessage();
			registerResponse.setResponseText(trt);
			return ResponseEntity.ok(registerResponse);
		}
		String msg = projectService.updateProject(projectModelDto);
		registerResponse.setResponseText(msg);
		return ResponseEntity.ok(registerResponse);

	}
	@RequestMapping(path="setProjectStatus",method=RequestMethod.GET)
	@ResponseBody
	public String setProjectStatus(@RequestParam("projectId") String projectId,@RequestParam("projectStatus")String projectStatus,@RequestParam("comment")String comment) {
		return projectService.setProjectStatus(projectId,projectStatus,comment);
		
	}
	@RequestMapping(path="showAllProjectDonations",method=RequestMethod.POST)
	@ResponseBody
	public List<ProjectDonation> getAllProjectDonations(@RequestParam("projAdmId") String projAdmId) throws Exception {
		return projectService.getAllProjectDonations(projAdmId);
		
	}
	@Scheduled(cron = "00 00 00 * * *")
	public void changeProjectStatus() {
		projectService.changeProjectStatus();
		
	}

}
