// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
soundManager.url = '/sounds/'; // override default SWF url
soundManager.debugMode = false;
soundManager.onload = function() {soundManager.createSound('message','/sounds/message.mp3');};
$(function()
{
  var scrollPaneSettings = {
    showArrows: true,
  };

  var scrollPane = $('#message_panel')
  scrollPane.jScrollPane(scrollPaneSettings);
  api = scrollPane.data('jsp');

  // quick flip setup
  $('.card_wrapper').quickFlip({ horizontal: true, panelWidth: 77, panelHeight: 102});
  //deactivate buttons
  deactivate_question_buttons();
  deactivate_response_buttons();

  // peridic call
  periodic = $.periodic({period: 5000, decay: 1.0}, function() {
    message_url = '/messages?game_id='  + $('#question_game_id').val() + '&player_id=' + $('#question_player_id').val();
    $.ajax({url: message_url });
  });
  $('#stop').click(function(){periodic.cancel();});
  $('#start').click(function(){periodic.reset();});



  //submit question
  $('#question_form').submit(function(){
    if ($('#question_content').val() == ""){
      return false;
    }
  });
  // $("#question_form").bind('ajax:success', function(data, status, xhr) {
  //   $('#question_content').val("");
  // });

});

// question buttons
var add_question_word = function(){
   $('#question_content').val($('#question_content').val() + $(this).html() + " ");
};
function deactivate_question_buttons(){
  $('.word_button').css('background', 'url("/images/greyed_out_button.png")');
  $('.word_button').css('border', '2px solid #AAAAAA');
  $('.word_button').unbind('click', add_question_word);
  $('#question_submit').attr("disabled", "true");
}

function activate_question_buttons(){
  $('.word_button').css('background', 'url("/images/question_button.png")');
  $('.word_button').css('border', '2px solid #313131');
  $('.word_button').unbind('click', add_question_word);
  $('.word_button').bind('click', add_question_word);
  $('#question_submit').removeAttr("disabled");
}
// yes no buttons
var response_via_ajax = function() {
  $.ajax({
    type: 'POST',
    url: "/messages",
    data: {
      'message[message_type]': $(this).attr('message_type'), 
      'message[game_id]': $(this).attr('game_id'),
      'message[player_id]': $(this).attr('player_id'),
      'message[content]': $(this).attr('message_content')
    }
  });
};
function deactivate_response_buttons(){
  $('#yes_button,#no_button').css('background', 'url("/images/greyed_out_button.png")');
  $('#yes_button,#no_button').css('border', '2px solid #AAAAAA');
  $('#yes_button,#no_button').unbind('click', response_via_ajax);
  
}
function activate_response_buttons(){
  $('#yes_button').css('background', 'url("/images/yes_button.png")');
  $('#no_button').css('background', 'url("/images/no_button.png")');
  $('#yes_button,#no_button').css('border', '2px solid #313131');
  $('#yes_button,#no_button').bind('click', response_via_ajax);
    
}
// chat buttons
function deactivate_chat_button(){
  $('#chat_button').attr("disabled", "true");
}

function activate_chat_button(){
  $('#chat_button').attr("disabled", "false");
}