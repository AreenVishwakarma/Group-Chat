<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chat Room</title>
    <!-- Bootstrap CSS + Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>    
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <style>
        body {
            margin: 0;
            padding-bottom: 70px; /* Space for fixed input */
            background-image: url('img/wp8092590.jpg');
            background-size: cover;
            background-attachment: fixed;
            background-repeat: no-repeat;
        }

        .form {
            position: fixed;
            bottom: 0;
            width: 100%;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 8px;
            background-color: #292929;
            gap: 8px;
            z-index: 1000;
        }

        .sendMsg {
            flex: 1;
            height: 45px;
            background-color: #292929;
            color: white;
            border: 1px solid #555;
            border-radius: 8px;
            padding: 0 12px;
            font-size: 16px;
        }

        .sendBtn {
            height: 45px;
            min-width: 75px;
            background-color: #444;
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            cursor: pointer;
        }

        .sendBtn:hover {
            background-color: #555;
        }

        .sender {
            font-family: "Roboto", sans-serif;
            color: white;
            padding: 10px; 
            border-radius: 10px;
            background-color: #48963f;
            margin: 5px 10px;
            max-width: 75%;
            align-self: flex-end;
        }

        .receiver {
            font-family: "Roboto", sans-serif;
            color: white;
            padding: 10px; 
            border-radius: 10px;
            background-color: #616161;
            margin: 5px 10px;
            max-width: 75%;
            align-self: flex-start;
        }

        #message-container {
            height: calc(100vh - 130px);
            overflow-y: auto;
            padding: 10px;
            display: flex;
            flex-direction: column;
        }

        nav {
            width: 100%;
            height: 65px;
            background-color: #292929;
            color: white;
            display: flex;
            align-items: center;
            padding: 0 15px;
            justify-content: space-between;
        }

        .logoutBtn {
            background: none;
            border: none;
            color: white;
            font-size: 24px;
        }

        @media (max-width: 600px) {
            .form {
                flex-direction: column;
            }

            .sendMsg, .sendBtn {
                width: 100%;
            }
        }
    </style>

<!--<script type="text/javascript">
    var lastMessageId = 0;

    function loadMessages(initialLoad = false) {
        $.ajax({
            url: "ChatContent.jsp",
            method: "GET",
            cache: false,
            success: function (data) {
                const tempDiv = $("<div>").html(data);
                const newLastId = parseInt(tempDiv.find("#lastMessageId").val() || 0);

                if (initialLoad || newLastId > lastMessageId) {
                    $("#message-container").html(tempDiv.html());
                    lastMessageId = newLastId;
                    $("#message-container").scrollTop($("#message-container")[0].scrollHeight);
                }
            },
            error: function (xhr, status, error) {
                console.error("Error loading messages:", error);
            }
        });
    }

    $(document).ready(function () {
        loadMessages(true);
        setInterval(() => loadMessages(false), 1000);

        $(".form").on("submit", function (e) {
            e.preventDefault();
            const msg = $("input[name='message']").val();
            if (msg.trim() === "") return;

            $.post("SendMsg", { message: msg }, function () {
                $("input[name='message']").val("");
                loadMessages(true);
            });
        });
    });
</script>-->
<script type="text/javascript">
var lastMessageId = 0;

function loadMessages(initialLoad = false) {
    $.ajax({
        url: "ChatContent.jsp",
        method: "GET",
        cache: false,
        success: function (data) {
            const tempDiv = $("<div>").html(data);
            const newLastId = parseInt(tempDiv.find("#lastMessageId").val() || 0);

            if (initialLoad || newLastId > lastMessageId) {
                $("#message-container").html(tempDiv.html());
                lastMessageId = newLastId;
                $("#message-container").scrollTop($("#message-container")[0].scrollHeight);

                // Re-attach reply click handlers after loading messages
                $(".reply-btn").off("click").on("click", function(e){
                    e.stopPropagation();
                    var msgId = $(this).closest(".chat-msg").data("msg-id");
                    var msgText = $(this).closest(".chat-msg").find(".msg-content").text().trim();
                    $("#replyToInput").val(msgId);
                    $("#replyMsgContent").text(msgText.length > 100 ? msgText.substring(0,100)+'...' : msgText);
                    $("#replyPreview").show();
                });
            }
        },
        error: function (xhr, status, error) {
            console.error("Error loading messages:", error);
        }
    });
}

