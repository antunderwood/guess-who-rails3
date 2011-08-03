module MessagesHelper
  def display_message(message)
    message_js = "api.getContentPane().prepend('<div class=\"cssbox-blue\"><div class=\"cssbox_head-blue\"> <h2>"
    message_js << message.player.name
    message_js << "&nbsp;"
    message_js << "<img src=\"../images/question_mark_button_small.png\"/><"
    message_js << "/h2></div> <div class=\"cssbox_body-blue\">"
    message_js << escape_javascript(message.content) +
    message_js << "</div></div>');api.reinitialise();"
  end
end
