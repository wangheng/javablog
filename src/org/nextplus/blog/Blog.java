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

public class Blog extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public Blog() {
		super();
	}

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String method = request.getParameter("method");

		HttpSession session = request.getSession();
		UserContent userContent = (UserContent) session
				.getAttribute("userContent");
		if (userContent == null) {
			response.sendRedirect("/nextplus-blog/admin/login.jsp");
		} else {
			
			if (method.equals("edit")) {
				preEdit(request, response);
			} else if (method.equals("update")) {
				update(request, response);
			} else if (method.equals("delete")) {
				delete(request, response);
			} else if (method.equals("list")) {
				list(request, response);
			} else if (method.equals("add")) {
				add(request, response);
			} else {
				list(request, response);
			}
		}

	}

	public void add(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String title = request.getParameter("title");
		String categoryID = request.getParameter("category");
		String content = request.getParameter("content");
		DataSource ds = null;
		int result = 0;
		try {
			Context context = new InitialContext();
			ds = (DataSource) context.lookup("java:comp/env/jdbc/blog");
		} catch (Exception e) {
			System.out.println("获取blog数据源错误！");
		}
		try {
			String sql = "insert into blog (title,content,category_id,createdtime) values (?,?,?,now())";
			Object params[] = { title, content, categoryID };
			QueryRunner qr = new QueryRunner(ds);
			result = qr.update(sql, params); // query()
		} catch (SQLException e) {
			e.printStackTrace();
		}
		String message = "";
		if (result == 1) {
			message = "添加博文成功！";
		} else {
			message = "添加博文失败！";
		}
		request.setAttribute("message", message);
		request.getRequestDispatcher("/Blog?method=list").forward(request,
				response);
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	public void preEdit(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String id = request.getParameter("id");
		DataSource ds = null;
		try {
			Context context = new InitialContext();
			ds = (DataSource) context.lookup("java:comp/env/jdbc/blog");
		} catch (Exception e) {
			System.out.println("获取blog数据源错误！");
		}
		BlogContent blogContent = null;
		try {
			String sql = "select id, title, content from blog where id=" + id;
			QueryRunner qr = new QueryRunner(ds);
			List<BlogContent> list = (List<BlogContent>) qr.query(sql,
					new BeanListHandler(BlogContent.class));
			blogContent = (BlogContent) list.get(0);

		} catch (SQLException e) {
			e.printStackTrace();
		}
		List<Category> list = null;
		try {
			String sql = "select * from category order by level desc,id desc";
			QueryRunner qr = new QueryRunner(ds);
			list = (List<Category>) qr.query(sql, new BeanListHandler(
					Category.class));
		} catch (SQLException e) {
			e.printStackTrace();
		}
		request.setAttribute("blogContent", blogContent);
		request.setAttribute("list", list);
		request.getRequestDispatcher("/admin/editBlog.jsp").forward(request,
				response);

	}

	public void update(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		String id = request.getParameter("id");

		String sql = "update blog set title=?, content=? where id=?";
		Object params[] = { title, content, id };

		int result = 0;
		DataSource ds = null;
		try {
			Context context = new InitialContext();
			ds = (DataSource) context.lookup("java:comp/env/jdbc/blog");
		} catch (Exception e) {
			System.out.println("获取blog数据源错误！");
		}
		try {
			QueryRunner qr = new QueryRunner(ds);
			result = qr.update(sql, params);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		String message = "";
		if (result == 1) {
			message = "修改博文成功！";
		} else {
			message = "修改博文失败！";
		}
		request.setAttribute("message", message);
		request.getRequestDispatcher("/admin/result.jsp").forward(request,
				response);

	}

	public void delete(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String id = request.getParameter("id");
		DataSource ds = null;
		try {
			Context context = new InitialContext();
			ds = (DataSource) context.lookup("java:comp/env/jdbc/blog");
		} catch (Exception e) {
			System.out.println("获取blog数据源错误！");
		}
		try {
			String sql = "delete from blog where id=" + id;
			QueryRunner qr = new QueryRunner(ds);
			qr.update(sql);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		request.getRequestDispatcher("/Blog?method=list").forward(request,
				response);

	}

	public void list(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		DataSource ds = null;
		try {
			Context context = new InitialContext();
			ds = (DataSource) context.lookup("java:comp/env/jdbc/blog");
		} catch (Exception e) {
			System.out.println("获取blog数据源错误！");
		}
		try {
			String sql = "select id, title, content, createdtime as createdTime from blog order by id desc";
			QueryRunner qr = new QueryRunner(ds);
			@SuppressWarnings({ "unchecked", "rawtypes" })
			List<BlogContent> list = (List<BlogContent>) qr.query(sql,
					new BeanListHandler(BlogContent.class));

			request.setAttribute("list", list);
			request.getRequestDispatcher("/admin/manageBlogList.jsp").forward(
					request, response);
		} catch (SQLException e) {
			e.printStackTrace();
		}

	}
}
