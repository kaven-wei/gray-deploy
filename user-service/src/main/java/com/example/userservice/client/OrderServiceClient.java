package com.example.userservice.client;

import com.example.userservice.dto.OrderInfo;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;

/**
 * Feign client for calling order-service
 * The URL is read from application.yml property: order-service.url
 * This allows flexible configuration for different environments (local, K8s,
 * etc.)
 * 
 * @author lijianwei
 */
@FeignClient(name = "order-service", url = "${order-service.url:}")
public interface OrderServiceClient {

    /**
     * Call order-service's /order/info endpoint
     * 
     * @return OrderInfo object
     */
    @GetMapping("/order/info")
    OrderInfo getOrderInfo();
}
