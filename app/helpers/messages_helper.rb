module MessagesHelper
  def display_message(message)
    message_js = "api.getContentPane().prepend('<div class=\""
    if message.player.id == message.game.first_turn
      message_js << "cssbox-blue\"><div class=\"cssbox_head-blue"
    else
      message_js << "cssbox-red\"><div class=\"cssbox_head-red"
    end
    message_js << "\"> <h2>"
    message_js << message.player.name
    message_js << "&nbsp;"
    message_js << "<img src=\"../images/question_mark_button_small.png\"/><"
    message_js << "/h2></div> <div class=\""
    logger.info message.player.id
    logger.info message.game.first_turn
    if message.player.id == message.game.first_turn
      message_js << "cssbox_body-blue\">"
    else
      message_js << "cssbox_body-red\">"
    end
    message_js << escape_javascript(message.content)
    message_js << " #{message.game.state}"
    message_js << "</div></div>');api.reinitialise();"
  end
end
