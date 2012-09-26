<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="org.nextplus.blog.BlogContent"%>
<%@ page import="java.util.List"%>
<%@ page import="org.nextplus.blog.CommentContent"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
	BlogContent blogContent = (BlogContent) request
			.getAttribute("blogContent");
	@SuppressWarnings({ "unchecked" })
	List<CommentContent> list = (List<CommentContent>) request
			.getAttribute("list");
	CommentContent cc = null;
%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="/nextplus-blog/css/style.css"
	rel="stylesheet" type="text/css">
<script src="/nextplus-blog/js/js.js"
	type="text/javascript"></script>

<title><%=blogContent.getTitle()%></title>
</head>
<body>
<div id="page">
<div id="header">
<div id="header_title">
<h1><a href="/nextplus-blog/">Java
OpenSource Blog</a><span class="description">An open source blog
system using Java</span></h1>
</div>
<div id="header_rss"><a href="#" title="RSS"><img
	src="/nextplus-blog/images/rss.gif" alt="Harris Wang" /></a></div>
<div class="clear"></div>
</div>
<div id="menu">
<div id="menu_items">
<ul>
	<li><a href="/nextplus-blog/">首&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;页</a></li>
	<li><a href="/nextplus-blog/GetBlogList">博文目录</a></li>
	<li><a href="/nextplus-blog/admin/admin.jsp" target="_blank">登&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;录</a></li>
	<li><a href="/nextplus-blog/GetBlog?id=46" target="_blank">关&nbsp;&nbsp;于&nbsp;&nbsp;我</a></li>
</ul>
<div class="clear"></div>
</div>
<div id="main_search">
<form method="get" name="keyform" id="searchform_top" action="#">
<div><span>查找下</span><input type="text" value="" name="keyword"
	id="searchform_top_text" /> <input type="submit" id="gosearch"
	value="" /></div>
</form>
</div>
<div class="clear"></div>
</div>

<div id="body">
<div id="body_top">
<div id="body_left">
<div id="body_left_content">

<div id="content" class="narrowcolumn">
<div class="post" id="post-1">
<div class="post-top">
<div class="post-title">
<h2><%=blogContent.getTitle()%></h2>

<h3>post by <a href="/nextplus-blog/GetBlog?id=46">Menthe</a> /<%=blogContent.getCreatedTime()%></h3>
</div>
</div>
<div class="entry clear">
<p><%=blogContent.getContent()%></p>
<p></p>
</div>
<h2 id="comment_title">评论列表：<a name="comment"></a></h2>
<div class="commentlist">
<%
	for (int i = 0; i < list.size(); i++) {
		cc = (CommentContent) list.get(i);
		System.out.println(cc);
%>

<div class="alt comm_items" id="comment-1">
<div class="commentmetadata"><%=cc.getUsername()%><span>评论说...</span></div>
<div class="commentmetadata_text"><%=cc.getContent()%></div>
<br />
<%
	}
%>
</div>
<div class="clear"></div>
</div>
</div>
</div>
<div id="respond_box">
<h3 id="respond">发表评论：</h3>
<form method="post" name="commentform" action="/nextplus-blog/Comment"
	id="commentform"><input name="blog_id" type="hidden"
	value="<%=blogContent.getId()%>" /> <input name="method"
	type="hidden" value="add" />
<p><input type="text" name="username" class="comm_input_text"
	id="author" value="" size="22" tabindex="1" /> <label for="author">昵称</label></p>
<!-- 
	<p>
	<input type="text" name="commail" style="width:260px" maxlength="128"  value="" class="comm_input_text" id="email" size="22" tabindex="2">
	<label for="email">信箱 (选填)</label></p>
	<p>
	<input type="text" name="comurl" class="comm_input_text" style="width:260px" size="22" tabindex="3"  value="">
	<label for="url">主页 (选填)</label></p>
-->
<p><textarea name="content" class="comm_textarea_text" id="comment"
	cols="40" rows="8" style="width: 400px" tabindex="4"></textarea></p>
<p><input name="Submit" type="submit" value="发表评论"
	style="border: 1px solid #CCCCCC; background: #333333; color: #FFFFFF;" />
</p>
</form>
</div>
</div>
</div>
</div>
</div>
<div id="footer">
<div id="footer_text">Powered by <a href="mailto:softrayn@gmail.com"
	title="Harris Wang">Harris Wang</a> | <a href="http://softrayn.com/">Softrayn.Com</a>
</div>
<div id="footer_ask"><a href="http://softrayn.com/"
	target="_blank"></a></div>
<div class="clear"></div>

</div>
</div>
</body>
</html>