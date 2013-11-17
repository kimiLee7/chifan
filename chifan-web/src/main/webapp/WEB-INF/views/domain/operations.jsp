<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>
<%@page contentType="text/html;charset=UTF-8" %>
<%@page pageEncoding="UTF-8" %>
<%@ page session="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.swiftsync.org/security-taglib" prefix="permission" %>

<permission:show_button resource="DOMAIN" operation="GET">
  <a title="Refresh" id="domain_tree_refresh" onclick="refreshDomainTree(-1);" rel="refresh" href="#" class="btn refresh"><i class="icon-refresh"></i></a>
</permission:show_button>


<permission:show_button resource="DOMAIN" operation="CREATE">
  <a rel="create" href="#" title="Create a Entity" id="create_entity_link" onclick="showDialogForCreateDomain();" class="dropdown-toggle btn action">Create</a>
</permission:show_button>

<permission:show_button resource="DOMAIN" operation="DELETE">
  <a title="Delete the selected item" data-info-type="tooltip" id="delete" href="#" class="btn action disabled" onclick="showDialogForDeleteDomain();"><i class="icon-trash"></i>Delete</a>
</permission:show_button>

