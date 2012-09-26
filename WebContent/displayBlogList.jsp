<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="org.nextplus.blog.BlogContent" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Harris Wang Blog System</title>
<link href="/nextplus-blog/css/style.css" rel="stylesheet" type="text/css">
<script src="/nextplus-blog/js/js.js" type="text/javascript"></script>
</head>
<body>
<div id="page">
	<div id="header">
		<div id="header_title">
		<h1><a href="/nextplus-blog/">Java OpenSource Blog</a><span
			class="description">An open source blog system using Java</span></h1>
		</div>
		<div id="header_rss"><a href="#" title="RSS"><img src="/nextplus-blog/images/rss.gif" alt="Harris Wang" /></a></div>
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
           <div><span>查找下</span><input type="text" value="" name="keyword" id="searchform_top_text" /> <input type="submit" id="gosearch" value="" />
           </div>
           </form>
           </div>
		<div class="clear">
	  </div>
	</div>
	
	<div id="body">
      <div id="body_top">
         <div id="body_left">
             <div id="body_left_content">
                 <div id="content" class="narrowcolumn">
<% 
@SuppressWarnings({ "unchecked"})
List<BlogContent> list=(List<BlogContent>)request.getAttribute("list");
BlogContent blogContent = null;
%>
<%
for(int i = 0; i<list.size(); i++){
	blogContent = (BlogContent)list.get(i);
%>
                       <div class="post" id="post-1">
                          <div class="post-top">
                              <div class="post-title">

<h2><a href="/nextplus-blog/GetBlog?id=<%=blogContent.getId() %>"><%=blogContent.getTitle() %></a></h2>

<h3>post by <a href="/nextplus-blog/GetBlog?id=46">Menthe</a>
/<%=blogContent.getCreatedTime() %></h3>
</div>
</div>
<div class="entry clear">

<div class="log_desc">
<%
       String str = blogContent.getContent();
       int length=1000;
       if(str.length()<1000){
    	   length=str.length();
       }
       out.print(str.substring(0,length)+"......");
       
       %>
<p></p>
</div>
</div>
<div class="postmetadata">

<div class="alignleft">
<a href="/nextplus-blog/GetBlog?id=<%=blogContent.getId() %>">评论(0)</a> 
<a href="#">引用(0)</a> 
<a href="#">浏览(0)</a>
</div>
</div>
</div>
<%} %>
</div>

<div class="navigation">

<div class="alignleft"></div>

</div>

</div>

</div>

<div id="body_right">
<div id="body_right_content">
<div id="sidebars">
<div id="sidebar" class="sidebars">

</div>

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