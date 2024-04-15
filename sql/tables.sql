CREATE DATABASE order_sys;
USE order_sys;
CREATE TABLE product (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE ,
    number VARCHAR(255) NOT NULL,
    is_deleted BOOLEAN DEFAULT false,
    created_at DATETIME,
    updated_at DATETIME,
    category_id BIGINT,
    price INT
);

CREATE TABLE product_picture(
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    url VARCHAR(255),
    product_id BIGINT NOT NULL ,
    FOREIGN KEY (product_id) REFERENCES product(id)
);

CREATE TABLE product_video(
    id BIGINT AUTO_INCREMENT PRIMARY KEY ,
    url VARCHAR(255),
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
    property VARCHAR(255),
    sku VARCHAR(255),
    FOREIGN KEY (sku) REFERENCES product_sku(sku)
);

CREATE TABLE product_category(
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL ,
    parent_id BIGINT,
    created_at DATETIME,
    updated_at DATETIME,
    is_deleted BOOLEAN DEFAULT false,
    FOREIGN KEY (parent_id) REFERENCES product_category(id)
);

CREATE TABLE member (
    id BIGINT AUTO_INCREMENT PRIMARY KEY ,
    is_activated BOOLEAN,
    created_at DATETIME,
    updated_at DATETIME,
    score INT DEFAULT 0,
    growth INT DEFAULT 0,
    avatar VARCHAR(255),
    phone VARCHAR(255),
    nickname VARCHAR(255)
);

CREATE TABLE member_property(
    id BIGINT AUTO_INCREMENT PRIMARY KEY ,
    name VARCHAR(255) UNIQUE ,
    type VARCHAR(255),
    is_required BOOLEAN,
    should_encrypt BOOLEAN,
    created_at DATETIME,
    updated_at DATETIME,
    is_deleted BOOLEAN,
    rule VARCHAR(255)
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
    created_at DATETIME,
    updated_at DATETIME,
    is_deleted BOOLEAN,
    name VARCHAR(255),
    is_default BOOLEAN
);

CREATE TABLE member_tag(
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    group_id BIGINT,
    FOREIGN KEY (id) REFERENCES member_tag_group(id)
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
    phone VARCHAR(255),
    country VARCHAR(255),
    province VARCHAR(255),
    city VARCHAR(255),
    district VARCHAR(255),
    detail VARCHAR(255),
    longitude DOUBLE(10, 5),
    latitude DOUBLE(10, 5),
    FOREIGN KEY (member_id) REFERENCES member(id)
);

CREATE TABLE `order`(
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    member_id BIGINT,
    number varchar(255),
    total_amount INT,
    pay_amount INT,
    pay_score INT,
    status VARCHAR(255),
    refund_status VARCHAR(255),
    remarks VARCHAR(255),
    created_at DATETIME,
    updated_at DATETIME,
    is_deleted BOOLEAN,
    member_deleted BOOLEAN,
    address_id BIGINT,
    FOREIGN KEY (address_id) REFERENCES member_address(id),
    FOREIGN KEY (member_id) REFERENCES member(id)
);

CREATE TABLE order_history(
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    order_id BIGINT,
    status VARCHAR(255),
    created_at DATETIME,
    FOREIGN KEY (order_id) REFERENCES `order`(id)
);

CREATE TABLE order_product(
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    order_id BIGINT,
    product_id BIGINT,
    refund_status VARCHAR(255),
    sku VARCHAR(255),
    total_amount INT,
    pay_amount INT,
    total INT,
    FOREIGN KEY (sku) REFERENCES product_sku(sku),
    FOREIGN KEY (product_id) REFERENCES product(id),
    FOREIGN KEY (order_id) REFERENCES `order`(id)
);

CREATE TABLE order_refund(
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    order_id BIGINT,
    member_id BIGINT,
    number VARCHAR(255),
    status VARCHAR(255),
    created_at DATETIME,
    updated_at DATETIME,
    FOREIGN KEY (member_id) REFERENCES member(id),
    FOREIGN KEY (order_id) REFERENCES `order`(id)
);

CREATE TABLE order_refund_history(
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    refund_id BIGINT,
    status VARCHAR(255),
    created_at DATETIME,
    FOREIGN KEY (refund_id) REFERENCES order_refund(id)
);

CREATE TABLE order_refund_product(
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    refund_id BIGINT,
    product_id BIGINT,
    sku VARCHAR(255),
    refund_amount INT,
    refund_score INT,
    total INT,
    FOREIGN KEY (product_id) REFERENCES product(id),
    FOREIGN KEY (sku) REFERENCES product_sku(sku),
    FOREIGN KEY (refund_id) REFERENCES order_refund(id)
);