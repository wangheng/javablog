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

public class DealCategory extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public DealCategory() {
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
		List<Category> list = null;
		try {
			String sql = "select * from category order by level desc,id desc";
			QueryRunner qr = new QueryRunner(ds);
			list = (List<Category>) qr.query(sql, new BeanListHandler(
					Category.class));
			request.setAttribute("list", list);
			request.getRequestDispatcher("/admin/manageCategoryList.jsp")
					.forward(request, response);
		} catch (SQLException e) {
			e.printStackTrace();
		}

	}

	public void add(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String name = request.getParameter("name");
		String level = request.getParameter("level");
		DataSource ds = null;
		try {
			Context context = new InitialContext();
			ds = (DataSource) context.lookup("java:comp/env/jdbc/blog");
		} catch (Exception e) {
			System.out.println("获取blog数据源错误！");
		}
		int result = 0;
		try {
			String sql = "insert into category (name, level) values (?,?)";
			Object params[] = { name, level };
			QueryRunner qr = new QueryRunner(ds);
			result = qr.update(sql, params);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		String message = "";
		if (result == 1) {
			message = "添加博文分类成功！";
		} else {
			message = "添加博文分类失败！";
		}
		request.setAttribute("message", message);
		request.getRequestDispatcher("/DealCategory?method=list").forward(request,
				response);

	}

	public void delete(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String id = request.getParameter("id");
		String sql = "delete from category where id=" + id;
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

		request.getRequestDispatcher("/DealCategory?method=list").forward(
				request, response);

	}

	public void preEdit(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String id = request.getParameter("id");
		String sql = "select * from category where id=" + id;
		DataSource ds = null;
		Category category = null;
		try {
			Context context = new InitialContext();
			ds = (DataSource) context.lookup("java:comp/env/jdbc/blog");
		} catch (Exception e) {
			System.out.println("获取blog数据源错误！");
		}
		try {
			QueryRunner qr = new QueryRunner(ds);
			@SuppressWarnings({ "rawtypes", "unchecked" })
			List<Category> list = (List<Category>) qr.query(sql,
					new BeanListHandler(Category.class));
			category = (Category) list.get(0);

		} catch (SQLException e) {
			e.printStackTrace();
		}
		request.setAttribute("category", category);
		request.getRequestDispatcher("/admin/editCategory.jsp").forward(
				request, response);

	}

	public void update(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String name = request.getParameter("name");
		String level = request.getParameter("level");
		String id = request.getParameter("id");
		DataSource ds = null;
		try {
			Context context = new InitialContext();
			ds = (DataSource) context.lookup("java:comp/env/jdbc/blog");
		} catch (Exception e) {
			System.out.println("获取blog数据源错误！");
		}
		try {
			String sql = "update category set name=?, level=? where id=?";
			Object params[] = { name, level, id };
			QueryRunner qr = new QueryRunner(ds);
			qr.update(sql, params);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		request.getRequestDispatcher("/DealCategory?method=list").forward(
				request, response);

	}

}
