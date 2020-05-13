<#import "parts/common.ftlh" as c>

<@c.page>
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
                $('#messageList').first().after("<li>" + json['from'] + ' ' + json['text'] + "</li>")
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
    <h3>Welcome to anon chat</h3>
<div class="container" onload="connect()">
    <label for="message"></label>
    <input type="text" class="form-control" name="message" id="message" placeholder="Message">
    <button type="submit" class="btn btn-primary" onclick="sendMessage($('#message').val(), '${pageId}')">Send</button>
    <h3>Chat</h3>
    <ul id="messageList">

    </ul>
</div>


</@c.page>