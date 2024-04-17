import com.mysql.cj.jdbc.Driver;
import org.example.model.TagGroup;
import org.example.utils.SnakeCaseNamingStrategy;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.boot.MetadataSources;
import org.hibernate.boot.registry.StandardServiceRegistry;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;
import org.hibernate.cfg.Configuration;
import org.hibernate.cfg.Environment;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;

import java.time.format.DateTimeFormatter;
import java.util.Properties;
import java.util.TimeZone;

public class TestHibernate {

    private static SessionFactory sessionFactory;

    @BeforeAll
    public static void setup() {
        Properties properties = new Properties();
        properties.put(Environment.JAKARTA_JDBC_DRIVER, Driver.class.getName());
        properties.put(Environment.JAKARTA_JDBC_USER, "koston");
        properties.put(Environment.JAKARTA_JDBC_PASSWORD, "koston.localhost");
        properties.put(Environment.JAKARTA_JDBC_URL, "jdbc:mysql://localhost:3306/order_sys?characterEncoding=utf8&useSSL=false&serverTimezone=Asia/Shanghai");
        properties.put(Environment.SHOW_SQL, "true");
        properties.put(Environment.FORMAT_SQL, "true");
        properties.put(Environment.HIGHLIGHT_SQL, "true");
        properties.put(Environment.CURRENT_SESSION_CONTEXT_CLASS, "thread");
        properties.put(Environment.PHYSICAL_NAMING_STRATEGY, SnakeCaseNamingStrategy.class.getName());
        Configuration configuration = new Configuration();
        configuration.setProperties(properties)
                .addAnnotatedClass(TagGroup.class);
        StandardServiceRegistry registry = new StandardServiceRegistryBuilder()
                .applySettings(configuration.getProperties())
                .build();
        sessionFactory = new MetadataSources(registry)
                .addAnnotatedClass(TagGroup.class)
                .buildMetadata()
                .buildSessionFactory();
    }

    static void clear() {
        Session session = sessionFactory.openSession();
        Transaction transaction = session.beginTransaction();
        session.createQuery("delete from TagGroup").executeUpdate();
        transaction.commit();
        session.close();
    }

    @Test
    void createTagGroup() {
        clear();
        TagGroup group = TagGroup.builder().name("测试群组1").isDefault(false).build();
        Session session = sessionFactory
                .withOptions()
                .jdbcTimeZone(TimeZone.getTimeZone("UTC"))
                .openSession();
        session.save(group);
        session.close();
    }

    @Test
    void listTagGroups() {
        Session session = sessionFactory
                .withOptions()
                .jdbcTimeZone(TimeZone.getTimeZone("UTC"))
                .openSession();
        session.createSelectionQuery("from TagGroup", TagGroup.class).list().forEach(group -> {
            System.out.println(group.getCreatedAt().format(DateTimeFormatter.ISO_OFFSET_DATE_TIME));
        });
        session.close();
    }
}
