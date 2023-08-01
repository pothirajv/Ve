package com.vedagram.admin.adm;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.vedagram.support.constant.GeneralConstants;

@Controller
@RequestMapping(path = "/")
public class DefaultController {

	@RequestMapping(path = { "", "/home", "/index" })
	public ModelAndView home(HttpServletRequest request) {
		ModelAndView modelAndView = new ModelAndView("home");
		if (request.getSession().getAttribute("LoggedIn") != null
				&& request.getSession().getAttribute("LoggedIn").equals("TRUE")) {
			if (request.getSession().getAttribute("Role") != null) {
				if (request.getSession().getAttribute("Role").equals(GeneralConstants.ROLE_ADMIN)) {
					modelAndView = new ModelAndView("redirect:/adm/home");
				} else if (request.getSession().getAttribute("Role").equals(GeneralConstants.ROLE_VENDOR)) {
					modelAndView = new ModelAndView("redirect:/v/vDashboard");
				} else if (request.getSession().getAttribute("Role").equals(GeneralConstants.ROLE_DELIVER)) {
					modelAndView = new ModelAndView("home");
				} else if (request.getSession().getAttribute("Role").equals(GeneralConstants.ROLE_USER)) {
					modelAndView = new ModelAndView("home");
				} else {
					modelAndView = new ModelAndView("home");
				}
			}
		}
		return modelAndView;
	}

	@RequestMapping(path = { "/about" })
	public ModelAndView about() {
		ModelAndView modelAndView = new ModelAndView("about");
		return modelAndView;
	}

	@RequestMapping(path = { "/contact" })
	public ModelAndView contact() {
		ModelAndView modelAndView = new ModelAndView("contact");
		return modelAndView;
	}

	@RequestMapping(path = { "/apisup" })
	public ModelAndView apisup() {
		ModelAndView modelAndView = new ModelAndView("apisup");
		return modelAndView;
	}

	// Chari: Added for AWB Tracking Page
	@RequestMapping(path = { "/awbtrack" })
	public ModelAndView awbtrack() {
		ModelAndView modelAndView = new ModelAndView("awbtrack");
		return modelAndView;
	}

	@RequestMapping(path = { "/partners" })
	public ModelAndView partners() {
		ModelAndView modelAndView = new ModelAndView("partners");
		return modelAndView;
	}

	@RequestMapping(path = { "/privacypolicy" })
	public ModelAndView privacypolicy() {
		ModelAndView modelAndView = new ModelAndView("privacypolicy");
		return modelAndView;
	}

	@RequestMapping(path = { "/tnc" })
	public ModelAndView tnc() {
		ModelAndView modelAndView = new ModelAndView("tnc");
		return modelAndView;
	}

	@RequestMapping(path = { "/services" })
	public ModelAndView services() {
		ModelAndView modelAndView = new ModelAndView("services");
		return modelAndView;
	}

	@RequestMapping(path = { "/tracklist" })
	public ModelAndView tracklist() {
		ModelAndView modelAndView = new ModelAndView("tracklist");
		return modelAndView;
	}

	// Chari:Added for Package management
	@RequestMapping(path = { "/packagemgmt" })
	public ModelAndView packagemgmt() {
		ModelAndView modelAndView = new ModelAndView("packagemgmt");
		return modelAndView;
	}

	@RequestMapping(path = { "/senderrequest" })
	public ModelAndView senderrequest() {
		ModelAndView modelAndView = new ModelAndView("senderrequest");
		return modelAndView;
	}

	@RequestMapping(path = { "/register" })
	public ModelAndView register(Model model) {
		ModelAndView modelAndView = new ModelAndView("register");
		return modelAndView;
	}

	@RequestMapping(path = { "/faq" })
	public ModelAndView faq() {
		ModelAndView modelAndView = new ModelAndView("faq");
		return modelAndView;
	}

	@RequestMapping(path = { "/login" })
	public ModelAndView login() {
		ModelAndView modelAndView = new ModelAndView("login");
		return modelAndView;
	}
}