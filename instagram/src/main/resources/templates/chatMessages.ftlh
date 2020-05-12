<#include "parts/navbar.ftlh">
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Chat</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" integrity="sha384-WskhaSGFgHYWDcbwN70/dfYBj47jz9qbsMId/iRN3ewGhXQFZCSftd1LZCfmhktB" crossorigin="anonymous">

</head>
<body onload="connect()">

<script src="https://code.jquery.com/jquery-3.4.1.js"
        integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
        crossorigin="anonymous"></script>
<script>
    var webSocket;

    function connect() {
        webSocket = new WebSocket("ws://localhost:8080/chat");
        webSocket.onmessage = function receiveMessage(response) {
            let data = response['data'];
            let json = JSON.parse(data);
            $('#messageList').first().after("<li>" + json['text'] + "</li>")
        }
    }

    function sendMessage(text, pageId) {
        let message = {
            "text": text,
            "from": pageId
        };

        webSocket.send(JSON.stringify(message));
    }
</script>
<br>
<div class="container">
    <div class="form-group">
    <h3>Welcome to anon chat</h3>
    <label for="message"></label>
    <input type="text" class="form-control" name="message" id="message" placeholder="Message">
    <br>
    <button class="btn btn-primary" onclick="sendMessage($('#message').val(), '${pageId}')">Send
    </button>
    <h3>Chat</h3>
    <ul id="messageList">
        </ul>
        </div>
    </div>

</body>
</html>