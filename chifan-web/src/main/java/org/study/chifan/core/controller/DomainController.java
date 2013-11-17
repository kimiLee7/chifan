package org.study.chifan.core.controller;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.study.chifan.core.annotation.AdminRequired;
import org.study.chifan.core.entity.Administrator;
import org.study.chifan.core.entity.AvailabilityStatus;
import org.study.chifan.core.entity.Domain;
import org.study.chifan.core.entity.DomainVO;
import org.study.chifan.core.service.DomainService;
import org.study.chifan.core.utils.FileUtil;

import javax.servlet.http.HttpServletResponse;
import java.util.*;

@Controller
@RequestMapping(value = "/entity")
@SessionAttributes("currentAdmin")
public class DomainController {

    Logger log = LoggerFactory.getLogger(getClass());

    private static final String LOGO_FILE_NAME = "logo.png";
    private static final String AVERT_FILE_NAME = "avert.png";
    private static final String UPLOAD_FILE_FOR_LOGO = "logo";
    //private static final String DEFAULT_STORAGE_ROOT = "/opt/app/admin/domain/";

    @Autowired
    private DomainService domainService;

    @Value("${upload_url:null}")
    private String uploadUrl;

    @Value("${domain.storage.root}")
    private String storageRoot;

    @Value("${domain.profile.default.directory}")
    private String defaultStorageRoot;

    @Value("${domain.logo.file.name}")
    private String logoFileName;

    @Value("${domain.advert.file.name}")
    private String advertFileName;

    @RequestMapping(value = "/tree", method = RequestMethod.GET)
    public String tree(
            @AdminRequired Administrator currentAdmin,
            ModelMap model) {
        final Administrator admin = currentAdmin;// administratorService.findByAdminId(currentAdmin.getAdminId());
        Domain rootDomain = domainService.details(admin.getDomainId());
        final String domainTree = domainService.getDomainTree(rootDomain);
        // final String domainTree = domainService.getDomainTree(0);
        model.addAttribute("domainTreeView", domainTree);

        return "domain/domain_tree";
    }

    /*@ExceptionHandler(HttpSessionRequiredException.class)
    @ResponseBody
    public Map<String, ? extends Object> sessionInvalid() {
        log.debug("session invalidate. ReLogin.");
        // return Collections.singletonMap("result", "ok");
        return ImmutableMap.of("code", "90001", "message", "Session invalid.");
    }*/


    @RequestMapping(method = RequestMethod.POST)
    @ResponseBody
    public Map<String, ? extends Object> create(
            @RequestBody Domain domain) {
        domainService.addDomain(domain);
        Map<String, Object> entity = new HashMap<>();
        entity.put("id", domain.getId());
        entity.put("name", domain.getName());
        entity.put("parent_id", domain.getParentId());
        return Collections.singletonMap("entity", entity);
    }

    @RequestMapping(value = "{id}", method = RequestMethod.GET)
    public String get(@PathVariable Integer id, ModelMap model) {
        log.debug("---get domain:" + id);
        DomainVO domainVO = domainService.get(id);

        model.addAttribute("details", domainVO);
        if (StringUtils.isBlank(uploadUrl)) {
            log.error("Configuration item [upload_url] is empty.");
        }
        model.addAttribute("uploadUrl", uploadUrl);

        return "domain/detail";
    }


    @RequestMapping(method = RequestMethod.GET)
    @ResponseBody
    public Map<String, ? extends Object> details(
            @RequestParam int id) {
        Domain details = domainService.details(id);
        return Collections.singletonMap("domainDetails", details);
    }

    @RequestMapping(value = "/availability", method = RequestMethod.GET)
    public
    @ResponseBody
    AvailabilityStatus getAvailability(@RequestParam int id,
                                       @RequestParam String domainName,
                                       @RequestParam int currentDomainId) {
        if (domainService.ifDomainNameAvailable(id, domainName, currentDomainId)) {
            return AvailabilityStatus.available();
        }
        return AvailabilityStatus.notAvailable(domainName);
    }

    @RequestMapping(value = "/can_delete", method = RequestMethod.GET)
    public
    @ResponseBody
    AvailabilityStatus canDeleteDomain(@RequestParam int currentDomainId) {
        if (domainService.canDeleteDomain(currentDomainId)) {
            return AvailabilityStatus.available();
        }
        return AvailabilityStatus.notAvailable("domain");
    }

    @RequestMapping(value = "/quota_less_than_parent", method = RequestMethod.GET)
    public
    @ResponseBody
    AvailabilityStatus isQuotaLessThanParent(@RequestParam Long quota,
                                             @RequestParam int ifNew,
                                             @RequestParam int domainId) {
        if (domainService.isQuotaLessThanParent(quota, domainId, ifNew)) {
            return AvailabilityStatus.available();
        }
        return AvailabilityStatus.notAvailable("");
    }

