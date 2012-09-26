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

public class Comment extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public Comment() {
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
			if (method.equals("add")) {
				add(request, response);
			} else if (method.equals("list")) {
				list(request, response);
			} else if (method.equals("delete")) {
				delete(request, response);
			} else if (method.equals("edit")) {
				preEdit(request, response);
			} else if (method.equals("update")) {
				update(request, response);
			}
		}

	}

	public void add(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String username = request.getParameter("username");
		String content = request.getParameter("content");
		String blog_id = request.getParameter("blog_id");
		if (username == null || username.equals("")) {
			username = "匿名";
		}
		String sql = "insert into comment(username, content, blog_id, createdtime) value(?,?,?, now())";
		Object params[] = { username, content, blog_id };
		DataSource ds = null;
		try {
			Context context = new InitialContext();
			ds = (DataSource) context.lookup("java:comp/env/jdbc/blog");
		} catch (Exception e) {
			System.out.println("获取blog数据源错误！");
		}
		try {
			QueryRunner qr = new QueryRunner(ds);
			qr.update(sql, params);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		response.sendRedirect("/nextplus-blog/GetBlog?id=" + blog_id);

	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public void list(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		DataSource ds = null;
		try {
			Context context = new InitialContext();
			ds = (DataSource) context.lookup("java:comp/env/jdbc/blog");
		} catch (Exception e) {
			System.out.println("获取blog数据源错误！");
		}
		List<CommentContent> list = null;
		try {
			String sql = "select * from comment order by id desc";
			QueryRunner qr = new QueryRunner(ds);
			list = (List<CommentContent>) qr.query(sql, new BeanListHandler(
					CommentContent.class));
			request.setAttribute("list", list);
			request.getRequestDispatcher("/admin/manageCommentList.jsp")
					.forward(request, response);
		} catch (SQLException e) {
			e.printStackTrace();
		}

	}

	public void delete(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String id = request.getParameter("id");
		String sql = "delete from comment where id=" + id;
		DataSource ds = null;
		try {
			Context context = new InitialContext();
			ds = (DataSource) context.lookup("java:comp/env/jdbc/blog");
		} catch (Exception e) {
			System.out.println("获取blog数据源错误！");
		}
		try {
			QueryRunner qr = new QueryRunner(ds);
			qr.update(sql);

		} catch (SQLException e) {
			e.printStackTrace();
		}

		request.getRequestDispatcher("/Comment?method=list").forward(request,
				response);

	}

	public void preEdit(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String id = request.getParameter("id");
		String sql = "select * from comment where id=" + id;
		DataSource ds = null;
		CommentContent cc = null;
		try {
			Context context = new InitialContext();
			ds = (DataSource) context.lookup("java:comp/env/jdbc/blog");
		} catch (Exception e) {
			System.out.println("获取blog数据源错误！");
		}
		try {
			QueryRunner qr = new QueryRunner(ds);
			@SuppressWarnings({ "rawtypes", "unchecked" })
			List<CommentContent> list = (List<CommentContent>) qr.query(sql,
					new BeanListHandler(CommentContent.class));
			cc = (CommentContent) list.get(0);

		} catch (SQLException e) {
			e.printStackTrace();
		}
		request.setAttribute("cc", cc);
		request.getRequestDispatcher("/admin/editComment.jsp").forward(request,
				response);
	}

	public void update(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String name = request.getParameter("username");
		String level = request.getParameter("content");
		String id = request.getParameter("id");
		DataSource ds = null;
		try {
			Context context = new InitialContext();
			ds = (DataSource) context.lookup("java:comp/env/jdbc/blog");
		} catch (Exception e) {
			System.out.println("获取blog数据源错误！");
		}
		try {
			String sql = "update comment set username=?, content=? where id=?";
			Object params[] = { name, level, id };
			QueryRunner qr = new QueryRunner(ds);
			qr.update(sql, params);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		request.getRequestDispatcher("/Comment?method=list").forward(request,
				response);
	}

}
