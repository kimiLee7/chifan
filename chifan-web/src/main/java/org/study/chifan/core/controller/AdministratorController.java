package org.study.chifan.core.controller;

import com.google.common.collect.ImmutableMap;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.study.chifan.core.annotation.AdminRequired;
import org.study.chifan.core.entity.Administrator;
import org.study.chifan.core.entity.AvailabilityStatus;
import org.study.chifan.core.entity.Domain;
import org.study.chifan.core.entity.query.AdministratorQuery;
import org.study.chifan.core.model.PagedCollection;
import org.study.chifan.core.service.AdministratorService;
import org.study.chifan.core.service.DomainService;
import org.study.chifan.core.service.MailService;
import org.study.chifan.core.service.impl.MailServiceImpl;

import javax.mail.MessagingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.ConstraintViolation;
import java.util.*;

//import javax.validation.Validator;

@Controller
@RequestMapping(value = "/administrator")
@SessionAttributes("currentAdmin")
public class AdministratorController {

    protected Logger log = LoggerFactory.getLogger(getClass());
    // private Validator validator;

    private static final String TOKEN = "#{'TOKEN'}";
    private static final String ADMIN_ID = "#{'ADMIN'}";

    @Autowired
    private AdministratorService administratorService;

    @Autowired
    private DomainService domainService;

    @Autowired
    private MailService mailService;

    @Autowired
    private MessageSource configuration;

    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public String list(
            @AdminRequired Administrator currentAdmin,
            @RequestParam(required = false, value = "domainId", defaultValue = "1") int domainId,
            @RequestParam("pageSize") int pageSize,
            @RequestParam("pageNumber") int pageNumber,
            @RequestParam("sortColumn") String sortColumn,
            @RequestParam("sortType") String sortType, ModelMap model) {

        AdministratorQuery query = new AdministratorQuery();
        query.setDomainId(domainId);
        query.setPageNumber(pageNumber);
        query.setLength(pageSize);
        query.setSortColumn(sortColumn);
        query.setSortType(sortType);
        query.setAdminId(currentAdmin.getId());

        final PagedCollection<Administrator> administrators = administratorService.retrieve(query);

        model.addAttribute("pagedRecords", administrators);
        return "administrator/list";
    }

    @RequestMapping(value = "/availability", method = RequestMethod.GET)
    @ResponseBody
    public AvailabilityStatus getAvailability(@RequestParam long id,
                                              @RequestParam String adminId,
                                              @RequestParam int domainId) {
        final boolean ifAdminIdAvailable = administratorService.ifAdminIdAvailable(domainId, id, adminId);
        if (ifAdminIdAvailable) {
            return AvailabilityStatus.available();
        }
        return AvailabilityStatus.notAvailable(adminId);
    }

