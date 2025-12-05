package com.example.userservice.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * Order Information DTO
 * 
 * @author lijianwei
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class OrderInfo implements Serializable {

    private static final long serialVersionUID = 1L;

    private String orderId;
    private String orderName;
    private Double amount;
    private String status;
    private LocalDateTime createTime;
}
