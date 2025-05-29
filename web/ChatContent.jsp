<%@page import="java.sql.*"%>
<%@page import="connection.DBConnection"%>
<%
    String Uname = (String) session.getAttribute("Name");
    int lastId = 0;
    if(request.getParameter("lastId") != null) {
        try {
            lastId = Integer.parseInt(request.getParameter("lastId"));
        } catch(Exception e) { lastId = 0; }
    }
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    int maxId = lastId;
    boolean hasMessages = false;

    // Cache for quick lookup of id->message for replies (in practice, optimize by querying only needed ids)
    java.util.Map<Integer, String> msgTextMap = new java.util.HashMap<>();
    java.util.Map<Integer, String> msgSenderMap = new java.util.HashMap<>();
    try {
        // Preload all messages for reply lookup
        con = DBConnection.getConnection();
        Statement allStmt = con.createStatement();
        ResultSet allRs = allStmt.executeQuery("SELECT id, sender, message FROM chat");
        while (allRs.next()) {
            msgTextMap.put(allRs.getInt("id"), allRs.getString("message"));
            msgSenderMap.put(allRs.getInt("id"), allRs.getString("sender"));
        }
        allRs.close();
        allStmt.close();

        String query = "SELECT * FROM chat WHERE id > ? ORDER BY id ASC";
        ps = con.prepareStatement(query);
        ps.setInt(1, lastId);
        rs = ps.executeQuery();

        String prevSender = null;
        while(rs.next()) {
            hasMessages = true;
            int msgId = rs.getInt("id");
            String sender = rs.getString("sender");
            String msg = rs.getString("message");
            String time = rs.getString("chat_time");
            String imageUrl = rs.getString("image_url");
            int replyTo = rs.getInt("reply_to");
            boolean showSenderName = !sender.equals(prevSender);

            if(msgId > maxId) maxId = msgId;

            // Prepare reply bubble if exists
            String replyHtml = "";
            if(replyTo > 0 && msgTextMap.get(replyTo) != null) {
                String replyMsg = msgTextMap.get(replyTo);
                String replySender = msgSenderMap.get(replyTo);
                replyHtml = "<div style='background:#282828;border-radius:6px;padding:3px 8px;margin-bottom:5px; font-size:13px; color:#9cf;'>"
                          + "<b>"+(replySender!=null?replySender:"") + ":</b> "
                          + (replyMsg.length()>80?replyMsg.substring(0,80)+"...":replyMsg)
                          + "</div>";
            }

            // Multiple Images
            String imgsHtml = "";
            if (imageUrl != null && !imageUrl.trim().isEmpty()) {
                String[] imgs = imageUrl.split(",");
                for (String img : imgs) {
                    imgsHtml += "<a href='" + img.trim() + "' target='_blank'>"
                              + "<img src='" + img.trim() + "' style='max-width:200px; max-height:200px; display:block; margin-top:5px; border-radius:8px; cursor:pointer;' />"
                              + "</a>";
                }
            }

            // Message bubble
            String bubbleClass = (Uname != null && Uname.equals(sender)) ? "sender" : "receiver";
            String floatStyle = (bubbleClass.equals("sender")) ? "float: right;" : "float: left;";
%>
    <div class="chat-msg <%=bubbleClass%>" data-msg-id="<%=msgId%>"
        style="display: inline-block; max-width: 70%; margin: 5px; <%=floatStyle%> clear: both; word-break: break-word;">
        <li style="list-style-type: none; font-size: 15px; position:relative;">
            <%= replyHtml %>
            <% if (msg != null && !msg.trim().isEmpty()) { %>
                <b class="msg-content d-block"><%=msg%></b>
            <% } %>
            <%= imgsHtml %>
            <em class="d-block text-end" style="font-size: 10px;"><%=time%></em>
            <button type="button" class="reply-btn" style="background:none;border:none;position:absolute;top:0;right:-26px;color:#028cdb;font-size:18px;" title="Reply">&#8617;</button>
        </li>
    </div>
<%
            prevSender = sender;
        }
    } catch(Exception e) {
        out.println("Error loading messages: " + e.getMessage());
    } finally {
        if(rs != null) try { rs.close(); } catch(Exception ex) {}
        if(ps != null) try { ps.close(); } catch(Exception ex) {}
    }
%>
<input type="hidden" id="lastMessageId" value="<%=maxId %>" />