    @RequestMapping(value = "/create", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, ? extends Object> create(
            @RequestBody Administrator administrator) {
        administratorService.addAdminAccount(administrator);
        return Collections.singletonMap("result", "ok");
    }

    @RequestMapping(value = "/details", method = RequestMethod.GET)
    @ResponseBody
    public Map<String, ? extends Object> details(
            @RequestParam(value = "id0") long id, HttpServletResponse response) {

        Administrator details = administratorService.details(id);
        return Collections.singletonMap("adminDetails", details);
    }

    @RequestMapping(value = "/entity", method = RequestMethod.GET)
    @ResponseBody
    public Map<String, ? extends Object> domainInfo(
            @AdminRequired Administrator currentAdmin) {
        Domain domain = domainService.details(currentAdmin.getDomainId());
        Map<String, Object> entity = new HashMap<String, Object>();
        entity.put("id", domain.getId());
        entity.put("name", domain.getName());
        entity.put("parent_id", domain.getParentId());
        return Collections.singletonMap("entity", entity);
    }


    @RequestMapping(value = "/delete", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, ? extends Object> delete(
            @AdminRequired Administrator currentAdmin,
            @RequestBody List<Map<String, Object>> ids,
            HttpServletResponse response) {
        List<Long> idList = new ArrayList<Long>();
        for (Map id : ids) {
            long adminId = Long.valueOf((String) id.get("id"));
            if (adminId != currentAdmin.getId()) {
                idList.add(adminId);
            }

        }
        administratorService.deleteAccount(idList);
        return Collections.singletonMap("result", "ok");
    }

    private Map<String, String> validationMessages(
            Set<ConstraintViolation<Administrator>> failures) {
        Map<String, String> failureMessages = new HashMap<String, String>();
        for (ConstraintViolation<Administrator> failure : failures) {
            failureMessages.put(failure.getPropertyPath().toString(),
                    failure.getMessage());
        }
        return failureMessages;
    }


    @RequestMapping(value = "/edit", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, ? extends Object> edit(
            @RequestBody Administrator admin, HttpServletResponse response) {


        administratorService.edit(admin);
        return Collections.singletonMap("id", '1');
    }

    @RequestMapping(value = "/password/reset", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, ? extends Object> resetPassword(
            @RequestBody Administrator admin, HttpServletResponse response) {
        administratorService.resetPassword(admin);
        return Collections.singletonMap("id", '1');
    }


    @RequestMapping(value = "/login", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, ? extends Object> login(@RequestParam String username,
//	public String  login(@RequestParam String username,
                                               @RequestParam String password, HttpSession session, ModelMap model) {
        Administrator admin = administratorService.login(username, password);
        model.addAttribute("currentAdmin", admin);
        session.setAttribute("currentAdmin", admin);

        return Collections.singletonMap("result", "true");
//        return "redirect:/index";//todo: Get 302 Found.
    }

    /**
     * generate Token for resetting password.
     */
    @RequestMapping(value = "/password/forgot", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, ? extends Object> resetSelfPassword(
            @RequestBody Map<String, String> email, ModelMap model) {
        // TODO:validate the parameter email.
        final String adminEmail = email.get("email");
        String token = administratorService.generateToken(adminEmail);
        email.put("token", token);
        if (token == null) {
            final String errorMessage = StringUtils.join("Administrator ",
                    adminEmail, " not found");
            return ImmutableMap.of("result", "error", "code", errorMessage);
        }
        String mailText = configuration.getMessage(MailServiceImpl.MAIL_TEXT,
                null, null);
        String mailTo = adminEmail;
        mailText = mailText.replace(TOKEN, token);
        mailText = mailText.replace(ADMIN_ID, adminEmail);
        try {
            mailService.sendHtmlMail(mailTo, mailText);
        } catch (MessagingException e) {
            return ImmutableMap.of("result", "error", "code",
                    "Sending mail failed");
        }
        return Collections.singletonMap("result", "ok");
    }


    @RequestMapping(value = "/password/reset_by_token", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, ? extends Object> resetPasswordByToken(
            @RequestBody Map<String, String> adminParam) {
        // todo,validate the parameter email.
        String adminId = adminParam.get("adminId");
        String token = StringUtils.trim(adminParam.get("token"));
        String password = adminParam.get("password");

        if (StringUtils.isBlank(adminId) || StringUtils.isBlank(token)
                || StringUtils.isBlank(password)) {
            return Collections.singletonMap("result", "Fail");
        }

        Administrator admin = new Administrator();
        admin.setAdminId(adminId);
        admin.setPassword(password);
        final boolean result = administratorService.resetPasswordByToken(admin,
                token);
        if (!result) {
            return Collections.singletonMap("result", "fail");
        }
        return Collections.singletonMap("result", "ok");
    }

    /*@ExceptionHandler(HttpSessionRequiredException.class)
    public String sessionInvalid() {
        log.debug("session invalidate. ReLogin.");
//		return "redirect:/login";
        return "redirect:/index";
    }*/

}
