module MessagesHelper
  def display_message(message)
    message_js = "api.getContentPane().prepend('<div class=\""
    if message.message_type == "notification"
       message_js << "cssbox-green\"><div class=\"cssbox_head-green"
    elsif message.player.id == message.game.first_turn
      message_js << "cssbox-blue\"><div class=\"cssbox_head-blue"
    else
      message_js << "cssbox-red\"><div class=\"cssbox_head-red"
    end
    message_js << "\"> <h2>"
    if message.message_type == "notification"
       message_js << "Notice"
    else
     message_js << message.player.name
    end
    message_js << "&nbsp;"
    message_js << "<img src=\"/images/question_mark_button_small.png\"/>" if message.message_type == "question"
    message_js << "<img src=\"/images/chat_button.png\"/>" if message.message_type == "chat"
    message_js << "</h2></div> <div class=\""
    if message.message_type == "notification"
      message_js << "cssbox_body-green\">"
    elsif message.player.id == message.game.first_turn
      message_js << "cssbox_body-blue\">"
    else
      message_js << "cssbox_body-red\">"
    end
    message_js << "Does your alien have " if message.message_type == "question"
    if message.message_type == "response"
      if message.content == "Yes"
        message_js << escape_javascript("<div class='yes_button'>Yes</div>")
      elsif message.content == "No"
        message_js << escape_javascript("<div class='no_button'>No</div>")
      end
    else
      logger.info @player.name
      logger.info message.content
      message.content.sub!(/#{@player.name}'s/, "Your") if message.content =~ /#{@player.name}/
      logger.info message.content
      message_js << escape_javascript(message.content)
    end
    message_js << "?" if message.message_type == "question"
    message_js << "</div></div>');api.reinitialise();"
  end
  
  def update_buttons(game, player)
    case game.state
    when "waiting_for_player1_response"
      if player.id == game.players.first.id # player is player 1
        "activate_response_buttons(); deactivate_question_buttons(); activate_chat_button();activate_guess_button();"
      else # player 2
        "deactivate_response_buttons(); deactivate_question_buttons(); activate_chat_button();activate_guess_button();"
      end
    when "waiting_for_player2_response"
      if player.id == game.players.first.id # player is player 1
        "deactivate_response_buttons(); deactivate_question_buttons(); activate_chat_button();activate_guess_button();"
      else # player 2
        "activate_response_buttons(); deactivate_question_buttons(); activate_chat_button();activate_guess_button();"
      end
    when "waiting_for_player1_question"
      if player.id == game.players.first.id # player is player 1
        "deactivate_response_buttons(); activate_question_buttons(); activate_chat_button();activate_guess_button();"
      else # player 2
        "deactivate_response_buttons(); deactivate_question_buttons(); activate_chat_button();activate_guess_button();"
      end
    when "waiting_for_player2_question"
      if player.id == game.players.first.id # player is player 1
        "deactivate_response_buttons(); deactivate_question_buttons(); activate_chat_button();activate_guess_button();"
      else # player 2
        "deactivate_response_buttons(); activate_question_buttons(); activate_chat_button();activate_guess_button();"
      end
    when /won/
      "deactivate_response_buttons(); deactivate_question_buttons();deactivate_guess_button();"
    end
  end
end
