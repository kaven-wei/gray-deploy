package com.example.orderservice.controller;

import com.example.orderservice.dto.OrderInfo;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;

/**
 * Order Controller
 * Provides order-related endpoints
 * 
 * @author lijianwei
 */
@RestController
@RequestMapping("/order")
public class OrderController {

    /**
     * Get order information
     * This endpoint can be tested with Postman: GET
     * http://localhost:8082/order/info
     * 
     * @return OrderInfo object containing order details
     */
    @GetMapping("/info")
    public OrderInfo getOrderInfo() {
        // Create and return mock order data
        OrderInfo orderInfo = new OrderInfo();
        orderInfo.setOrderId("ORD-20251202-001");
        orderInfo.setOrderName("Spring Boot Books Bundle");
        orderInfo.setAmount(299.99);
        orderInfo.setStatus("CONFIRMED");
        orderInfo.setCreateTime(LocalDateTime.now());

        return orderInfo;
    }

    /**
     * Health check endpoint
     * 
     * @return service status
     */
    @GetMapping("/health")
    public Map<String, String> health() {
        Map<String, String> result = new HashMap<>();
        result.put("status", "UP");
        result.put("service", "order-service");
        return result;
    }
}
