package com.itis.instagram.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.UUID;

@Controller
public class ChatController {
    @GetMapping("/chatMessages")
    public String getChat(Model model) {
        model.addAttribute("pageId", UUID.randomUUID().toString());
        return "chatMessages";
    }
}
