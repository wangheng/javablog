<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="org.nextplus.blog.Category"%>
<%@ page import="org.nextplus.blog.UserContent"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="/nextplus-blog/css/manage.css" type=text/css rel=stylesheet>
<link href="/nextplus-blog/css/css-main.css" type=text/css
	rel=stylesheet>
<script type="text/javascript" src="/nextplus-blog/js/jquery/jquery-1.2.6.js"></script>
<script type="text/javascript" src="/nextplus-blog/js/common.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/admin/ckeditor/ckeditor.js"></script>
<script type="text/javascript">
	//             
	CKEDITOR.replace('content', {
		toolbar : 'Full',
		skin : 'kama'
	});
	//
</script>
<title>创建新博文</title>
</head>
<body>
<%
	UserContent userContent = (UserContent) session
			.getAttribute("userContent");
	if (userContent == null) {
		response.sendRedirect("/nextplus-blog/admin/login.jsp");
	}
%>
<%
	@SuppressWarnings({ "unchecked" })
	List<Category> list = (List<Category>) request.getAttribute("list");
%>
<div class="center">
<table id=header cellspacing=0 cellpadding=0 width="988" border=0>
	<tbody>
		<tr>
			<td width="9" id="headerleft"></td>
			<td class="home" align="left"><a href="http://localhost:8080/nextplus-blog/" target="_blank"
				title="在新窗口浏览我的blog">去我的博客首页 </a></td>
			<td><b>欢迎<%=userContent.getUsername()%></b></td>
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
			<div class=containertitle><b>写博文</b><span id="msg_2"></span></div>
			<div id="msg"></div>
			<form action="/nextplus-blog/Blog" method="post" id="addlog">
			<input type="hidden" name="method" value="add" />
			<table cellspacing="1" cellpadding="4" width="720" border="0">
				<tbody>
					<tr>
						<td><input type="text" maxlength="200" style="width: 710px;"
							name="title" id="title" />
						</td>
					</tr>
					<tr>
						<td><select id="sort" style="width: 130px;" name="category">
							<option selected="selected">选择分类...</option>
							<%
								for (int i = 0; i < list.size(); i++) {
									Category category = (Category) list.get(i);
									System.out.println(category);
							%>

							<option value="<%=category.getId()%>"><%=category.getName()%></option>
							<%
								}
							%>
						</select>
						</td>
					</tr>
					<tr>
						<td><textarea class="ckeditor" cols="100" id="content"
							name="content" rows="8" style="width: 719px; height: 460px;">
						    </textarea>
						 </td>
					</tr>
				</tbody>
			</table>
			<table cellspacing="1" cellpadding="4" width="720" border="0">
				<tr>
					<td align="center"><br>
					<input type="submit" value="发布日志" onclick="return checkform();"
						class="button" />
					</td>
				</tr>
			</table>
			</form>
			</td>
		</tr>
	</tbody>
</table>
</div>
</body>
</html>