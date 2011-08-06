// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
soundManager.url = '/sounds/'; // override default SWF url
soundManager.debugMode = false;
soundManager.onload = function() {soundManager.createSound('message','/sounds/message.mp3');};
var names = ["Snooz", "Zarg", "Sassle", "Gira", "Zog", "Yop", "Matag", "Pieb", "Uno", "Tonil", "Ufusi", "Veop", "Moog", "Jolod", "Pokov", "Zebo", "Hoobla", "Mush", "Gotat", "Zaphod", "Norboo", "Foobar", "Linrot", "Tag"];

$(document).ready(function() {
  var scrollPaneSettings = {
    showArrows: true,
  };

  var scrollPane = $('#message_panel')
  scrollPane.jScrollPane(scrollPaneSettings);
  api = scrollPane.data('jsp');
  
  // initial button state
  deactivate_question_buttons();
  deactivate_response_buttons();
  deactivate_chat_button();

  // quick flip setup
  $('.card_wrapper').quickFlip({ horizontal: true, panelWidth: 77, panelHeight: 102});
  //deactivate buttons

  // periodic call
  periodic = $.periodic({period: 5000, decay: 1.0}, function() {
    message_url = '/messages?game_id='  + $('#question_game_id').val() + '&player_id=' + $('#question_player_id').val();
    $.ajax({url: message_url });
  });
  
  
  /*
  $('#stop').click(function(){periodic.cancel();});
  $('#start').click(function(){periodic.reset();});*/



  //submit question
  $('#question_form').submit(function(){
    if ($('#question_content').val() == ""){
      return false;
    }
  });
  $("#question_form").bind('ajax:success', function(data, status, xhr) {
    $('#question_content').val("");
  });
  
  //submit chat
  $('#chat_form').submit(function(){
    if ($('#chat_content').val() == ""){
      return false;
    }
  });
  $("#chat_form").bind('ajax:success', function(data, status, xhr) {
    $('#chat_content').val("");
  });
  
  $('.guess_button').click(function(){check_cards()});
  
  $('#submit_final_no').live('click',function(){
    $('#notice_modal').trigger('reveal:close');
  });
  $('#submit_final_yes').live('click',function(){
    var final_card = $('#final_table').attr('final-card');
    var game_id = $('#question_game_id').val();
    var player_id = $('#question_player_id').val();
    $.ajax({
      type: 'DELETE',
      url: "/games/" + game_id,
      data: {final_card: final_card, player_id: player_id},
    });
  });
/*  $("#notice_modal").bind('reveal:open', function(){
    $.metronome.stop();
  });*/
  
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
  $(this).unbind('click', response_via_ajax);
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
  $('#yes_button,#no_button').unbind('click', response_via_ajax);
  $('#yes_button,#no_button').bind('click', response_via_ajax);
    
}
// chat button
function deactivate_chat_button(){
  $('#chat_button').attr("disabled", "true");
}

function activate_chat_button(){
  $('#chat_button').removeAttr("disabled");
}
// guess button
function deactivate_guess_button(){
  $('.guess_button').css('background', 'url("/images/greyed_out_button.png")');
  $('.guess_button').css('border', '2px solid #AAAAAA');
  $('.guess_button').attr("disabled", "true");
}

function activate_guess_button(){
  $('.guess_button').css('background', 'url("/images/guess_button.png")');
  $('.guess_button').css('border', '2px solid #313131');
  $('.guess_button').removeAttr("disabled");
}

function reveal_final_submit(final_card){
  $("#notice_modal_content").html("<table id='final_table' final-card='" + final_card + "'><tr align='center'><td>Do you want to guess that the card is</td><td>&nbsp;</td></tr>" + "<tr align='center'><td><img src='/images/" + final_card + ".png'/></td><td><div id='submit_final_yes' class='yes_button'>Yes</div><br><br><br><div id='submit_final_no' class='no_button'>No&nbsp;</div></td></tr><tr align='center'><td>"+ names[parseInt(final_card)-1] + "?</td><td>&nbsp;</td></tr></table>");
  $("#notice_modal").reveal();
}

function reveal_final_message(heading, message){
  $("#notice_modal h1").html(heading);
  $("#notice_modal_content").html(message);
  $("#notice_modal").reveal();
}

function check_cards(){
  var number_of_eliminated_cards = 0;
  var cards_in_play = [];
  $(".card_wrapper").children().children(".front_of_card").each(function(){
    if ($(this).parent().css('display') == "none"){
      number_of_eliminated_cards = number_of_eliminated_cards + 1;
    } else {
      var image_src = $(this).attr('src');
      var regexp = /(\d+)\.png/;
      var match = regexp.exec(image_src);
      cards_in_play.push(match[1]);
    }
  });
  if (number_of_eliminated_cards == 22){
    reveal_final_submit(cards_in_play[0])
  }
}