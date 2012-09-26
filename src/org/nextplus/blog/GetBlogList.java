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

public class GetBlogList extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public GetBlogList() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		DataSource ds = null;
		try {
			Context context = new InitialContext();
			ds = (DataSource) context.lookup("java:comp/env/jdbc/blog");
		} 
		catch (Exception e) {
			System.out.println("获取blog数据源错误！");
		}
		try {
			String sql = "select id, title, content, createdtime as createdTime from blog order by id desc";
			QueryRunner qr = new QueryRunner(ds);
			@SuppressWarnings({ "unchecked", "rawtypes" })
			List<BlogContent> list = (List<BlogContent>)qr.query(sql, new BeanListHandler(BlogContent.class));
			
			request.setAttribute("list", list);
			request.getRequestDispatcher("/displayBlogList.jsp").forward(request,
					response);
		}
		catch(SQLException e){
			e.printStackTrace();
		}
		
	}
}
