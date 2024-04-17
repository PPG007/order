package org.example.utils;

import org.hibernate.boot.model.naming.Identifier;
import org.hibernate.boot.model.naming.PhysicalNamingStrategy;
import org.hibernate.engine.jdbc.env.spi.JdbcEnvironment;

import java.util.Locale;

public class SnakeCaseNamingStrategy implements PhysicalNamingStrategy {
    @Override
    public Identifier toPhysicalCatalogName(Identifier logicalName, JdbcEnvironment jdbcEnvironment) {
        return logicalName;
    }

    @Override
    public Identifier toPhysicalSchemaName(Identifier logicalName, JdbcEnvironment jdbcEnvironment) {
        return logicalName;
    }

    @Override
    public Identifier toPhysicalTableName(Identifier logicalName, JdbcEnvironment jdbcEnvironment) {
        return logicalName;
    }

    @Override
    public Identifier toPhysicalSequenceName(Identifier logicalName, JdbcEnvironment jdbcEnvironment) {
        return logicalName;
    }

    @Override
    public Identifier toPhysicalColumnName(Identifier logicalName, JdbcEnvironment jdbcEnvironment) {
        String text = logicalName.getText();
        StringBuilder builder = new StringBuilder(text);
        for (int i = 1; i < builder.length() - 1; i++) {
            if (Character.isLowerCase(builder.charAt(i - 1)) && Character.isUpperCase(builder.charAt(i)) && Character.isLowerCase(builder.charAt(i + 1))) {
                builder.insert(i++, '_');
            }
        }
        return Identifier.toIdentifier(builder.toString().toLowerCase(Locale.ROOT));
    }
}
