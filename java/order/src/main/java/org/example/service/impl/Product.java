package org.example.service.impl;

import lombok.extern.slf4j.Slf4j;
import org.example.service.IProduct;
import org.springframework.stereotype.Component;

@Component
@Slf4j
public class Product implements IProduct {
    @Override
    public void hello() {
        log.info("hello");
    }
}
