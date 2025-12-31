package com.bluemoon.fees.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/ping")
public class PingController {
    @RequestMapping
    public String ping() {
        return "pong";
    }
}
