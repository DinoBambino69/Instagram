package com.itis.instagram.handler;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.itis.instagram.domain.dto.ChatDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.WebSocketMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import java.util.HashMap;
import java.util.Map;

@Component
public class WebSocketMessagesHandler extends TextWebSocketHandler {

    private static final Map<String, WebSocketSession> sessions = new HashMap<>();

    @Autowired
    private ObjectMapper objectMapper;

    @Override
    public void handleMessage(WebSocketSession session, WebSocketMessage<?> message) throws Exception {
        String messageText = (String) message.getPayload();
        ChatDto messageFromJson = objectMapper.readValue(messageText, ChatDto.class);

        if (!sessions.containsKey(messageFromJson.getFrom())) {
            sessions.put(messageFromJson.getFrom(), session);
        }

        for (WebSocketSession currentSession : sessions.values()) {
            currentSession.sendMessage(message);
        }
    }
}











