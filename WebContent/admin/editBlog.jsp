<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="org.nextplus.blog.BlogContent" %>
<%@ page import="org.nextplus.blog.Category" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="<%=request.getContextPath()%>/admin/ckeditor/ckeditor.js"></script>  
        <script type="text/javascript">     
        //<![CDATA[    
            CKEDITOR.replace('content',{toolbar:'Full', skin : 'kama'});    
        //]]>     
        </script> 
<title>修改博文内容</title>
</head>
<body>
<% 
	@SuppressWarnings({ "unchecked"})
	List<Category> list=(List<Category>)request.getAttribute("list");
%>
<% BlogContent blogContent = (BlogContent)request.getAttribute("blogContent"); %>
<h2>请您修改您的博文内容：</h2>
<br />
<br />
<br />
<form action="/nextplus-blog/Blog" method="post">
<input type="hidden" name="method" value="update"/>
<input type="hidden" name="id" value="<%=blogContent.getId() %>"/>
<table width="400" border="0">
  <tr>
    <td>主题：</td>
    <td><input name="title" type="text" size="90" value="<%=blogContent.getTitle() %>"/></td>
  </tr>
  <tr>
    <td>类别：</td>
    <td>
        <select name="category" size="1">
         <% for(int i=0; i< list.size();i++){
           Category category = (Category)list.get(i);
           System.out.println(category);
        %>
          <option value="<%=category.getId() %>"><%=category.getName() %></option>
        <%} %>
        </select>
    </td>
  </tr>
  <tr>
    <td>内容：</td>
    <td>
	    <textarea class="ckeditor" cols="80" id="content" name="content" rows="25"><%=blogContent.getContent() %></textarea>
    </td>
  </tr>
  <tr>
    <td><input name="reset" type="reset" value="重置" /></td>
    <td><input name="submit" type="submit" value="提交" /></td>
  
</table>

</form>
</body>
</html>