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
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanListHandler;

public class addBlog extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
    public addBlog() {
        super();
    }
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		UserContent userContent = (UserContent)session.getAttribute("userContent");
		if(userContent == null){
			response.sendRedirect("/nextplus-blog/admin/login.jsp");
		} else {
			list(request,response);
		}
	}
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public void list(HttpServletRequest request, HttpServletResponse response)
	throws ServletException, IOException {
		DataSource ds = null;
		try {
			Context context = new InitialContext();
			ds = (DataSource) context.lookup("java:comp/env/jdbc/blog");
		} catch (Exception e) {
			System.out.println("获取blog数据源错误！");
		}
		List<Category> list = null;
		try {
			String sql = "select * from category order by level desc,id desc";
			QueryRunner qr = new QueryRunner(ds);
			list = (List<Category>)qr.query(sql, new BeanListHandler(Category.class));
			request.setAttribute("list", list);
			request.getRequestDispatcher("/admin/addBlog.jsp").forward(request,response);
			//response.sendRedirect("/nextplus-blog/admin/addBlog.jsp");
		} catch (SQLException e) {
			e.printStackTrace();
		}
	
	}

}