    @RequestMapping(value = "/quota_larger_than_subs", method = RequestMethod.GET)
    public
    @ResponseBody
    AvailabilityStatus isQuotaLargerThanSubEntities(@RequestParam Long quota,
                                                    @RequestParam int ifNew,
                                                    @RequestParam int domainId) {
        if (domainService.isQuotaLargerThanSubEntities(quota, domainId, ifNew)) {
            return AvailabilityStatus.available();
        }
        return AvailabilityStatus.notAvailable("");
    }


    @RequestMapping(value = "/edit", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, ? extends Object> edit(
            @RequestBody Domain domain) {
        domainService.edit(domain);
        return Collections.singletonMap("result", "ok");
    }


    @RequestMapping(value = "/delete", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, ? extends Object> delete(
            @RequestBody List<Map<String, Object>> targets) {
        List<Integer> ids = new ArrayList<>();
        for (Map id : targets) {
            ids.add(Integer.valueOf((String) id.get("id")));
        }
        domainService.delete(ids);
        return Collections.singletonMap("result", "ok");
    }


    @RequestMapping(value = "/file/upload", method = RequestMethod.POST)
    @ResponseBody
    public Map uploadFile(MultipartHttpServletRequest request,
                          @AdminRequired Administrator currentAdmin,
                          @RequestParam int domainId,
                          @RequestParam String uploadFileFor) {
        if (domainId <= 0) {
            return Collections.singletonMap("result", "error");
        }

        MultipartFile multipartFile = request.getFile("file_upload");

        if (multipartFile == null) {
            log.error("upload file error: missing file_upload parameter");
            return Collections.singletonMap("result", "error");
        }

        String storagePath = getStoragePath(domainId);

        final String fileName = getFileName(uploadFileFor);
//        String name = multipartFile.getOriginalFilename();

        try {

            java.io.File parentDir = new java.io.File(storagePath);
            if (!parentDir.exists()) {
                parentDir.mkdirs();
            }

            String descPath = storagePath + fileName;
            FileUtil.writeFile(multipartFile.getInputStream(), descPath);

        } catch (Exception e) {
            log.error("upload file error:", e);
            return Collections.singletonMap("result", "exception");
        }
        return Collections.singletonMap("result", "ok");
    }

    private String getFileName(String uploadFileFor) {
        if (UPLOAD_FILE_FOR_LOGO.equalsIgnoreCase(uploadFileFor)) {
            if (StringUtils.isBlank(logoFileName)) {
                log.warn("Configuration item [domain.logo.file.name] is empty.");
                logoFileName = LOGO_FILE_NAME;
            }
            return logoFileName;
        } else {
            if (StringUtils.isBlank(advertFileName)) {
                log.warn("Configuration item [domain.advert.file.name] is empty.");
                advertFileName = AVERT_FILE_NAME;
            }
            return advertFileName;
        }
    }

    private String getStoragePath(int domainId) {

        if (domainId <= 0) {
            if (defaultStorageRoot.endsWith("/")) {
                return defaultStorageRoot;
            }
            return defaultStorageRoot + "/";
        }
        if (StringUtils.isBlank(storageRoot)) {
            log.warn("Configuration item [domain.storage.root] is empty.");
            storageRoot = this.defaultStorageRoot;
        }

        if (storageRoot.endsWith("/")) {
            return storageRoot + domainId + "/";
        } else {
            return storageRoot + "/" + domainId + "/";
        }


    }

    @RequestMapping(value = "/drag_upload")
    public ModelAndView DragUploadView(@RequestParam(value = "upload_file_for", defaultValue = "64") String uploadFileFor) {
        ModelAndView modelAndView = new ModelAndView("drag_upload");
        if (StringUtils.isBlank(uploadUrl)) {
            log.error("Configuration item [upload_url] is empty.");
        }
        modelAndView.addObject("uploadUrl", uploadUrl);
        modelAndView.addObject("upload_file_for", uploadFileFor);
        return modelAndView;
    }

    @RequestMapping(value = "/file/download", method = RequestMethod.GET)
    @ResponseBody
    public void viewFile(
            @RequestParam int domainId,
            @RequestParam String uploadFileFor,
            HttpServletResponse response) {
        final String fileName = getFileName(uploadFileFor);
        String filePath = getStoragePath(domainId) + fileName;
        String defaultFilePath = getStoragePath(0) + fileName;
        FileUtil.downloadFile(filePath, defaultFilePath, fileName, "png", response);

    }


    @RequestMapping(value = "/file/delete", method = RequestMethod.GET)
    @ResponseBody
    public void deleteUploadedFile(@RequestParam int domainId, @RequestParam String deletedFileFor) {

        final String fileName = getFileName(deletedFileFor);
        String filePath = getStoragePath(domainId) + fileName;

        FileUtil.deleteUploadFile(filePath, fileName, "png");
    }

}

