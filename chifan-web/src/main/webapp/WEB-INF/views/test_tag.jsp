<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>

<div id="testTag" style="display: none;">
  <%
    //创建一个List对象
    List<String> a = new ArrayList<String>();
    Map<String,String> permissions = new HashMap<String,String>();
    permissions.put("createDomain","1");
    permissions.put("deleteDomain","0");
    permissions.put("refreshDomain","1");
    pageContext.setAttribute("permissions", permissions);

    a.add("hello");
    a.add("world");
    a.add("java");
    //将List对象放入page范围内
    pageContext.setAttribute("a", a);
  %>
  <!-- 使用迭代器标签，对a集合进行迭代 -->
  <%--<mytag:iterator collection="a" item="item" display="display">
  &lt;%&ndash;<span>${pageScope.item}</span>&ndash;%&gt;
  <input type="button" value="${pageScope.item}-${pageScope.display}" style="display: ${pageScope.display};">
  </mytag:iterator>--%>

  <mytag:iterator collection="permissions" item="item" display="display">
    <input type="button" id="${pageScope.item}" value="${pageScope.item}-${pageScope.display}" style="display: ${pageScope.display};">
  </mytag:iterator>

  <mytag:iterator collection="permissions" item="createDomain" display="display">
    <a rel="create" href="#" title="Create a Entity" id="create_entity_link" class="dropdown-toggle btn action" style="display: ${pageScope.createDomain};">Create
    </a>
  </mytag:iterator>

  <mytag:iterator collection="permissions" item="deleteDomain" display="display">
    <a title="Delete the selected item" data-info-type="tooltip" id="delete" href="#" class="btn action disabled"
       onclick="showDialogForDeleteDomain();" style="display: ${pageScope.deleteDomain};"><i class="icon-trash"></i> Delete</a>
  </mytag:iterator>

  <mytag:iterator collection="permissions" item="refreshDomain" display="display">
    <a title="Refresh" id="domain_tree_refresh" onclick="refreshDomainTree(-1);" rel="refresh" href="#"
       class="btn refresh"><i class="icon-refresh" style="display: ${pageScope.refreshDomain};"></i></a>
  </mytag:iterator>
  <br>
</div>

<script type="text/javascript">
  function showDialogForTestTag() {
    $('#testTag').show();
    $.fancybox({
      href:'#testTag',
      onClosed:function () {
        $("#testTag").hide();
      }
    });
  }
</script>