$(document).ready(function () {
    loadMessages(true);
    setInterval(() => loadMessages(false), 1000);

    // Show count of selected images
    $("#imagesInput").on("change", function() {
        $("#imgCount").text(this.files.length);
    });

    // Cancel reply UI
    $("#cancelReply").on("click", function() {
        $("#replyToInput").val("");
        $("#replyMsgContent").text("");
        $("#replyPreview").hide();
    });

    $(".form").on("submit", function (e) {
        e.preventDefault();
        var formData = new FormData(this);

        // Append all selected images if any
        var files = $("#imagesInput")[0].files;
        if (files.length > 0) {
            for (let i = 0; i < files.length; i++) {
                formData.append("images", files[i]);
            }
        }

        // Only send if text or at least one image is provided
        if (
            (!formData.get("message") || formData.get("message").trim() === "") &&
            files.length === 0
        ) return;

        $.ajax({
            url: "SendMsg",
            type: "POST",
            data: formData,
            processData: false,
            contentType: false,
            success: function () {
                $("input[name='message']").val("");
                $("#imagesInput").val("");
                $("#imgCount").text("0");
                $("#replyToInput").val("");
                $("#replyMsgContent").text("");
                $("#replyPreview").hide();
                loadMessages(true);
            }
        });
    });
});
</script>

</head>
<body>
    <%
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);

        String Uname = (String) session.getAttribute("Name");
        String Uemail = (String) session.getAttribute("Email");

        if (Uname == null || Uemail == null) {
            response.sendRedirect("index.jsp");
            return;
        }
    %>

    <nav>
        <div class="d-flex align-items-center gap-3">
            <i class="bi bi-circle fs-2"></i>
            <div>
                <h5 class="m-0"><%= Uname %></h5>
                <small><%= Uemail %></small>
            </div>
        </div>
        <div class="d-flex align-items-center gap-3">
            <i class="bi bi-search fs-4"></i>
            <form action="logout.jsp" class="m-0">
                <button type="submit" class="logoutBtn" title="Logout">
                    <i class="bi bi-power"></i>
                </button>
            </form>
        </div>
    </nav>

    <div id="message-container">
        <!-- ChatContent.jsp will dynamically inject chat messages here -->
    </div>

<!--    <form class="form">
        <input type="text" name="message" placeholder="Enter your message" class="sendMsg" autocomplete="off">
        <button type="submit" class="sendBtn">Send</button>
    </form>-->
<form class="form" enctype="multipart/form-data">
    <input type="hidden" name="reply_to" id="replyToInput">

    <div id="replyPreview" style="display:none; background:#333; color:#fff; border-radius:6px; margin-bottom:4px; padding:3px 10px;">
        <span id="replyMsgContent"></span>
        <button type="button" id="cancelReply" style="background:none; border:none; color:#fff; float:right;">&times;</button>
    </div>

    <input type="text" name="message" placeholder="Enter your message" class="sendMsg" autocomplete="off">

    <!-- Hidden file input -->
    <input type="file" name="images" id="imagesInput" accept="image/*" multiple style="display: none;">

    <!-- Icon to trigger file input -->
    <label for="imagesInput" style="cursor: pointer; color: white; margin-left: 10px;">
        <i class="bi bi-images" style="font-size: 24px;"></i>
    </label>

    <span id="imgCount" style="color:white;min-width:40px;display:inline-block;">0</span>
    <button type="submit" class="sendBtn">Send</button>
</form>

</body>
</html>

