<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="org.nextplus.blog.CommentContent"%>
<%@ page import="java.util.List"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link href="/nextplus-blog/css/manage.css" type=text/css rel=stylesheet>
<link href="/nextplus-blog/css/css-main.css" type=text/css
	rel=stylesheet>
<script type="text/javascript"
	src="/nextplus-blog/js/jquery/jquery-1.2.6.js"></script>
<script type="text/javascript" src="/nextplus-blog/js/common.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>编辑评论</title>
</head>
<body>
<%
	@SuppressWarnings({ "unchecked" })
	List<CommentContent> list = (List<CommentContent>) request
			.getAttribute("list");
%>
<%
	CommentContent cc = (CommentContent) request.getAttribute("cc");
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
			<form action="/nextplus-blog/Comment" method="post"><input
				type="hidden" name="method" value="update" /> <input name="id"
				type="hidden" value="<%=cc.getId()%>" />

			<p><input type="text" name="username" class="comm_input_text"
				id="author" value="<%=cc.getUsername()%>" size="22" tabindex="1" />
			<label for="author">昵称</label></p>
			<p><textarea name="content" class="comm_textarea_text"
				id="comment" cols="40" rows="8" style="width: 400px" tabindex="4"><%=cc.getContent() %></textarea></p>
			<p><input name="Submit" type="submit" value="发表评论"
				style="border: 1px solid #CCCCCC; background: #333333; color: #FFFFFF;" />
			</p>
			</form>
			</td>
		</tr>
	</tbody>
</table>
</div>


</body>
</html>