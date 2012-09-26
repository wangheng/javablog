package org.nextplus.blog;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import org.apache.commons.dbutils.QueryRunner;

public class DbHandler {

	public static QueryRunner getQueryRunner() {
		@SuppressWarnings("unused")
		DataSource ds = null;// 数据源对象，连接池的管理员
		try {
			// 通过在context.xml文件中的数据源名字获取数据源对象
			Context context = new InitialContext();
			ds = (DataSource) context.lookup("java:comp/env/jdbc/blog");
		} catch (Exception e) {
			System.out.println("获取blog数据源错误！");
		}
		QueryRunner qr = new QueryRunner();
		return qr;

	}

}
