package config;

import org.apache.tomcat.jdbc.pool.DataSource;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import dao.BoardDAO;
import dao.MemberDAO;

@Configuration
public class DIContext {
	@Bean(destroyMethod = "close")
	public DataSource source() {
		DataSource dataSource =  new DataSource();
        dataSource.setDriverClassName("oracle.jdbc.OracleDriver");
        dataSource.setUrl("jdbc:oracle:thin:@175.197.213.135:32769:xe");
        dataSource.setUsername("scott");
        dataSource.setPassword("tiger");
        dataSource.setInitialSize(5);
        dataSource.setMaxActive(10);
        return dataSource;
	}
	@Bean
	public BoardDAO boardDao() {
			return new BoardDAO(source());
	}
	@Bean
	public MemberDAO memberDao() {
		return new MemberDAO(source());
	}
	
}
