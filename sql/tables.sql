DROP DATABASE order_sys;
CREATE DATABASE order_sys;
USE order_sys;

CREATE TABLE product (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    number VARCHAR(255) NOT NULL,
    is_deleted BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    category_id BIGINT DEFAULT 0,
    price INT DEFAULT 0
);

CREATE TABLE product_picture(
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    url VARCHAR(255) NOT NULL ,
    product_id BIGINT,
    FOREIGN KEY (product_id) REFERENCES product(id)
);

CREATE TABLE product_video(
    id BIGINT AUTO_INCREMENT PRIMARY KEY ,
    url VARCHAR(255) NOT NULL ,
    product_id BIGINT,
    FOREIGN KEY (product_id) REFERENCES product(id)
);

CREATE TABLE product_sku(
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    sku VARCHAR(255) NOT NULL UNIQUE ,
    product_id BIGINT,
    FOREIGN KEY (product_id) REFERENCES product(id)
);

CREATE TABLE sku_properties(
    id BIGINT AUTO_INCREMENT PRIMARY KEY ,
    property VARCHAR(255) NOT NULL ,
    sku VARCHAR(255),
    FOREIGN KEY (sku) REFERENCES product_sku(sku)
);

CREATE TABLE product_category(
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL ,
    parent_id BIGINT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    is_deleted BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (parent_id) REFERENCES product_category(id)
);

CREATE TABLE member (
    id BIGINT AUTO_INCREMENT PRIMARY KEY ,
    is_activated BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    score INT DEFAULT 0,
    growth INT DEFAULT 0,
    avatar VARCHAR(255) DEFAULT '',
    phone VARCHAR(255) DEFAULT '',
    nickname VARCHAR(255) DEFAULT ''
);

CREATE TABLE member_property(
    id BIGINT AUTO_INCREMENT PRIMARY KEY ,
    name VARCHAR(255) UNIQUE ,
    type VARCHAR(255) NOT NULL ,
    is_required BOOLEAN DEFAULT FALSE,
    should_encrypt BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    is_deleted BOOLEAN DEFAULT FALSE,
    rule VARCHAR(255) DEFAULT ''
);

CREATE TABLE property_in_member(
    id BIGINT AUTO_INCREMENT PRIMARY KEY ,
    member_id BIGINT,
    property_id BIGINT,
    int_value INT,
    str_value VARCHAR(255),
    bool_value BOOLEAN,
    double_value DOUBLE(16, 8),
    FOREIGN KEY (member_id) REFERENCES member(id),
    FOREIGN KEY (property_id) REFERENCES member_property(id)
);

CREATE TABLE member_tag_group(
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    is_deleted BOOLEAN DEFAULT FALSE,
    name VARCHAR(255) NOT NULL ,
    is_default BOOLEAN DEFAULT FALSE
);

CREATE TABLE member_tag(
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL ,
    group_id BIGINT,
    FOREIGN KEY (group_id) REFERENCES member_tag_group(id)
);

CREATE TABLE tag_in_member(
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    member_id BIGINT,
    tag_id BIGINT,
    FOREIGN KEY (member_id) REFERENCES member(id),
    FOREIGN KEY (tag_id) REFERENCES member_tag(id)
);

CREATE TABLE member_address(
    id BIGINT AUTO_INCREMENT PRIMARY KEY ,
    member_id BIGINT,
    phone VARCHAR(255) DEFAULT '',
    country VARCHAR(255) DEFAULT '',
    province VARCHAR(255) DEFAULT '',
    city VARCHAR(255) DEFAULT '',
    district VARCHAR(255) DEFAULT '',
    detail VARCHAR(255) DEFAULT '',
    longitude DOUBLE(10, 5) DEFAULT 0,
    latitude DOUBLE(10, 5) DEFAULT 0,
    FOREIGN KEY (member_id) REFERENCES member(id)
);

CREATE TABLE `order`(
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    member_id BIGINT,
    number varchar(255) NOT NULL ,
    total_amount INT DEFAULT 0,
    pay_amount INT DEFAULT 0,
    pay_score INT DEFAULT 0,
    status VARCHAR(255) NOT NULL ,
    refund_status VARCHAR(255) DEFAULT '',
    remarks VARCHAR(255) DEFAULT '',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    is_deleted BOOLEAN DEFAULT FALSE,
    member_deleted BOOLEAN DEFAULT FALSE,
    address_id BIGINT,
    FOREIGN KEY (address_id) REFERENCES member_address(id),
    FOREIGN KEY (member_id) REFERENCES member(id)
);

CREATE TABLE order_history(
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    order_id BIGINT,
    status VARCHAR(255) NOT NULL ,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES `order`(id)
);

CREATE TABLE order_product(
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    order_id BIGINT,
    product_id BIGINT,
    refund_status VARCHAR(255) DEFAULT '',
    sku VARCHAR(255),
    total_amount INT DEFAULT 0,
    pay_amount INT DEFAULT 0,
    total INT NOT NULL ,
    FOREIGN KEY (sku) REFERENCES product_sku(sku),
    FOREIGN KEY (product_id) REFERENCES product(id),
    FOREIGN KEY (order_id) REFERENCES `order`(id)
);

CREATE TABLE order_refund(
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    order_id BIGINT,
    member_id BIGINT,
    number VARCHAR(255) NOT NULL ,
    status VARCHAR(255) NOT NULL ,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (member_id) REFERENCES member(id),
    FOREIGN KEY (order_id) REFERENCES `order`(id)
);

CREATE TABLE order_refund_history(
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    refund_id BIGINT,
    status VARCHAR(255) NOT NULL ,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (refund_id) REFERENCES order_refund(id)
);

CREATE TABLE order_refund_product(
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    refund_id BIGINT,
    product_id BIGINT,
    sku VARCHAR(255),
    refund_amount INT DEFAULT 0,
    refund_score INT DEFAULT 0,
    total INT NOT NULL ,
    FOREIGN KEY (product_id) REFERENCES product(id),
    FOREIGN KEY (sku) REFERENCES product_sku(sku),
    FOREIGN KEY (refund_id) REFERENCES order_refund(id)
);