package org.nextplus.blog;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanListHandler;

public class GetBlog extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public GetBlog() {
        super();
    }

	@SuppressWarnings({ "unchecked", "rawtypes" })
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("id");
		
		DataSource ds = null;
		try {
			Context context = new InitialContext();
			ds = (DataSource) context.lookup("java:comp/env/jdbc/blog");
		} 
		catch (Exception e) {
			System.out.println("获取blog数据源错误！");
		}
		BlogContent blogContent =null;
		String sql = "select id, title, content, createdtime as createdTime from blog where id="+id;
		try {
			QueryRunner qr = new QueryRunner(ds);
			List<BlogContent> list = (List<BlogContent>)qr.query(sql, new BeanListHandler(BlogContent.class));
			blogContent = (BlogContent)list.get(0);
			
		}
		catch(SQLException e){
			e.printStackTrace();
		}
		
		sql="select id, username, content, createdtime from comment where blog_id="+id;
		List<CommentContent> list = null;
		try {
			QueryRunner qr = new QueryRunner(ds);
			list = (List<CommentContent>)qr.query(sql, new BeanListHandler(CommentContent.class));
			
		}
		catch(SQLException e){
			e.printStackTrace();
		}

		request.setAttribute("blogContent", blogContent);
		request.setAttribute("list", list);
		request.getRequestDispatcher("/displayBlog.jsp").forward(request,
				response);
		
	}
}
