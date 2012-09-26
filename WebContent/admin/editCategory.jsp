<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="org.nextplus.blog.Category" %>
<%@ page import="org.nextplus.blog.UserContent" %>
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
<title>编辑分类名称</title>
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
<% UserContent userContent =  (UserContent)session.getAttribute("userContent");
   if(userContent == null){
	   response.sendRedirect("/nextplus-blog/admin/login.jsp");
   }
%>
<% Category category = (Category)request.getAttribute("category"); %>
<div class="center">
<table id=header cellspacing=0 cellpadding=0 width="988" border=0>
	<tbody>
		<tr>
			<td width="9" id="headerleft"></td>
			<td class="home" align="left"><a href="../" target="_blank"
				title="在新窗口浏览我的blog">去我的博客首页 </a></td>
			<td align=right nowrap class="headtext"><a href="#">设置</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;
			<a href="./admin.jsp">管理首页</a>&nbsp;&nbsp;|&nbsp;&nbsp; <a
				href="../User?method=logout">退出</a>&nbsp;&nbsp;&nbsp;&nbsp;</td>
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
							href="./addCategory.jsp">添加分类</a></div>
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
			<div class=containertitle><b>添加分类</b><span id="msg_2"></span></div>
			<form action="/nextplus-blog/DealCategory" method="post" id="addlog">
			<input type="hidden" name="method" value="update" />
			<input type="hidden" name="id" value="<%=category.getId() %>"/>
			<table cellspacing="1" cellpadding="4" width="720" border="0">
				<tbody>
					<tr>
						<td>分类名称<input type="text" maxlength="200" style="width: 150px;"
							name="name" id="title"  value="<%=category.getName() %>"/></td>
					</tr>

					<tr>
						<td style="font-size=50px;">显示次序<input type="text" maxlength="200" style="width: 150px;"
							name="level" id="title" value="<%=category.getLevel() %>"/></td>
					</tr>
					<tr>
						<td><br>
						<input type="submit" value="提交" class="button" /></td>
					</tr>
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