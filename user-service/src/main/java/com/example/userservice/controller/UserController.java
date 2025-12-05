package com.example.userservice.controller;

import com.example.userservice.client.OrderServiceClient;
import com.example.userservice.dto.OrderInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.Map;

/**
 * User Controller
 * Provides user-related endpoints and demonstrates Feign client usage
 * 
 * @author lijianwei
 */
@RestController
@RequestMapping("/user")
public class UserController {

    @Autowired
    private OrderServiceClient orderServiceClient;

    /**
     * Get order information via Feign client
     * This endpoint can be tested with Postman: GET
     * http://localhost:8081/user/orderInfo
     * 
     * @return Map containing user info and order info from order-service
     */
    @GetMapping("/orderInfo")
    public Map<String, Object> getUserOrderInfo() {
        Map<String, Object> result = new HashMap<>();

        // Get order info from order-service via Feign
        OrderInfo orderInfo = orderServiceClient.getOrderInfo();

        // Build response
        result.put("success", true);
        result.put("message", "Successfully retrieved order info via Feign");
        result.put("userId", "USER-001");
        result.put("userName", "Zhang San");
        result.put("orderInfo", orderInfo);

        return result;
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
        result.put("service", "user-service");
        return result;
    }
}
