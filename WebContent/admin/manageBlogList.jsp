<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="org.nextplus.blog.BlogContent"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="/nextplus-blog/css/manage.css" type=text/css rel=stylesheet>
<link href="/nextplus-blog/css/css-main.css" type=text/css
	rel=stylesheet>
<script type="text/javascript"
	src="/nextplus-blog/js/jquery/jquery-1.2.6.js"></script>
<script type="text/javascript" src="/nextplus-blog/js/common.js"></script>
<title>博文管理</title>
<script type="text/javascript">		
			function del() {
				var msg = "您真的确定要删除吗？\n\n请确认！";
				if (confirm(msg)==true){
						return true;
					}else{
						return false;
					}
				}
</script>
</head>
<body>
<%
	@SuppressWarnings({ "unchecked" })
	List<BlogContent> list = (List<BlogContent>) request
			.getAttribute("list");
	BlogContent blogContent = null;
%>
<div class="center">
<table id=header cellspacing=0 cellpadding=0 width="988" border=0>
	<tbody>
		<tr>
			<td width="9" id="headerleft"></td>
			<td class="home" align="left"><a href="/nextplus-blog/" target="_blank"
				title="在新窗口浏览我的blog">去我的博客首页 </a></td>
			<td align=right nowrap class="headtext"><a href="#">设置</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;
			<a href="/nextplus-blog/admin/admin.jsp">管理首页</a>&nbsp;&nbsp;|&nbsp;&nbsp; <a
				href="/nextplus-blog/User?method=logout">退出</a>&nbsp;&nbsp;&nbsp;&nbsp;</td>
			<td width="9" id="headerright"></td>
	</tbody>
</table>
<table cellspacing=0 cellpadding=0 width="100%" border=0>
	<tbody>
		<tr>

			<td valign=top align=left width="114">
			<div id=sidebartop></div>
			<table cellspacing=0 cellpadding=0 width="100%" border=0>
				<tbody>
					<tr>
						<td valign=top align=left width="114">
						<div id=sidebar>
						<div class="sidebarmenu" onclick="displayToggle('log_mg', 1);">博文管理</div>

						<div id="log_mg">
						<div class="sidebarsubmenu" id="menu_wt"><a
							href="/nextplus-blog/addBlog">写博文</a></div>
						<div class="sidebarsubmenu" id="menu_draft"><a
							href="/nextplus-blog/Blog?method=list">博文列表<span id="dfnum">
						</span></a></div>
						</div>
						</div>
						</td>
					</tr>
				</tbody>
			</table>

			<table cellspacing=0 cellpadding=0 width="100%" border=0>
				<tbody>
					<tr>
						<td valign=top align=left width="114">
						<div id=sidebar>
						<div class="sidebarmenu" onclick="displayToggle('log_mg', 1);">分类管理</div>

						<div id="log_mg">
						<div class="sidebarsubmenu" id="menu_wt"><a
							href="./admin/addCategory.jsp">添加分类</a></div>
						<div class="sidebarsubmenu" id="menu_draft"><a
							href="/nextplus-blog/DealCategory?method=list">分类管理<span
							id="dfnum"> </span></a></div>
						</div>
						</div>
						</td>
					</tr>
				</tbody>
			</table>

			<table cellspacing=0 cellpadding=0 width="100%" border=0>
				<tbody>
					<tr>
						<td valign=top align=left width="114">
						<div id=sidebar>
						<div class="sidebarmenu" onclick="displayToggle('log_mg', 1);">评论管理</div>

						<div id="log_mg">
						<div class="sidebarsubmenu" id="menu_draft"><a
							href="/nextplus-blog/Comment?method=list">评论管理<span
							id="dfnum"> </span></a></div>
						</div>
						</div>
						</td>
					</tr>
				</tbody>
			</table>
			</td>
			<td id=container valign=top align=left>
			<div class=containertitle><b>博文管理</b></div>

			<div class=line></div>

			<form action="admin_log.php?action=operate_log" method="post"
				name="form_log" id="form_log"><input type="hidden" name="pid"
				value="">
			<table width="100%" id="adm_log_list" class="item_list">
				<thead>
					<tr>
						<th width="21"><input onclick="CheckAll(this.form)"
							type="checkbox" value="on" name="chkall" /></th>
						<th width="146"><b>编号</b></th>
						<th width="490"><b>标题</b></th>
						<th width="40" class="tdcenter"><b>查看</b></th>
						<th width="146"><b>分类</b></th>

						<th width="148"><b><a href="#">时间</a></b></th>
						<th width="40" class="tdcenter"><b><a href="#">编辑</a></b></th>
						<th width="40" class="tdcenter"><b><a href="#">删除</a></b></th>
					</tr>

				</thead>
				<tbody>
					<%
						for (int i = 0; i < list.size(); i++) {
							blogContent = (BlogContent) list.get(i);
					%>
					<tr>
						<td><input type="checkbox" name="blog[]" value="3"
							class="ids" /></td>
						<td><a href="#"><%=blogContent.getId()%></a></td>
						<td><a href="#"></a><%=blogContent.getTitle()%></td>
						<td class="tdcenter"><a
							href="http://localhost:8080/nextplus-blog/GetBlog?id=<%=blogContent.getId()%>"
							target="_blank"><img src="/nextplus-blog/images/vlog.gif" /></a></td>

						<td><a href="#"></a></td>
						<td><%=blogContent.getCreatedTime()%></td>
						<td class="tdcenter"><a
							href="/nextplus-blog/Blog?method=edit&id=<%=blogContent.getId()%>"><img
							src="/nextplus-blog/images/addblog.gif" /></a></td>
						<td class="tdcenter"><a
							href="/nextplus-blog/Blog?method=delete&id=<%=blogContent.getId()%>"
							onclick="javascript:return del()"><img
							src="/nextplus-blog/images/icon_del.gif" /></a></td>
					</tr>
					<%
						}
					%>
				</tbody>
			</table>
			</form>
			</td>
		</tr>
	</tbody>
</table>
</div>
</body>
</html>