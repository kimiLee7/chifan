<%@page contentType="text/html;charset=UTF-8" %>
<%@page pageEncoding="UTF-8" %>
<%@ page session="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.swiftsync.org/security-taglib" prefix="permission" %>
<link rel="stylesheet" href="<c:url value='/resources/css/module-fileUpload.css' />"/>

<div class="pt20b bor2 overflow">
  <h2 class="h2_style">Information</h2>
  <permission:show_button resource="DOMAIN" operation="MODIFY">
    <span class="red_btn fr" onclick="showDialogForEditDomain();">Edit</span>
  </permission:show_button>
</div>
<div class="table_sytle">
  <table>
    <tbody>
    <tr>
      <th>Entity Name</th>
      <td>${details.name}</td>
    </tr>
    <tr>
      <th>Full Name</th>
      <td>${details.fullName}</td>
    </tr>
    <tr>
      <th>Parent Entity</th>
      <td>${details.parentName}</td>
    </tr>
    <tr>
      <th>Quota(GB)</th>
      <td>${details.quota}</td>
    </tr>
    <tr>
      <th>Description</th>
      <td>${details.description}</td>
    </tr>
    <tr>
      <th>Logo</th>
      <td style="vertical-align:middle">
        <span><img id="entity_logo" src="" title="logo" style="max-width:165px; max-height:45px; overflow:hidden"></span>

          <permission:show_button resource="DOMAIN" operation="MODIFY">
            <span class="red_btn fr" onclick="upload_file('logo');">Upload</span>
          </permission:show_button>
           <br />
        <div class="red">Please upload image with size of 160*45 pixels
         <span><permission:show_button resource="DOMAIN" operation="MODIFY">
             <a class="btn" id="delete_logo"  onclick="delete_file('logo');">Restore</a>
         </permission:show_button>
          </span>
        </div>
      </td>
    </tr>
    <tr>
      <th>Advert</th>
      <td style="vertical-align:middle">
        <span><img id="entity_advert" src="" title="advert" style="max-width:430px; max-height:50px; overflow:hidden"></span>

          <permission:show_button resource="DOMAIN" operation="MODIFY">
            <span class="red_btn fr" onclick="upload_file('advert');">Upload</span>
          </permission:show_button>

          <br />
        <div class="red">Please upload image with size of 430*50 pixels  <span>
        <permission:show_button resource="DOMAIN" operation="MODIFY">
            <a class="btn"   id="delete_advert"  onclick="delete_file('advert');">Restore</a>
        </permission:show_button>
        </span>
        </div>
      </td>
    </tr>
    </tbody>
  </table>
</div>
<!--table_sytle_end-->
<br/><br/>

<div class="table_style1 fl w390">
  <h3 class="h3_style">Storage Usage</h3>
  <table cellpadding="0" cellspacing="0">
    <tbody>
    <tr>
      <th>Quota of current Entity</th>
      <td>${details.quota} GB</td>
      <td></td>
    </tr>
    <tr>
      <th>Storage allocated to current Entity</th>
      <td>${details.allocatedCurrentEntityQuota} GB</td>
      <td>(${details.allocatedCurrentEntityQuotaPercent})</td>
    </tr>
    <tr>
      <th>Storage allocated to Sub-entities</th>
      <td>${details.allocatedSubEntitiesQuota} GB</td>
      <td>(${details.allocatedSubEntitiesQuotaPercent})</td>
    </tr>
    <tr>
      <th>Allocatable Storage</th>
      <td>${details.allocatableQuota} GB</td>
      <td>(${details.allocatableQuotaPercent})</td>
    </tr>
    </tbody>
  </table>
</div>

<div class="table_style1 fr w390">
  <h3 class="h3_style">End Users</h3>
  <table cellpadding="0" cellspacing="0">
    <tbody>
    <tr>
      <th>Total End Users</th>
      <td>${details.totalUsers}</td>
      <td></td>
    </tr>
    <tr>
      <th>Total End Users Developed by current Entity</th>
      <td>${details.currentEntityUsers}</td>
      <td>(${details.currentEntityUsersPercent})</td>
    </tr>
    <tr>
      <th>Total End Users Developed by Sub-entities</th>
      <td>${details.subEntitiesUsers}</td>
      <td>(${details.subEntitiesUsersPercent})</td>
    </tr>
    </tbody>
  </table>
</div>

<br class="clear"/> <br/>

<script src="<c:url value='/resources/js/admin.js' /> "></script>
<script src="<c:url value='/resources/js/common.js' />"></script>
<script src="<c:url value='/resources/js/common-fileUpload.js' />"></script>
<script src="<c:url value='/resources/js/Html5File.js' />"></script>
<script type="text/javascript">
  function reloadEntityLogo() {
    var currentDomainId = $('#current_domain').attr("currentDomainId");
    $('#entity_logo').attr("src", "entity/file/download?uploadFileFor=logo&domainId=" + currentDomainId + "&_ts=" + (new Date()).valueOf());

  }

  function delete_file(fileName){
	  var currentDomainId = $('#current_domain').attr("currentDomainId");

	  $.ajax({
		    type:"GET",
		    async:false,
		    url:'entity/file/delete',
		    data:{ domainId:currentDomainId,deletedFileFor:fileName},
		    success:function (data) {
		    	 reloadEntityLogo();
		    	 reloadEntityAdvert();
		    },
		    error:function (data) {
                handleError(data);
		    }
		  });

  }
function reloadEntityAdvert() {
    var currentDomainId = $('#current_domain').attr("currentDomainId");
    $('#entity_advert').attr("src", "entity/file/download?uploadFileFor=advert&domainId=" + currentDomainId + "&_ts=" + (new Date()).valueOf());

  }

  $(function () {
    reloadEntityLogo();
    reloadEntityAdvert();
  });


</script>