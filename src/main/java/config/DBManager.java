package config;



import org.apache.tomcat.jdbc.pool.DataSource;
public class DBManager {
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
}
